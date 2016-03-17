#!/usr/bin/env python3

def cp_handler(file, target):
  if win32:
    return "copy %s %s" % (np(file), np(target)) #file.replace("/", "\\"), target.replace("/", "\\"))
  else:
    return "cp %s %s" % (file, target)

CFLAGS="-g -fno-omit-frame-pointer -Wpadded -Wredundant-decls"
CFLAGS += " -fno-strict-aliasing -D__KERNEL_BUILD__  -c -funsigned-char"
CFLAGS += " -ffreestanding -O2 -Wall -Wextra -std=gnu99 -funsigned-char  -Wno-pointer-sign "
CFLAGS += " -Wno-unused-function -Wno-unused-parameter"

def cc_handler(file, target):
  if target.strip().lower().endswith(".c"):
    target = target[:-2] + ".o"
    
  return os.environ["TARGET"] + "-gcc -c " + file + " -o " + target + " " + CFLAGS

def nasm_handler(file, target):
  return "nasm %s -felf32 -o %s" % (file, target)
  
def ld_handler(file, target):
  s = os.environ["TARGET"] + "-gcc -fno-asynchronous-unwind-tables -funsigned-char "
  s += "-T %s -o %s -ffreestanding -O2 -nostdlib  -lgcc -funsigned-char" % (file, target)
  return s
  
def custom_handler(file, target):
  return file
  
class Handler (object):
  def __init__(self, func, can_popen=True, ext=None, nocheck=False):
    self.ext = ext
    self.use_popen = can_popen
    self.func = func
    self.nocheck = nocheck
    
  def transform_ext(self, path):
    if self.ext is None:
      return path
    
    path = path.strip()
    if path.lower().endswith(self.ext[0]):
      path = path[:-len(self.ext[0])] + self.ext[1]
    return path
    
handlers = {
  r'.*\.c\b'    : Handler(cc_handler, can_popen=False, ext=[".c", ".o"]),
  r'.*\.html\b' : Handler(cp_handler, can_popen=False),
  r'.*\.png\b'  : Handler(cp_handler, can_popen=False),
  r'.*\.txt\b'    : Handler(cp_handler, can_popen=False),
  r'.*\.nasm\b'   : Handler(nasm_handler, can_popen=False, ext=[".nasm", ".o"]),
  #r'.*\.ld\b'     : Handler(ld_handler, can_popen=True, ext=[".ld", ".bin"]),
  r'.*\.custom\b'    : Handler(custom_handler, can_popen=False, nocheck=True)
}

#transform_ext
def get_handler(path):
  re_size = 0
  for k in handlers:
    if re.match(k, path) and len(k) > re_size:
      return handlers[k]
   
def transform_ext(path):
    h = get_handler(path)
    
    if h is not None:
      return h.transform_ext(path)
    return path

import os, sys, os.path, time, random, math
import shelve, struct, io, imp, ctypes, re
import subprocess, shlex, signal
from ctypes import *
import imp, runpy
from math import floor
import zipfile

from dbcache import CachedDB, BasicShelve

#normpath helper func
def np(path):
  return os.path.abspath(os.path.normpath(path))

sp = os.path.sep
sep = os.path.sep

REBUILD = 1
WASBUILT = 2

def py_ctrl_c_handler(ctrltype):
  print("handler!", ctrltype)
  
  if ctrltype != 0: return 0
  return -1;
  
def ignore_ctrl_c():
  return
  k32 = windll.kernel32
  #"""
  print(k32.SetConsoleCtrlHandler.argtypes)
  k32.SetConsoleCtrlHandler(ctrl_c_handler1, c_int(1));
  #"""
  return
  
  STD_INPUT_HANDLE = 0xfffffff6
  handle = k32.GetStdHandle(STD_INPUT_HANDLE);
  print("handle", handle)
  ENABLE_PROCESSED_INPUT = 0x0001
  
  print(POINTER(c_int)(c_long(handle)));
  
  st = (c_int*2)();
  k32.GetConsoleMode(handle, st)
  mode = st[0]
  print("value1 ", st[0]);
  
  #if mode & ENABLE_PROCESSED_INPUT:
  print("result", k32.SetConsoleMode(c_long(handle), c_int(ENABLE_PROCESSED_INPUT)))
  
  st = (c_int*2)();
  mode = k32.GetConsoleMode(handle, st)
  print("value2 ", st[0]);
  
  
