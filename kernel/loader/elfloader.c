#include "elfloader.h"

#include "../libc/string.h"
#include "../libc/stdio.h"
#include "../libc/kmalloc.h"
#include "../libc/ctype.h"
#include "../libc/libk.h"

//#define ELF_DEBUG

#ifdef ELF_DEBUG
#define elfdebug(...) e9printf(__VA_ARGS__)
#else
#define elfdebug(...)
#endif

#ifndef MAX2
#define MAX2(a, b) ((a) > (b) ? (a) : (b))
#endif

#ifndef MIN2
#define MIN2(a, b) ((a) < (b) ? (a) : (b))
#endif

static Symbol *alloc_symbol(ElfFile *file) {
  if (file->totsymbol >= file->totsymalloc) {
    file->totsymalloc = (file->totsymalloc+1)*2;
    size_t size = sizeof(Symbol)*file->totsymalloc;
    
    file->symbols = !file->symbols ? kmalloc(size) : krealloc(file->symbols, size);
  }
  
  return file->symbols + file->totsymbol++;
}

ElfSection *get_section(ElfFile *file, int idx) {
  ElfSection *ss;
  int i = 0;
  
  for (ss=file->sections.first; ss; ss=ss->next) {
    if (i == idx) {
      return ss;
    }
    
    i++;
  }
  
  return NULL;
}

static void read_symbols(ElfFile *file, unsigned char *cdata, ElfSection *ss) {
  ElfSectionHeader *sh = &ss->header;
  unsigned int tot = sh->sh_size / sh->sh_entsize;
  
  Elf32_Sym sym;
  unsigned char *c = cdata + sh->sh_offset;
  
  for (unsigned int i=0; i<tot; i++) {
    memcpy(&sym, c, sizeof(Elf32_Sym));
    
    if (i > 0) {
      unsigned char *str = file->strtable + sym.st_name;
      
      Symbol *sym2 = alloc_symbol(file);
      
      memset(sym2, 0, sizeof(Symbol));
      strncpy(sym2->name, str, sizeof(sym2->name)-1);
      sym2->sym = sym;
      
      elfdebug("%s:%d:%d:%d\n", str, ELF32_ST_TYPE(sym.st_info), ELF32_ST_BIND(sym.st_info), sym.st_shndx);
      
      ElfSection *ss = get_section(file, sym.st_shndx);
      sym2->section = ss;
    }
    
    c += sh->sh_entsize;
  }
}

ElfFile *elfloader_load(void *data, int size) {
  if (!data || (size > 0 && (unsigned int)size < sizeof(ElfHeader)))
    return NULL;
  
  unsigned char *cdata = data;
  if (cdata[0] != 0x7f || cdata[1] != 'E' || cdata[2] != 'L' || cdata[3] != 'F') {
    elfdebug("not an elf file!\n");
    return NULL; //not an elf file
  }
  
  ElfFile *file = kmalloc(sizeof(ElfFile));
  memset(file, 0, sizeof(ElfFile));
  
  file->fdata = data;
  
  ElfHeader *h = &file->header;
  memcpy(h, data, sizeof(ElfHeader));
  
  file->entry = h->e_entry;
  
  unsigned int phsize = h->e_phentsize;
  unsigned int totph = h->e_phnum;
  
  unsigned int shsize = h->e_shentsize;
  unsigned int totsh = h->e_shnum;
  
  //unsigned int symtable = h->e_shstrndx;
  
  elfdebug("reading sections. . .\n");
  
  for (unsigned int i=0; i<totsh; i++) {
    uintptr_t addr = (uintptr_t)data + h->e_shoff + shsize*i;
    
    ElfSection *ss = kmalloc(sizeof(*ss));
    ElfSectionHeader *sh = &ss->header;

    memcpy(sh, (void*)addr, sizeof(*sh));

    elfdebug("  section name: %d %x\n", ss->header.sh_name, addr);

    if (sh->sh_type == SHT_HASH) {
      file->hash = ss;
    }
    
    //save string table
    if (sh->sh_type == SHT_STRTAB) {
      elfdebug("Found string table\n");
      file->strtable = cdata + sh->sh_offset;
    }
    
    ss->data = (unsigned char*)data + sh->sh_offset;
    
    klist_append(&file->sections, ss);
  }
  
  #ifdef ELF_DEBUG
  unsigned char *sectname_strtable = file->strtable = get_section(file, h->e_shstrndx)->data;
  #endif
  
  elfdebug("\n");
  
  //other symbols later
  for (ElfSection *ss = file->sections.first; ss; ss=ss->next) {
    ElfSectionHeader *sh = &ss->header;
    //elfdebug("  sname: %s\n", sectname_strtable + sh->sh_name);

    //save string table
    if (sh->sh_type == SHT_STRTAB) {
      elfdebug("Found string table\n");
      //file->strtable = cdata + sh->sh_offset;
    }

    if (ss->header.sh_type == SHT_SYMTAB) {
      elfdebug("\nreading full symbol table. . .\n\n");
      file->strtable = get_section(file, sh->sh_link)->data;
      read_symbols(file, cdata, ss);
    }
    
    if (ss->header.sh_type == SHT_DYNSYM) {
      elfdebug("\nreading dynamic symbol table. . .\n\n");
      file->strtable = get_section(file, sh->sh_link)->data;
      read_symbols(file, cdata, ss);
    }
  }
  
  //find first string table
  for (ElfSection *ss = file->sections.first; ss; ss=ss->next) {
    ElfSectionHeader *sh = &ss->header;
    
    //save string table
    if (sh->sh_type == SHT_STRTAB) {
      elfdebug("Found string table\n");
      file->strtable = cdata + sh->sh_offset;
      break;
    }
  }
  
  file->strtable = get_section(file, h->e_shstrndx)->data;
    
  elfdebug("reading program headers. . .\n");
  for (unsigned int i=0; i<totph; i++) {
    uintptr_t addr = (uintptr_t)data + h->e_phoff + phsize*i;
    
    ElfProgramSection *ps = kmalloc(sizeof(*ps));
    ElfProgramHeader *ph = &ps->header;
    memcpy(ph, (void*)addr, sizeof(*ph));

    ps->data = (unsigned char*)data + ph->p_offset;
    klist_append(&file->program_headers, ps);
  }
  
  return file;
}

