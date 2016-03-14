import shelve, struct, io, imp, ctypes, re
import os, sys, os.path, time, random, math

cache_cache = {}
import pickle

class BasicShelve:
  def __init__(self, path):
    self.path = path
      
    if not os.path.exists(path):
      self.data = {}
    else:
      self.file = open(path, "rb");
    #try:
      self.data = pickle.loads(self.file.read())
      #print("data: ", self.data)
      #sys.exit(-1)
    #except:
    #  self.data = {}
    
      self.file.close()
    
  def sync(self):
    buf = pickle.dumps(self.data)
    
    self.file = open(self.path, "wb")
    self.file.write(buf)
    self.file.close()
  
  def close(self):
    self.sync()
    
  def __getitem__(self, k):
    return self.data[k]
    
  def __setitem__(self, k, v):
    self.data[k] = v
    
  def __contains__(self, k):
    return k in self.data
 
  def __iter__(self):
    return iter(self.data)
  
  def __delitem__(self, k):
    del self.data[k]
    
class CachedDB:
  def __init__(self, db, name=None):
    self.db = db
    
    if name != None:
      if name not in cache_cache:
        cache_cache[name] = {}
      self.cache = cache_cache[name]
    else:
      self.cache = {}
  
  def sync(self):
    self.db.sync()
  
  def close(self):
    self.db.close()
  
  def keys(self):
    return self.db.keys()

  def values(self):
    return self.db.values()
  
  def __iter__(self):
    return self.db.__iter__()
  
  def __getitem__(self, item):
    if item in self.cache:
      return self.cache[item]
    
    ret = self.db[item]
    self.cache[item] = ret
    
    return ret
  
  def __delitem__(self, item):
    del self.db[item]
    if item in self.cache:
      del self.cache[item]
      
  def __setitem__(self, item, val):
    self.db[item] = val
    self.cache[item] = val
  
  def __contains__(self, item):
    return item in self.cache or item in self.db
  
  