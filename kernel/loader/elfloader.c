#include "elfloader.h"

#include "../libc/string.h"
#include "../libc/stdio.h"
#include "../libc/kmalloc.h"
#include "../libc/ctype.h"
#include "../libc/libk.h"

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
      
      //*
      Symbol *sym2 = alloc_symbol(file);
      
      memset(sym2, 0, sizeof(Symbol));
      strncpy(sym2->name, str, sizeof(sym2->name)-1);
      sym2->sym = sym;
      
      int bind = ELF32_ST_BIND(sym.st_info);
      int type = ELF32_ST_TYPE(sym.st_info);
      
      e9printf("%s:%d:%d:%d\n", str, type, bind, sym.st_shndx);
      
      ElfSection *ss = get_section(file, sym.st_shndx);
      sym2->section = ss;
      //*/
    }
    
    c += sh->sh_entsize;
  }
}

ElfFile *elfloader_load(void *data, int size) {
  if (!data || (size > 0 && (unsigned int)size < sizeof(ElfHeader)))
    return NULL;
  
  unsigned char *cdata = data;
  if (cdata[0] != 0x7f || cdata[1] != 'E' || cdata[2] != 'L' || cdata[3] != 'F') {
    e9printf("not an elf file!\n");
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
  
  e9printf("reading sections. . .\n");
  
  for (unsigned int i=0; i<totsh; i++) {
    uintptr_t addr = (uintptr_t)data + h->e_shoff + shsize*i;
    
    ElfSection *ss = kmalloc(sizeof(*ss));
    ElfSectionHeader *sh = &ss->header;

    memcpy(sh, (void*)addr, sizeof(*sh));

    e9printf("  section name: %d %x\n", ss->header.sh_name, addr);

    if (sh->sh_type == SHT_HASH) {
      file->hash = ss;
    }
    
    //save string table
    if (sh->sh_type == SHT_STRTAB) {
      e9printf("Found string table\n");
      file->strtable = cdata + sh->sh_offset;
    }
    
    ss->data = (unsigned char*)data + sh->sh_offset;
    
    klist_append(&file->sections, ss);
  }
  
  unsigned char *sectname_strtable = file->strtable = get_section(file, h->e_shstrndx)->data;
  
  e9printf("\n");
  
  //other symbols later
  for (ElfSection *ss = file->sections.first; ss; ss=ss->next) {
    ElfSectionHeader *sh = &ss->header;
    unsigned char *sname = sectname_strtable + sh->sh_name;
    
     e9printf("  sname: %s\n", sname, ss->header.sh_name);
    //e9printf("  section type: %d\n", ss->header.sh_type);

    //save string table
    if (sh->sh_type == SHT_STRTAB) {
      e9printf("Found string table\n");
      //file->strtable = cdata + sh->sh_offset;
    }

    if (ss->header.sh_type == SHT_SYMTAB) {
      e9printf("\nreading full symbol table. . .\n\n");
      file->strtable = get_section(file, sh->sh_link)->data;
      read_symbols(file, cdata, ss);
    }
    
    if (ss->header.sh_type == SHT_DYNSYM) {
      e9printf("\nreading dynamic symbol table. . .\n\n");
      file->strtable = get_section(file, sh->sh_link)->data;
      read_symbols(file, cdata, ss);
    }
  }
  
  //find first string table
  for (ElfSection *ss = file->sections.first; ss; ss=ss->next) {
    ElfSectionHeader *sh = &ss->header;
    
    //save string table
    if (sh->sh_type == SHT_STRTAB) {
      e9printf("Found string table\n");
      file->strtable = cdata + sh->sh_offset;
      break;
    }
  }
  
  file->strtable = get_section(file, h->e_shstrndx)->data;
    
  e9printf("reading program headers. . .\n");
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
  
  e9printf("\n");
  
  for (ps=file->program_headers.first; ps; ps=ps->next) {
    ElfProgramHeader *ph = &ps->header;
    
    uintptr_t addr = ph->p_vaddr;
    if (ph->p_align > 1 && (ph->p_vaddr % ph->p_align)) {
      //ph->p_vaddr -= ph->p_vaddr % ph->p_align;
      //ph->p_vaddr += ph->p_align - (ph->p_vaddr & (ph->p_align-1));
    }
    
    e9printf("ph->type: %d\n", ph->p_type);
    e9printf("ph->filesz: %d\n", ph->p_filesz);
    e9printf("ph->memsz: %d\n", ph->p_memsz);
    e9printf("ph->offset: %d\n", ph->p_offset);
    e9printf("ph->vaddr: %d\n", ph->p_vaddr);
    e9printf("ph->paddr: %d\n", ph->p_paddr);
    e9printf("\n");
    
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
  
  e9printf("reloc base: %d\n", base);
  e9printf("size: %d\n", size);
  
  if (size == 0) {
    e9printf("elf load error!\n");
    return NULL;
  }
  
  unsigned char *image = kmalloc(size);
  memset(image, 0, sizeof(image));
  
  for (ps=file->program_headers.first; ps; ps=ps->next) {
    ElfProgramHeader *ph = &ps->header;

    uintptr_t a = ph->p_vaddr - base;
    uintptr_t b = ph->p_offset;
    
    e9printf("ph->p_type: %d\n", ph->p_type);
    
    switch (ph->p_type) {
      case PT_PHDR:
      case PT_LOAD:
        memcpy(image+a, file->fdata+b, ph->p_filesz);
        break;
      case PT_INTERP:
        e9printf("DYNAMIC BINARY!\n");
        break;
    }
  }
  
  file->vbase = base;
  
  e9printf("\n");
  
  char *strtable = file->strtable;
  ElfSection *got=NULL, *gotplt=NULL;
  
  for (ElfSection *ss = file->sections.first; ss; ss=ss->next) {
    ElfSectionHeader *sh = &ss->header;
    
    if (sh->sh_type == SHT_STRTAB) {
      e9printf("Found string table\n");
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
      
      e9printf("found relocation section; %d entries.", totrel);
      /*
      for (int i=0; i<totrel; i++) {
        memcpy(&rel, ss->data + i*sh->sh_entsize, sizeof(rel));
        e9printf("sym: %d\n", ELF32_R_SYM(rel.r_info));
        e9printf("sym: %d\n", ELF32_R_SYM(rel.r_info));
      }*/
    }
  }
  
  e9printf("image: %x\n", image);
  
  return image;
}

void elfloader_free(ElfFile *file) {
  kfree(file);
}