void *elfloader_instantiate(ElfFile *file) {
  ElfProgramSection *ps;
  uintptr_t base = 0;
  int first = 1;
  uintptr_t size = 0;
  
  elfdebug("\n");
  
  for (ps=file->program_headers.first; ps; ps=ps->next) {
    ElfProgramHeader *ph = &ps->header;
    
    if (ph->p_align > 1 && (ph->p_vaddr % ph->p_align)) {
      //ph->p_vaddr -= ph->p_vaddr % ph->p_align;
      //ph->p_vaddr += ph->p_align - (ph->p_vaddr & (ph->p_align-1));
    }
    
    elfdebug("ph->type: %d\n", ph->p_type);
    elfdebug("ph->filesz: %d\n", ph->p_filesz);
    elfdebug("ph->memsz: %d\n", ph->p_memsz);
    elfdebug("ph->offset: %d\n", ph->p_offset);
    elfdebug("ph->vaddr: %d\n", ph->p_vaddr);
    elfdebug("ph->paddr: %d\n", ph->p_paddr);
    elfdebug("\n");
    
    if (first) {
      first = 0;
      base = ph->p_vaddr;
    } else {
      base = MIN2(base, ph->p_vaddr);
    }
  }
  for (ps=file->program_headers.first; ps; ps=ps->next) {
    ElfProgramHeader *ph = &ps->header;
    
    uintptr_t a = ph->p_vaddr + ph->p_memsz;
    size = MAX2(size, a - base);
  }
  
  elfdebug("reloc base: %d\n", base);
  elfdebug("size: %d\n", size);
  
  if (size == 0) {
    elfdebug("elf load error!\n");
    return NULL;
  }
  
  unsigned char *image = kmalloc(size);
  memset(image, 0, sizeof(image));
  
  for (ps=file->program_headers.first; ps; ps=ps->next) {
    ElfProgramHeader *ph = &ps->header;

    uintptr_t a = ph->p_vaddr - base;
    uintptr_t b = ph->p_offset;
    
    elfdebug("ph->p_type: %d\n", ph->p_type);
    
    switch (ph->p_type) {
      case PT_PHDR:
      case PT_LOAD:
        memcpy(image+a, file->fdata+b, ph->p_filesz);
        break;
      case PT_INTERP:
        elfdebug("DYNAMIC BINARY!\n");
        break;
    }
  }
  
  file->vbase = base;
  
  elfdebug("\n");
  
#ifdef ELF_DEBUG
  char *strtable = file->strtable;
  ElfSection *got=NULL, *gotplt=NULL;
#endif
  
#ifdef ELF_DEBUG
  for (ElfSection *ss = file->sections.first; ss; ss=ss->next) {
    ElfSectionHeader *sh = &ss->header;
    
    if (sh->sh_type == SHT_STRTAB) {
      elfdebug("Found string table\n");
      strtable = file->fdata + sh->sh_offset;
    }

    unsigned char *str = strtable + sh->sh_name;
    if (!strcmp(str, ".got"))
      got = ss;
    if (!strcmp(str, ".got.plt"))
      gotplt = ss;
    
    if (sh->sh_type == SHT_REL) {
      Elf32_Rel rel;
      int totrel = sh->sh_size / sh->sh_entsize;
      
      elfdebug("found relocation section; %d entries.", totrel);
      /*
      for (int i=0; i<totrel; i++) {
        memcpy(&rel, ss->data + i*sh->sh_entsize, sizeof(rel));
        elfdebug("sym: %d\n", ELF32_R_SYM(rel.r_info));
        elfdebug("sym: %d\n", ELF32_R_SYM(rel.r_info));
      }*/
    }
  }
#endif
  
  elfdebug("image: %x\n", image);
  
  return image;
}

void elfloader_free(ElfFile *file) {
  ElfSection *ss, *snext;
  ElfProgramSection *ps, *pnext;
  
  for (ss=file->sections.first; ss; ss=snext) {
    snext = ss->next;
    kfree(ss);
  }
  
  for (ps=file->program_headers.first; ps; ps=pnext) {
    pnext = ps->next;
    kfree(ps);
  }
  
  kfree(file);
}

