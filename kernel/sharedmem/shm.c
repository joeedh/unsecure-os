#include "shm.h"
#include "shm_file.h"

#include <stddef.h>
#include <stdint.h>

#include "../libc/libk.h"
#include "../libc/kmalloc.h"
#include "../libc/string.h"
#include "../libc/list.h"
#include "../task/task.h"
#include "../task/process.h"
#include "../task/lock.h"
#include "../task/rwlock.h"
#include "../io.h"

static List open_shms = {NULL, NULL};

SharedMemFS *_shm_get(unsigned char *path) {
  LinkNode *node;
  for (node=open_shms.first; node; node=node->next) {
    SharedMemFS *shm = (SharedMemFS*) node->data;
    
    if (strcmp(path, shm->name)) {
      return shm;
    }
  }
  
  return NULL;
}

int shm_open(unsigned char *utf8path, int oflag, int omode) {
  SharedMemFS *shm = _shm_get(utf8path);
  
  if (!shm) {
    shm = (SharedMemFS*) make_shared_mem();
    strlcpy(shm->name, utf8path, sizeof(shm->name));
    LinkNode *node = kmalloc(sizeof(LinkNode));
    node->data = shm;
    
    klist_append(&open_shms, node);
  }
  
  if (oflag & O_TRUNC) {
    shm->head.ftruncate(shm, NULL, 0, 0);
  }
  
  FSFile *file = kmalloc(sizeof(FSFile));
  
  _fs_file_init(file);
  file->fs = (FSInterface*) shm;
  file->access = file->mode = O_RDWR; //|O_EXEC;
  
  return (int)file;
}