sep = os.path.sep
def modimport(name):
  cwd = os.path.abspath(os.path.normpath(os.getcwd()))
  path = cwd + sep + name + ".py"
  
  mfile = open(path, "r")
  mod = imp.load_module(name, mfile, path, ('.py', 'r', imp.PY_SOURCE)) #runpy.run_path(cwd + sep + path + ".py")
  
  return mod

try:
  a = FileNotFoundError
except:
  FileNotFoundError = IOError

def config_tryimp(name):
  try:
    mod = modimport(name)
  except (IOError, FileNotFoundError):
    return {}
  return mod.__dict__

config_dict2 = config_tryimp("kbuild_sources")
config_dict = config_tryimp("build_local")

def validate_cfg(val, vtype):
  if vtype == "bool":
    if type(val) == str:
      return val.lower() in ["0", "1", "true", "false", "yes", "no"]
    elif type(val) == int:
      return val in [0, 1]
    else: return val in [True, False]
  elif vtype == "int":
    return type(val) in [int, float] and floor(val) == val
  elif vtype == "path":
    return os.path.exists(val)
  
  else: return True

localcfg = {}
localcfg_core = {}
def getcfg_intern(key, default, type, env, localcfg):
  if key in env:
    val = env[key]
    if not validate_cfg(val, type):
      raise RuntimeError("Invalid value for " + key + ": " + str(val))
    
    localcfg[key] = val
    
    return val
  return default

def getcfg(key, default, type):
  return getcfg_intern(key, default, type, config_dict, localcfg)

def getcorecfg(key, default, type):
  return getcfg_intern(key, default, type, config_dict2, localcfg_core)

def addslash(path):
  while path.endswith("/"): path = path[:-2]
  while path.endswith("\\"): path = path[:-2]
  
  path += sep
  return path
  
num_cores = getcfg("num_cores", 1, "int")

build_path = getcorecfg("build_path", "build", "string")
target_path = getcorecfg("target_path", build_path, "string")
db_path = getcorecfg("db_path", ".build_db/", "string")

build_path = addslash(build_path)
target_path = addslash(target_path)
db_path = addslash(db_path)

if not os.path.exists(db_path):
  os.mkdir(db_path)

def np(path):
  return os.path.abspath(os.path.normpath(path))
  
open_dbs = {}
open_paths = {}
_pathmap = {}
_in_db_func = False

def open_db(path):
  global open_dbs, db_path, _pathmap, open_paths, _in_db_func
  
  path = db_path + path
  
  pathkey = np(path)
  if pathkey in open_paths:
    return open_paths[pathkey]
  
  _in_db_func = True
  #CachedDB(shelve.open(path), pathkey)
  
  db = CachedDB(BasicShelve(path), pathkey)
  _in_db_func = False
  
  open_dbs[id(db)] = db
  open_paths[pathkey] = db
  _pathmap[id(db)] = pathkey
  
  return db
  
def close_db(db):
  _in_db_func = True
  db.close()
  _in_db_func = False
  
  del open_dbs[id(db)]
  del open_paths[_pathmap[id(db)]]
  del _pathmap[id(db)]

libc = None
def load_libc():
  global libc
  try:
    libc = cdll.msvcrt 
  except:
    try:
      i = 6
      base = "libc.so."
      while i <20:
        name = base + str(i)
        libc = LoadLibrary(name)
        if libc != undefined: break
        i += 1
    except:
      print("failed to load libc!")
      sys.exit(-1)
  print("loaded libc!")

