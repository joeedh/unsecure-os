extern e9printf;

%define TTY_BUFFER_ROWS 900

%define MAX_TASKS 32

%define GDT_ENTRIES 32 ;number of gdt entries
%define PROCESS_SIZE 472 ;size of Process struct
%define TASK_SIZE 104 ;size of Task struct

%define DWSIZE 4
%define POINTERSIZE 4

%define VGA_WIDTH 80
%define VGA_HEIGHT 25

%define BLUE   9   ;vga_light_blue, actually
%define BLACK  0  
%define WHITE  15 
%define RED    4    
%define GREEN  10 

%define lret db 0xcb

%define GSEL_CODE   0x08
%define GSEL_DATA   0x10
%define GSEL_CODE16 0x28
%define GSEL_DATA16 0x30

%define _CLGN  ('g' | (10 << 8) | (12<<12))
%define _CRED  ('r' | (12 << 8) | (12<<12))
%define _CGRE  ('g' | (9 << 8) | (9<<12))
 
; debug channels for set_debug_char 

%define DEBUG_ISR00 35
;00-14 are reserved
%define DEBUG_ISR14 18
%define DEBUG_EXC  2
%define DEBUG_KEY  5
%define DEBUG_INSIDEIRQ  55
%define DEBUG_INSIDEEXC  58

m4_define(`reszero', `
  times $1 db 0
  ;resb $1
')

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
  mov [dword 0xB8000], dword _CLGN ; _CRED
')

m4_define(`dosti', `
  mov [dword 0xB8000], dword _CGRE
  sti
')

m4_define(nconcat, `$1$2')

m4_define(`task_switch_basic', `
  ctx_push
  
  ;save stack
  mov eax, dword [k_curtaskp]
  mov dword [eax], esp
  
  ;move to next task
  mov eax, [k_curtaskp]
  add eax, DWSIZE
  mov eax, [eax]
  mov dword [k_curtaskp], eax
  
  ;set stack
  mov esp, [eax]
  
  ctx_pop
')

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

;args: column, global variable (inside_irq or inside_exc)
m4_define(`_display_inside_irq_exc', `
  ;calculate character to display
  mov eax, [$2]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword $1
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3
')

m4_define(`display_inside_irq_exc', `
  ;save registers
  pushad
  pushfd
  
  _display_inside_irq_exc(DEBUG_INSIDEIRQ, inside_irq)
  _display_inside_irq_exc(DEBUG_INSIDEEXC, inside_exc)
  
  ;restore registers
  popfd
  popad
')

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
  pushfd;
  pushad;
')

m4_define(`ctx_pop', `
  popad;
  popfd;
')

m4_define(`irq_entry', `
  inc dword [inside_irq]
  
  display_inside_irq_exc()
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;dosti;
')

m4_define(`irq_iret', `
  popfd;
  popad;
  mfence
  
  dec dword [inside_irq]
  display_inside_irq_exc()
  
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
