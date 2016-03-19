#ifndef _ELFLOADER_H
#define _ELFLOADER_H

#include <stddef.h>
#include <stdint.h>
#include "../libc/list.h"

#define EI_NIDENT 16

struct ElfFile;

struct ElfFile *elfloader_load(void *data, int size);
void *elfloader_instantiate(struct ElfFile *file);
void elfloader_free(struct ElfFile *file);

typedef uint16_t Elf32_Half;
typedef uint32_t Elf32_Word;
typedef uint32_t Elf32_Sword;
typedef uint32_t Elf32_Off;
typedef uint32_t Elf32_Addr;

typedef struct ElfHeader{
  unsigned char e_ident[EI_NIDENT];
  Elf32_Half e_type;
  Elf32_Half e_machine;
  Elf32_Word e_version;
  Elf32_Addr e_entry;
  Elf32_Off e_phoff;
  Elf32_Off e_shoff;
  Elf32_Word e_flags;
  Elf32_Half e_ehsize;
  Elf32_Half e_phentsize;
  Elf32_Half e_phnum;
  Elf32_Half e_shentsize;
  Elf32_Half e_shnum;
  Elf32_Half e_shstrndx;
} ElfHeader;

typedef struct ElfSectionHeader {
  Elf32_Word sh_name;
  Elf32_Word sh_type;
  
  Elf32_Word sh_flags;
  Elf32_Addr sh_addr;
  
  Elf32_Off sh_offset;
  Elf32_Word sh_size;
  Elf32_Word sh_link;
  Elf32_Word sh_info;
  Elf32_Word sh_addralign;
  Elf32_Word sh_entsize;
} ElfSectionHeader;

typedef struct ElfSection {
  struct ElfSection *next, *prev;
  char name[128];
  
  unsigned char *data;
  ElfSectionHeader header;
} ElfSection;

typedef struct ElfProgramHeader {
  Elf32_Word p_type;
  Elf32_Off p_offset;
  Elf32_Addr p_vaddr;
  Elf32_Addr p_paddr;
  Elf32_Word p_filesz;
  Elf32_Word p_memsz;
  Elf32_Word p_flags;
  Elf32_Word p_align;
} ElfProgramHeader;

typedef struct ElfProgramSection {
  struct ElfProgramSection *next, *prev;
  
  ElfProgramHeader header;
  uintptr_t vaddr;
  void *data;
} ElfProgramSection;

struct Symbol;
typedef struct ElfFile {
  struct Symbol *symbols;
  int totsymbol, totsymalloc;
  
  uintptr_t entry;
  uintptr_t reloc_base;
  
  struct ElfHeader header;
  List sections;
  List program_headers;
  uintptr_t vbase;
  
  unsigned char *fdata;
  
  unsigned char *strtable;
  ElfSection *hash;
} ElfFile;

typedef struct {
  Elf32_Addr r_offset;
  Elf32_Word r_info;
} Elf32_Rel;

typedef struct{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
  Elf32_Sword r_addend;
} Elf32_Rela;

typedef struct Elf32_Sym {
  Elf32_Word st_name;
  Elf32_Addr st_value;
  Elf32_Word st_size;
  unsigned char st_info;
  unsigned char st_other;
  Elf32_Half st_shndx;
} Elf32_Sym;

typedef struct Symbol {
  char name[256];
  ElfSection *section;
  Elf32_Sym sym;
  
  uintptr_t final_addr;
} Symbol;

enum {
  STB_LOCAL,
  STB_GLOBAL,
  STB_WEAK,
  STB_LOPROC=13,
  STB_HIPROC=15
};

enum {
  STT_NOTYPE,
  STT_OBJECT,
  STT_FUNC,
  STT_SECTION,
  STT_FILE,
  STT_LOPROC=13,
  STT_HIPROC=15
};

enum {
  SHN2_ABS,
  SHN2_COMMON, //slignment is in sym->st_value
  SHN2_UNDEF
};


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
  SHT_NULL,     //0
  SHT_PROGBITS, //1
  SHT_SYMTAB,   //2
  SHT_STRTAB,   //3
  SHT_RELA,     //4
  SHT_HASH,     //5
  SHT_DYNAMIC,  //6
  SHT_NOTE,     //7
  SHT_NOBITS,   //8
  SHT_REL,      //9
  SHT_SHLIB,    //10
  SHT_DYNSYM,   //11
  SHT_LOPROC,   //12
  SHT_HIPROC,   //13
  SHT_LOUSER,   //14
  SHT_HIUSER    //15
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

#define ELF32_R_SYM(i) ((i)>>8)
#define ELF32_R_TYPE(i) ((unsigned char)(i))
#define ELF32_R_INFO(s,t) (((s)<<8)+(unsigned char)(t)

#define ELF32_ST_BIND(i) ((i)>>4)
#define ELF32_ST_TYPE(i) ((i)&0xf)
#define ELF32_ST_INFO(b,t) (((b)<<4)+((t)&0xf))

//XXX: actually, no paging yet
#define PAGE_SIZE 16

#endif /* _ELFLOADER_H */