open_dbs = {}
procs = []
signal_called = False
def signal_handler(signal1, stack):
  global open_dbs, signal_called
  
  if signal_called: return
  
  signal_called = True

  print("\n\n---==============================---")
  sys.stderr.write("signal caught; closing databases. . .\n")
  
  for db in open_dbs.values():
    print("----------- closing database. . .")
    db.close()
  
  open_dbs = {}
  
  sys.stderr.write("done.\n\n")
  
  #import traceback
  #traceback.print_stack()
  #traceback.print_last()

  sys.exit(-1)
  
if len(localcfg) > 0:
  print("build config:")
  keys = list(localcfg.keys())
  keys.sort()
  for key in keys:
    val = localcfg[key]
    print("  " + key + ": " + str(val)) 
    
  print("\n")

class Source:
  def __init__(self, f):
    self.source = f
    self.target = ""
    self.build = False
    
  def __str__(self):
    return self.source + ":" + self.target
    
  def __repr__(self):
    return str(self)
  
class Target (list):
  def __init__(self, target):
    list.__init__(self)
    self.target = target
    self.optional = False 
    
  def replace(self, a, b):
    self[self.index(a)] = b

srcmod = modimport("kbuild_sources")

copy_targets = []
if hasattr(srcmod, "copy_targets"):
  for f1 in srcmod.copy_targets:
    tpath = "build"+sep+f1
    f2 = srcmod.copy_targets[f1]
    target = Target(tpath)
    
    s = Source(np(f2))
    s.target = tpath
    target.append(s)
    target.optional = False 
    
    copy_targets.append(target)

if hasattr(srcmod, "optional_copy_targets"):
  for f1 in srcmod.optional_copy_targets:
    tpath = "build"+sep+f1
    f2 = srcmod.optional_copy_targets[f1]
    target = Target(tpath)
    
    s = Source(np(f2))
    s.target = tpath
    target.append(s)
    target.optional = True
    
    copy_targets.append(target)

targets2 = srcmod.targets
targets = []
for k in targets2:
  targets.append(Target(k))
  for s in targets2[k]:
    targets[-1].append(Source(s))
    

db = None
db_depend = None

filter = ""
if len(sys.argv) > 1:
  if len(sys.argv) == 3:
    build_cmd = sys.argv[1].lower()
    filter = sys.argv[2]
  else:
    build_cmd = sys.argv[1].lower()
    if build_cmd not in ["build", "cleanbuild", "clean", "loop"]:
      filter = build_cmd
      build_cmd = "single"
else:
  filter = ""
  build_cmd = "build"

if build_cmd == "clean": build_cmd = "cleanbuild"
if not os.path.exists("build"):
  os.mkdir("build")

_fmap = {}
for t1 in targets:
  for f1 in t1:
    f1.source_abs = np(f1.source)
    _fmap[f1.source_abs] = f1
    
for t1 in targets:
  for i, f1 in enumerate(t1):
    if f1.source_abs in _fmap:
      t1[i] = _fmap[f1.source_abs]

#read sources
for t in targets:
  for f in t:
    if sp in f.source or "/" in f.source:
      f2 = os.path.split(f.source)[1]
    else:
      f2 = f.source
    f.target = transform_ext(build_path + f2);

win32 = sys.platform == "win32"
PYBIN = sys.executable
if PYBIN == "":
  sys.stderr.write("Warning: could not find python binary, reverting to default\n")
  PYBIN = "python3.2"

PYBIN += " "
PYBIN = getcfg("PYBIN", PYBIN, "path") + " "
print("using python executable \"" + PYBIN.strip() + "\"")

def iter_files(files):
  for f in files:
    abspath = os.path.abspath(os.path.normpath(f.source))
    yield [f.source, f.target, abspath, f.build]
    
def resolve_path(basepath, path):
  path2 = os.path.join(os.path.split(basepath)[0], path)
  if os.path.exists(path2):
    return path2
    
  if os.path.exists(path):
    return path
  return path
  
#dest depends on src
def add_depend(dest, src):
  src = resolve_path(dest, src)
  
  if not os.path.exists(src):
    sys.stderr.write("\n%s: Could not find include file\n\t%s!\n"%(dest, src))
    #sys.exit(-1)
    
  src = os.path.abspath(os.path.normpath(src))
  dest = os.path.abspath(os.path.normpath(dest))
  
  if dest not in db_depend:
    db_depend[dest] = set()
  
  fset = db_depend[dest]
  fset.add(src)
  
  db_depend[dest] = fset
  
