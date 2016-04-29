#include "../../libc/libk.h"
#include "../../libc/kmalloc.h"
#include "../../libc/string.h"
#include "../../libc/stdio.h"
#include "../../libc/list.h"
#include "../../timer.h"
#include "../../task/task.h"
#include "../../task/process.h"
#include "../../task/rwlock.h"
#include "../../io.h"
#include "../../interrupts.h"

#include "../fs/fs_interface.h"
#include "../fs/fs_file.h"

typedef struct ProcDir {
  int pid, i; //-1 means list all processes
  int zombie;
  int *pids, totpid; //used when pid is -1
} ProcDir;

typedef struct ProcFile {
  int pid, tid, type;
} ProcFile;

typedef struct ProcFS {
  FSInterface head;
  
} ProcFS;

//procfile->type
enum {
  PROC_NAME,
  PROC_RUNTIME,
  PROC_STATE,
  PROC_MEMUSAGE
};

char *mystrdup(const char *str) {
  char *ret = kmalloc(strlen(str)+1);
  strcpy(ret, str);
  
  return ret;
}

static char *procfs_getdata_name(ProcFile *file) {
  return mystrdup("nothing");
}
static char *procfs_getdata_runtime(ProcFile *file) {
  return mystrdup("nothing");
}
static char *procfs_getdata_state(ProcFile *file) {
  return mystrdup("nothing");
}
static char *procfs_getdata_memusage(ProcFile *file) {
  return mystrdup("nothing");
}

static struct {
  char name[32];
  
  //make sure to free afterwards
  char *(*getdata)(ProcFile *file);
} commandmap[] = {
  {"name", procfs_getdata_name},
  {"runtime", procfs_getdata_runtime},
  {"state", procfs_getdata_state},
  {"memusage", procfs_getdata_memusage}
};
static int totcommand = sizeof(commandmap) / sizeof(*commandmap);

static ProcFS procfs;

static int parse_path(ProcFS *fs, const char *path, ProcFile *file) {
  unsigned char *c = (unsigned char*) path;
  int len;
  
  c += strspn(c, "\r\n\t\b\v /");
  
  if (!*c) {
    _fs_error(fs, -1, "Invalid/empty path");
    return -1;
  }
  
  int pid = atoi(c);
  if (pid == 0) {
    _fs_error(fs, -1, "bad pid");
    return -1;
  }
  
  file->pid = pid;
  c += strspn(c, "0123456789/");
   
  len = strcspn(c, "/");
  c[len] = 0;
  
  int i = 0;
  
  for (i=0; i<totcommand; i++) {
    if (!strcmp(commandmap[i].name, c)) {
      break;
    }
  }
  
  if (i == totcommand) {
    _fs_error(fs, -1, "bad path");
    return -1;
  }
  
  file->type = i;
  
  return 0;
}

static int encode_file(ProcFile *file) {
  return file->pid | file->type<<22;
}

static int decode_file(int fd, ProcFile *file) {
  file->pid = fd & ((1<<22)-1);
  file->type = fd>>22;
  
  return file->type >= 0 && file->type <= totcommand ? 0 : -1;
}

static int procfs_open(void *vself, BlockDeviceIF *device, const char *utf8path, int utf8path_size, int oflag) {
  ProcFS *self = vself;
  ProcFile file = {0,};
  
  int ret = parse_path(self, utf8path, &file);
  
  if (ret < 0) {
    return ret;
  }
  
  return encode_file(&file);
}

static int procfs_pread(void *vself, BlockDeviceIF *device, int internalfd, const char *buf, size_t bufsize, size_t fileoff) {
  ProcFile file = {0,};
  
  if (decode_file(internalfd, &file) < 0) {
    _fs_error(vself, -1, "Bad file descriptor");
    return -1;
  }
  
  char *data = commandmap[file.type].getdata(&file);
  if (!data) {
    return 0;
  }
  
  size_t size = strlen(data);
  
  if (fileoff > size) {
    _fs_error(vself, -1, "Invalid range");
    return -1;
  }
  
  data += fileoff;
  size -= fileoff;
  
  if (size > bufsize) {
    size = bufsize;
  }
  
  memcpy((void*)buf, (void*)data, size);  
  return size;
}

static int procfs_path_to_inode(void *self, BlockDeviceIF *device, const char *utf8path, int utf8path_size) {
  return procfs_open(self, device, utf8path, utf8path_size, O_RDONLY);
}

