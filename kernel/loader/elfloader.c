#include "elfloader.h"

#include "../libc/string.h"
#include "../libc/stdio.h"
#include "../libc/kmalloc.h"
#include "../libc/ctype.h"
#include "../libc/libk.h"

enum {
  ET_NONE,
  ET_RELOC,
  ET_EXEC,
  ET_DYN,
  ET_CORE,
  ET_LOPROC=0xff00,
  ET_HIGHPROC=0xffff
};

enum { //contents of ->e_ident
  EI_MAGIC0,
  EI_MAGIC1,
  EI_MAGIC2,
  EI_MAGIC3,
  EI_CLASS,
  EI_DATA,
  EI_VERISON,
  EI_PAD,
};

enum {
  CLASSNONE,
  CLASS32,
  CLASS64
};

enum {
  ENCODING_ERROR,
  ENCODING_LSB,
  ENCODING_MSB
};

enum { //special section names
  SHN_UNDEF,
  SHN_LORESERVE,
  SHN_LOPROC,
  SHN_HIPROC,
  SHN_ABS,
  SHN_COMMON,
  SHN_HIRESERVE
};

enum { //section type
  SHT_NULL,
  SHT_PROGBITS,
  SHT_SYMTAB,
  SHT_STRTAB,
  SHT_RELA,
  SHT_HASH,
  SHT_DYNAMIC,
  SHT_NOTE,
  SHT_NOBITS,
  SHT_REL,
  SHT_SHLIB,
  SHT_DYNSYM,
  SHT_LOPROC,
  SHT_HIPROC,
  SHT_LOUSER,
  SHT_HIUSER
};

enum {
  PT_NULL,
  PT_LOAD,
  PT_DYNAMIC,
  PT_INTERP,
  PT_NOTE,
  PT_SHLIB,
  PT_PHDR,
  PT_LOPROC=0x70000000,
  PT_HIPROC=0x7FFFFFFF
};

#ifndef MAX2
#define MAX2(a, b) ((a) > (b) ? (a) : (b))
#endif

#ifndef MIN2
#define MIN2(a, b) ((a) < (b) ? (a) : (b))
#endif

static void read_symbols(ElfFile *file, unsigned char *cdata, ElfSection *ss) {
  ElfSectionHeader *sh = &ss->header;;
  unsigned int tot = sh->sh_size / sh->sh_entsize;
  
  Elf32_Sym sym;
  unsigned char *c = cdata + sh->sh_offset;
  
  for (unsigned int i=0; i<tot; i++) {
    memcpy(&sym, c, sizeof(Elf32_Sym));
    
    if (i > 0) {
      unsigned char *str = file->strtable + sym.st_name;
      kprintf("%s\n", str);
    }
    c += sh->sh_entsize;
  }
}

ElfFile *elfloader_load(void *data, int size) {
  if (!data || (size > 0 && (unsigned int)size < sizeof(ElfHeader)))
    return NULL;
  
  unsigned char *cdata = data;
  if (cdata[0] != 0x7f || cdata[1] != 'E' || cdata[2] != 'L' || cdata[3] != 'F') {
    kprintf("not an elf file!\n");
    return NULL; //not an elf file
  }
  
  ElfFile *file = kmalloc(sizeof(ElfFile));
  memset(file, 0, sizeof(ElfFile));
  
  ElfHeader *h = &file->header;
  memcpy(h, data, sizeof(ElfHeader));
  
  file->entry = h->e_entry;
  
  unsigned int phsize = h->e_phentsize;
  unsigned int totph = h->e_phnum;
  
  unsigned int shsize = h->e_phentsize;
  unsigned int totsh = h->e_shnum;
  
  //unsigned int symtable = h->e_shstrndx;
  unsigned int finalsize = 0;
  unsigned int base = 0xffffffff;
  
  kprintf("reading sections. . .");
  for (unsigned int i=0; i<totsh; i++) {
    uintptr_t addr = (uintptr_t)data + h->e_shoff + shsize*i;
    
    ElfSection *ss = kmalloc(sizeof(*ss));
    ElfSectionHeader *sh = &ss->header;
    memcpy(sh, (void*)addr, sizeof(*sh));

    if (sh->sh_type == SHT_HASH) {
      file->hash = ss;
    }
    
    //save string table
    if (sh->sh_type == SHT_STRTAB) {
      file->strtable = cdata + sh->sh_offset;
    }
    
    ss->data = (unsigned char*)data + sh->sh_offset;
    
    klist_append(&file->sections, ss);
  }
  
  //dynamic symbols first
  for (ElfSection *ss = file->sections.first; ss; ss=ss->next) {
    if (ss->header.sh_type == SHT_DYNSYM) {
      kprintf("\nreading dynamic symbol table. . .\n\n");
      read_symbols(file, cdata, ss);
    }
  }
  
  //other symbols later
  for (ElfSection *ss = file->sections.first; ss; ss=ss->next) {
    if (ss->header.sh_type == SHT_SYMTAB) {
      kprintf("\nreading full symbol table. . .\n\n");
      read_symbols(file, cdata, ss);
    }
  }
  
  kprintf("reading program headers. . .");
  for (unsigned int i=0; i<totph; i++) {
    uintptr_t addr = (uintptr_t)data + h->e_phoff + phsize*i;
    
    ElfProgramSection *ps = kmalloc(sizeof(*ps));
    ElfProgramHeader *ph = &ps->header;
    memcpy(ph, (void*)addr, sizeof(*ph));

    ps->data = (unsigned char*)data + ph->p_offset;
    
    if (ph->p_align > 1) {
      unsigned int vaddr = vaddr - (ph->p_offset & (ph->p_align-1));
      
      base = MIN2(base, vaddr);
    }
    
    finalsize += ph->p_memsz;
    klist_append(&file->program_headers, ps);
  }
  
  return file;
}

void elfloader_free(ElfFile *file) {
  kfree(file);
}