def nocheck(f):
  h = get_handler(f)
  
  if h is not None and h.nocheck:
    return True
    
  return False
  
def build_depend(f):
  if f.endswith(".png"): return
      
  prof_start("build_depend")
  file = open(f, "r")

  for line in file.readlines():
    if not (line.strip().startswith("#") and "include" in line and '"' in line):
      continue
    
    line = line.strip().replace("\n", "").replace("\r", "")
    
    i = 0
    in_str = 0
    filename = ""
    word = ""
    while i < len(line):
      c = line[i]
      if c in [" ", "\t", "#"]:
        i += 1
        continue
      elif c == '"':
        if in_str:
          break
        else:
          in_str = True
      elif c == "<" and not in_str:
        in_str = True
      elif c == ">" and in_str:
        in_str = False
        break
      else:
        if in_str:
          filename += c
        else:
          word += c
      i += 1
    add_depend(f, filename)
    
  prof_end("build_depend")

def safe_stat(path, nocheck=False):
  if nocheck:
    return 0
    
  if not os.path.exists(path):
    return -1
    
  #try:
  return os.stat(path).st_mtime
  #except FileNotFoundError:
  #  return 0
  #except OSError:
  #  return random()*(1<<22)
  #except IOError:
  #  return random()*(1<<22)
  
def do_rebuild(abspath, targetpath, nocheck1 = False):
  prof_start("do_rebuild")
  
  global db, db_depend
  
  fname = os.path.split(abspath)[1]
  
  if nocheck1:
    return True
    
  if nocheck1 or not os.path.exists(targetpath):
    print("Missing: ", targetpath)
    return True
    
  if "[Conflict]" in abspath: 
      prof_end("do_rebuild")
      return False
  
  if build_cmd in ["filter", "single"] and fname.lower() not in filter:
    prof_end("do_rebuild")
    return False
  
  if abspath not in db or build_cmd in ["cleanbuild", "single"]:
    prof_end("do_rebuild")
    sys.stderr.write("not in db! " + abspath + "\n");
    #print("not in db!", abspath)
    return True
  
  if safe_stat(abspath) != db[abspath]:
    prof_end("do_rebuild")
    print("time update!", abspath)
    
    return True
  
  if abspath in db_depend:
    #build_depend(abspath)

    if abspath not in db_depend:
      prof_end("do_rebuild")
      return False
    
    for path2 in db_depend[abspath]:
      if path2 in db and safe_stat(path2) != db[path2]:
        print("time update!", path2)
        prof_end("do_rebuild")
        return True
        
      elif path2 not in db:
        if os.path.exists(path2):
          db[path2] = 0
          sys.stderr.write("not in db! " + path2 + "\n");
          prof_end("do_rebuild")
          return True
  
  prof_end("do_rebuild")
  return False

def failed_ret(ret):
  return ret != 0

_profs = {}
def prof_reset():
  global _profs
  _profs = {}
  
def print_profs():
  for name in _profs:
    print(name, _profs[name][0])
    
def prof_start(name):
  global _profs
  if name not in _profs:
    _profs[name] = [0, 0, 0]
  
  p = _profs[name]
  if p[1] > 0:
    p[1] += 1
    return
  
  p[2] = time.time()
  p[1] += 1
  
def prof_end(name):
  if name not in _profs:
    print("Warning: bad call to prof_end for profile name", name)
    return
  
  p = _profs[name]
  p[1] -= 1
  
  if p[1] == 0.0:
    p[0] += time.time() - p[2]
  
