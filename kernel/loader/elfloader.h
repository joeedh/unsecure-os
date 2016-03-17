#ifndef _ELFLOADER_H
#define _ELFLOADER_H

#include <stddef.h>
#include <stdint.h>
#include "../libc/list.h"

#define EI_NIDENT 16

struct ElfFile;
struct ElfFile *elfloader_load(void *data, int size);
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
  
  void *data;
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

typedef struct Symbol {
  char name[256];
  uintptr_t addr;
  uintptr_t final_addr;
} Symbol;

typedef struct ElfFile {
  Symbol *symbols;
  int totsymbol;
  
  uintptr_t entry;
  uintptr_t reloc_base;
  
  struct ElfHeader header;
  List sections;
  List program_headers;
  
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

//actually, no paging yet
#define PAGE_SIZE 16

#endif /* _ELFLOADER_H */