static int procfs_stat(void *vself, BlockDeviceIF *device, int inode, struct stat *buf) {
  ProcFile file = {0};
  
  if (decode_file(inode, &file) < 0) {
    _fs_error(vself, -1, "invalid file descriptor");
    return -1;
  }
  
  memset(buf, 0, sizeof(*buf));
  
  char *data = commandmap[file.type].getdata(&file);
  
  buf->st_ino = inode;
  buf->st_size = !data ? 0 : strlen(data);
  
  kfree(data);
  
  return 0;
}

static int procfs_accessmode(void *self, BlockDeviceIF *device) {
  return O_RDONLY;
}

//XXX there is a memory leak here.
//    we're not keeping track of per-process opendir handles.
//    so if a process forgets to call closedir, it will leak
//    when process exits

static int procfs_opendir_inode(void *vself, BlockDeviceIF *device, DIR *vdir, int inode) {
  ProcDir *dir = (ProcDir*)vdir;
  
  memset(dir, 0, sizeof(dir));
  
  dir->pid = inode; //-1 means list root procfs directory
  
  if (inode == -1) {
    int size = 32;
    dir->pids = kmalloc(sizeof(int)*size);
    dir->totpid = 0;
    
    extern RWLock _procsys_lock;
    extern List running_processes;
    
    krwlock_rlock(&_procsys_lock);
    for (Process *p = running_processes.first; p; p=p->next) {
      if (dir->totpid >= size) {
        size *= 2;
        dir->pids = krealloc(dir->pids, sizeof(int)*size);
        
        if (!dir->pids) { //out of memory
          return -1;
        }
      }
      
      dir->pids[dir->totpid++] = p->pid;
    }
    krwlock_unrlock(&_procsys_lock);
  }
  
  return 0;
}

static DIR *procfs_closedir(void *self, BlockDeviceIF *device, DIR *vdir) {
  ProcDir *dir = (ProcDir*)vdir;
  
  if (dir->zombie) {
    _fs_error(self, -1, "directory stream already closed");
    return NULL;
  }
  
  dir->zombie = 1;
  
  if (dir->pids) {
    kfree(dir->pids);
  }
  
  return NULL;
}

int procfs_readdir(void *vself, BlockDeviceIF *device, struct dirent *entry, DIR *vdir) {
  ProcDir *dir = (ProcDir*)vdir;
  
  if (dir->zombie) {
    _fs_error(vself, -1, "directory stream already closed");
    return -1;
  }
  
  if (dir->pid == -1) {
    if (dir->i >= dir->totpid) {
      return -1; //end of directory stream
    }
    
    sprintf(entry->d_name, "%d", dir->pids[dir->i]);
    entry->d_ino = dir->pids[dir->i];
    
    dir->i++;
  } else {
    if (dir->i >= totcommand) {
      return -1; //end of directory stream
    }
    
    ProcFile file = {0,};
    file.pid = dir->pid;
    file.type = dir->i;
    
    strlcpy(entry->d_name, commandmap[dir->i].name, sizeof(entry->d_name));
    entry->d_ino = encode_file(&file);
  }
  
  return 0;
}

static int procfs_opendir(void *vself, BlockDeviceIF *device, DIR *dir, const char *path) {
  if (*path == 0 || (*path == '/' && strlen(path) == 1)) {
    return procfs_opendir_inode(vself, device, dir, -1);
  } else {
    ProcFile file = {0,};
    
    int ret = parse_path(vself, path, &file);
    if (ret < 0) {
      return ret;
    }
    
    return procfs_opendir_inode(vself, device, dir, file.pid);
  }
}

FSInterface *init_procfs() {
  memset(&procfs, 0, sizeof(&procfs));
  _fs_fsinterface_init((FSInterface*) &procfs);
  
  procfs.head.accessmode = procfs_accessmode;
  procfs.head.open = procfs_open;
  procfs.head.pread = procfs_pread;
  procfs.head.path_to_inode = procfs_path_to_inode;
  procfs.head.stat = procfs.head.fstat = procfs_stat;
  
  procfs.head.readdir = procfs_readdir;
  procfs.head.opendir = procfs_opendir;
  procfs.head.closedir = procfs_closedir;
  
  return (FSInterface*)&procfs;
}