def filter_srcs(files, nocheck1=False):
  global db, db_depend
  
  procs = []
  time_start()
  
  db = open_db("kbuild.db")
  db_depend = open_db("kbuild_dependencies.db")
  
  if build_cmd == "cleanbuild":  
    print("CLEAN BUILD!")
    
    for k in db:
      db[k] = 0;
    db.sync();
  
  i = 0;
  for f, target, abspath, rebuild in iter_files(files):
    fname = os.path.split(abspath)[1]
    
    if not do_rebuild(abspath, np(target), nocheck(target) or nocheck1):
      i += 1
      continue
      
    files[i].build = REBUILD
    if not nocheck(target) and not nocheck1:
      build_depend(abspath);
      
    i += 1
  
  close_db(db)
  close_db(db_depend)
  
def build_target(files):
  global db, db_depend, procs
  
  db = open_db("kbuild.db")
  db_depend = open_db("kbuild_dependencies.db")
  
  if build_cmd == "cleanbuild":  
    print("CLEAN BUILD 2!")
    
    for k in db:
      db[k] = 0;
    db.sync();
  
  built_files = []
  failed_files = []
  fi = 0
  
  filtered = list(iter_files(files))
  build_final = False
  nocheck1 = nocheck(files.target)
  
  for f, target, abspath, rebuild in filtered:
    fname = os.path.split(abspath)[1]
    sf = files[fi]
    fi += 1
    
    build_final |= rebuild in [REBUILD, WASBUILT]
    if rebuild != REBUILD: continue
    
    sf.build = WASBUILT
    
    built_files.append([abspath, safe_stat(abspath, nocheck(files.target)), f])
    pathtime = built_files[-1];
    
    re_size = 0
    use_popen = None
    cmd = None
    
    if nocheck1:
      h = get_handler(".custom")
    else:
      h = get_handler(f)
      
    if h is not None:
      if not h.nocheck:
        cmd = h.func(np(f), np(target))
      else:
        cmd = h.func(f, target)
        
      use_popen = h.use_popen
    
    #uncomment to disable all comments, but pretent they succeeded
    #use_popen = False
    #cmd = "echo"
    
    if cmd == None: 
      sys.stderr.write("\nError: Don't know how to build:\n\t%s\n" % f)
      failed_files.append(f)
      break
      
    perc = int((float(fi) / len(filtered))*100.0)
    
    dcmd = os.path.split(f)[1] if ("/" in f or "\\" in f) else f
    print("[%i%%] " % perc, dcmd)
    
    #execute build command
    while len(procs) >= num_cores:
      newprocs = []
      for p in procs:
        if p[0].poll() == None:
          newprocs.append(p)
        else:
          ret = p[0].returncode
          if failed_ret(ret):
            failed_files.append(p[1])
          else:
            print("done!", p[2][0], p[2][1])
            db[p[2][0]] = p[2][1]
            
      procs = newprocs
      time.sleep(0.75)
    
    if len(failed_files) > 0: continue
   
    if use_popen:
      #shlex doesn't like backslashes
      if win32:
        cmd = cmd.replace("\\", "/")
      else:
        cmd = cmd.replace("\\", "\\\\")
      
      #print(" - "+fname) #cmd);
      
      cmdlist = shlex.split(cmd)
      #cmdlist[0] = np(cmdlist[0])
      proc = subprocess.Popen(cmdlist)
      procs.append([proc, f, pathtime])
    else:
      #print(" - "+fname) #cmd);
      ret = os.system(cmd)
      
      if failed_ret(ret):
        failed_files.append(f)
      else:
        db[pathtime[0]] = pathtime[1]
  
  while len(procs) > 0:
    newprocs = []
    for p in procs:
      if p[0].poll() == None:
        newprocs.append(p)
      else:
        ret = p[0].returncode
        if failed_ret(ret): #ret in [-1, 65280]:
          failed_files.append(p[1])
          
    procs = newprocs
    time.sleep(0.75)
    
  if len(failed_files) > 0:
    print("build failure %s\n\n" % ([f[1] for f in built_files]))
    #built2 = built_files[:]
    
    for f in failed_files:
      for i, f2 in enumerate(built_files):
        if f2[2] == f:
          built_files.pop(i)
          break

    for pathtime in built_files:
      if pathtime[0] in db:
        print("saving", db[pathtime[0]], pathtime[1])
      else:
        print("saving", pathtime[1]);
      db[pathtime[0]] = pathtime[1]
    
    close_db(db)
    close_db(db_depend)
    
    if build_cmd != "loop":
      sys.exit(-1)
    else:
      return 0
  
  badset = set()
  
  #figure out which dependencies with time updates to save
  for k in db_depend:
    bad = 0
    for f in failed_files:
      if k == failed_files[2]:
        bad = 1
        break
    if not bad:
      continue
    
    for path in db_depend[k]:
      badset.add(path)
      
  for k in db_depend:
    for path in db_depend[k]:
      if path in badset or not os.path.exists(path): continue
      db[path] = safe_stat(path)
      
  for pathtime in built_files:
    if pathtime[0] in db:
      print("saving", db[pathtime[0]], pathtime[1])
    db[pathtime[0]] = pathtime[1]
  
  close_db(db)
  close_db(db_depend)
  
  #write aggregate, minified file
  if build_final:
    sys.stdout.flush()
    
  if build_cmd != "loop":
    print("build finished")
    
  return build_final

