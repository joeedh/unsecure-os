extern e9printf;

%define lret db 0xcb

%define GSEL_CODE   0x08
%define GSEL_DATA   0x10
%define GSEL_CODE16 0x28
%define GSEL_DATA16 0x30

%define _CRED  ('r' | (12 << 8) | (12<<12))
%define _CGRE  ('g' | (9 << 8) | (9<<12))

;get global address table
;what does %% do? can I use m4 for this?
%macro  get_GOT 0
    push    ebx
    call    %%getgot 
  %%getgot: 
    pop     ebx 
    add     ebx,_GLOBAL_OFFSET_TABLE_+$$-%%getgot wrt ..gotpc 
%endmacro

%macro getvar 0
  lea eax, [ebx+myvar wrt ..gotoff]
%endmacro

m4_define(`docli', `
  cli;
  mov [dword 0xB8000], dword _CRED;
')

m4_define(`dosti', `
  mov [dword 0xB8000], dword _CGRE;
  sti;
')

m4_define(nconcat, `$1$2')

%define TTY_BUFFER_ROWS 900

%define MAX_TASKS 32

%define GDT_ENTRIES 32 ;number of gdt entries
%define PROCESS_SIZE 472 ;size of Process struct
%define TASK_SIZE 56 ;size of Task struct

%define DWSIZE 4
%define POINTERSIZE 4

%define VGA_WIDTH 80
%define VGA_HEIGHT 25

m4_define(`reszero', `
  times $1 db 0
  ;resb $1
')

%define BLUE   9   ;vga_light_blue, actually
%define BLACK  0  
%define WHITE  15 
%define RED    4    
%define GREEN  10 

; Declare constants used for creating a multiboot header.
;MBALIGN     equ  1<<0                   ; align loaded modules on page boundaries
;MEMINFO     equ  1<<1                   ; provide memory map
;MODINFO     equ  1<<3
;DRIVEINFO   equ  1<<7

;FLAGS       equ  MBALIGN | MEMINFO   ; this is the Multiboot 'flag' field
;MAGIC       equ  0x1BADB002          ; 'magic number' lets bootloader find the header
;CHECKSUM    equ -(MAGIC + FLAGS)     ; checksum of above, to prove we are multiboot

extern terminal_set_debug;
extern terminal_set_idebug;

m4_define(`set_debug_char', `
  pushad;
  
  push dword $3
  push dword $2
  push dword $1
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;
')

extern terminal_set_idebug;

m4_define(`set_debug_int', `
  push dword $4
  push dword $3
  push dword $2
  push dword $1
  
  call terminal_set_idebug
  
  pop eax
  pop eax
  pop eax
  pop eax
')

 
; debug channels for set_debug_char 
%define DEBUG_ISR00 35
;00-14 are reserved
%define DEBUG_ISR14 18

%define DEBUG_EXC  2
%define DEBUG_KEY  5

;clear nested task flag
m4_define(`clear_nt', `
  ;save eax
  push eax;
  
  ;load eflags into stack
  pushfd;
  
  ;load eflags into register
  pop eax;
  push eax;
  
  ;bts dword [esp], 14;
  and eax, ~(1<<14);
  
  ;set eflags from stack
  popfd;
  
  ;restore eax
  pop eax;
')

m4_define(`ctx_push', `
  ;pushf;
  pushfd;
  ;pusha;
  pushad;
  ;push ds;
')

m4_define(`ctx_pop', `
  ;pop ds;
  popad;
  ;popa;
  popfd;
  ;popf;
')

m4_define(`irq_entry', `
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;
')

m4_define(`irq_iret', `
  popfd;
  popad;
  mfence
  
  dosti
  iret
')


m4_define(`printIRQ', `
  mov al, 105
  out 0xE9, byte al
  out 0x80, al
  mov al, 48 + $1
  out 0xE9, byte al
  out 0x80, al
  mov al, 10
  out 0xE9, byte al
  out 0x80, al
  mov al, 0
  out 0xE9, byte al
  out 0x80, al
')

m4_define(`doPIC', `
  mov al, 20h
  out $1, al
  
  ;io_wait()
  out 80h, al 
')