def do_copy_targets():
  global copy_targets
  global db, db_depend
  
  db = open_db("kbuild.db")
  db_depend = open_db("kbuild_dependencies.db")
  
  build_final = False
  
  try:
    for f in copy_targets:
      abspath = np(f.target)
      src = f[0].source
      
      if f.optional and not os.path.exists(f[0].source):
        continue
      
      fname = f[0].source
      if (os.path.sep in fname):
        fname = os.path.split(fname)[1]
        
      stat = safe_stat(f[0].source)
      skip = not (abspath not in db or db[abspath] < stat)
      skip = skip and not build_cmd == "clean";
      skip = skip and not (build_cmd == "single" and  filter.lower() in abspath.lower())
      skip = skip and not (build_cmd == "single" and  filter.lower() in f[0].source.lower())
      
      if skip:
        continue

      build_final = True
      
      #db[abspath] = stat
      cmd = cp_handler(src, abspath)
      print(cmd)
      ret = os.system(cmd)
      
      if ret == 0:
        db[abspath] = stat
      else:
        print("build failure\n\n")

        sys.stderr.write("build failure\n");
        if build_cmd != "loop":
          sys.exit(-1)
        else:
          break
  except:
    import traceback
    
    db.close()
    db_depend.close()
    
    traceback.print_stack()
    traceback.print_last()
  
  return build_final
  
_timestart = []
def time_start():
  global _timestart
  _timestart.append(time.time())

def time_end():
  global _timestart
  t = _timestart.pop(-1);
  return time.time() - t

def py_lowlevel_signal(signal1):
  return 0


def buildall():
  try:
    buildall_intern()
  except KeyboardInterrupt:
    pass
    signal_handler(None, None)
    
def save_depend_times():
  db = open_db("kbuild.db")
  db_depend = open_db("kbuild_dependencies.db")
  
  for k in db_depend:
    for path in db_depend[k]:
      if os.path.exists(path):
        db[path] = safe_stat(path)
      
  close_db(db_depend)
  close_db(db)

def buildall_intern():
  for t in targets:
    for s in t:
      s.build = False;
  
  for t in targets:
    #if nocheck(t.target):
    #  continue
      
    filter_srcs(t, nocheck(t.target))
  
  build_final = False
  for t in targets:
    build_final |= build_target(t)
  
  
  save_depend_times()
  
  build_final |= do_copy_targets()
  if build_final:
    pass
  
def themain():  
  #print("         themain!", build_cmd)
  if build_cmd == "loop":
    ignore_ctrl_c()
    while 1:
      prof_reset()
      
      start = time.time();
      buildall()
      #print_profs()
      
      t = time.time() - start
      if (t < 1.5):
        time.sleep(1.5 - t+0.1);
      else:
        time.sleep(0.1);
  else:
    buildall()

if __name__ == "__main__":
  ret = 0
  try:
    themain()
  except KeyboardInterrupt:
    signal_handler(None, None)
    ret = -1
  
  print("main exit!")
  sys.exit(ret)
