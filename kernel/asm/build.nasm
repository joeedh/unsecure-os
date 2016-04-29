

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







%define TTY_BUFFER_ROWS 900

%define MAX_TASKS 32

%define GDT_ENTRIES 32 ;number of gdt entries
%define PROCESS_SIZE 472 ;size of Process struct
%define TASK_SIZE 56 ;size of Task struct

%define DWSIZE 4
%define POINTERSIZE 4

%define VGA_WIDTH 80
%define VGA_HEIGHT 25



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



extern terminal_set_idebug;



 
; debug channels for set_debug_char 
%define DEBUG_ISR00 35
;00-14 are reserved
%define DEBUG_ISR14 18

%define DEBUG_EXC  2
%define DEBUG_KEY  5

;clear nested task flag















global SBIOS_CallBios, enter_real, exit_real

use16
exit_real:
  ret

use32
enter_real:
  pushad
  pushfd
  
  sgdt [esp]
  sub esp, 16 ; 10 + 6 bytes of padding for alignnment
  sidt [esp]
  sub esp, 8  ; 6 + 2 bytes of padding for alignment
  
  ;call .prot32
  ;.prot32:
  pop ebx ;get 32-bit return address
  
  call GSEL_CODE16:.prot16
use16
  .prot16:
  
  ;pop off far ret
  add esp, 8;
  
  jmp ebx
use32

SBIOS_CaleelBios:
  call enter_real
  use16
  call exit_real
  use32
  ret

SBIOS_CallBios:
  push ebp
  mov ebp, esp
  
  pusha
  
  mov eax, 0x0 ;zero eax, in case bios ignores upper 16 bits
  ;mov eax, [0x00002048 + 4];
  
  
  ;enter 16 bit mode
  ;call 0x08:0x2000
  
  call 0x00002048
  
  ;int 11h;
  
  ;enter 32 bit mode again
  ;call 0x08:0x2000
  
  popa
  pop ebp
  ret

section .multiboot

;size of tag header is added automatically to size
%macro mb2_tag 3 ;type, flags, size
;  align POINTERSIZE;
  dw %1;
  dw %2;
  dd %3 + 8;
%endmacro

;size of tag header is added automatically to size
%macro mb2_optional_tag 3 ;type, flags, size
  align POINTERSIZE;
  dw %1;
  dw %2 | 1;
  dd %3 + 8;
%endmacro

;Multiboot2 header
align 32

dd 0xE85250D6
dd 0                  ; arch, 0 for x86 32-bit protected mode
dd 16                 ; header length
dd -(0xE85250D6 + 16) ; checksum
;dd -0xe85250e6        ;checksum

global _start, mb_tag1, mb_tag2

mb_requested_tag:
  mb2_tag 1, 0, 28
  dd 6;
  dd 2;
  dd 4;
  dd 8;
  dd 15;
  dd 10;
  dd 5;
  
  dd 0; align to 8 bytes
  
;mb_loadinfo:
;  mb2_tag 2, 0, 16
;  dd 1024*1024
;  dd 0
;  dd 0
;  dd 0

mb_entry:
  mb2_tag 3, 0, 4   ; main entry point for kernel
  dd _start
  dd 0;
  
;mb2_tag 5, 0, 12 

;m4_define(`VGA_TEXT_MODE')

; framebuffer


;mb_sentinel: align 4
  mb2_tag 0, 0, 0   ; null_terminated?


  times 512 db 0
  ;resb 512
 ;ensure padding before stack

; At startup the stack pointer register (esp) points at anything and using it may
; cause massive harm. Instead, we'll provide our own stack. We will allocate
; room for a small temporary stack by creating a symbol at the bottom of it,
; then allocating 65536 bytes for it, and finally creating a symbol at the top.
global stack_top;

section .bootstrap_stack, nobits
stack_bottom: align 8
resb 65536
stack_top:

section .text

align 8
global _start
_start:
	; Welcome to kernel mode! We now have sufficient code for the bootloader to
	; load and run our operating system. It doesn't do anything interesting yet.
	; Perhaps we would like to call printf("Hello, World\n"). You should now
	; realize one of the profound truths about kernel mode: There is nothing
	; there unless you provide it yourself. There is no printf function. There
	; is no <stdio.h> header. If you want a function, you will have to code it
	; yourself. And that is one of the best things about kernel development:
	; you get to make the entire system yourself. You have absolute and complete
	; power over the machine, there are no security restrictions, no safe
	; guards, no debugging mechanisms, there is nothing but what you build.
 
	; By now, you are perhaps tired of assembly language. You realize some
	; things simply cannot be done in C, such as making the multiboot header in
	; the right section and setting up the stack. However, you would like to
	; write the operating system in a higher level language, such as C or C++.
	; To that end, the next task is preparing the processor for execution of
	; such code. C doesn't expect much at this point and we only need to set up
	; a stack. Note that the processor is not fully initialized yet and stuff
	; such as floating point instructions are not available yet.
 
	; To set up a stack, we simply set the esp register to point to the top of
	; our stack (as it grows downwards).
	mov esp, stack_top
 
  ;push boot info pointer to stack
   push ebx;
  
	; We are now ready to actually execute C code. We cannot embed that in an
	; assembly file, so we'll create a kernel.c file in a moment. In that file,
	; we'll create a C entry point called kernel_main and call it here.
	
   extern kernel_main
	 call kernel_main
   pop ebx;
   
	; In case the function returns, we'll want to put the computer into an
	; infinite loop. To do that, we use the clear interrupt ('cli') instruction
	; to disable interrupts, the halt instruction ('hlt') to stop the CPU until
	; the next interrupt arrives, and jumping to the halt instruction if it ever
	; continues execution, just to be safe.
	
  cli;
  mov [dword 0xB8000], dword _CRED;

.hang:
	hlt
	jmp .hang


section .text, nobits
global emergency_proc_exit_stack

;small stack for emergency_proc_exit
resb 1024*64
emergency_proc_exit_stack:

section .gdt, nobits
global thegdt;

thegdt:
align 8
resb 8*(1+GDT_ENTRIES)
global thegdt_end;
thegdt_end:

section .text
align 8

global tss_stack_top, tss_stack_bottom;

tss_stack_bottom: align 8

  times 65536 db 0
  ;resb 65536

tss_stack_top:

  times 32 db 0
  ;resb 32
;

section .irq.table, nobits
global idt_table;

idt_table: align 8
  resb 8*256
  
global idt_table_end;
idt_table_end:


;does not account for paging
;enter_protected_mode:
;  cli
  

section .text
align 8

__k_idtr: 
DW 0 ; For limit storage
DD 0 ; For base storage
         
global _setIRT
_setIRT:
  
  cli;
  mov [dword 0xB8000], dword _CRED;

  
  push ax
  push eax
  push ebx
  
  mov eax, idt_table
  mov [__k_idtr+2], eax

  ;size of idt minus 1
  mov ax, 2047
  mov [__k_idtr], ax
    
  lidt [__k_idtr]
  
  pop ebx
  pop eax
  pop ax
  
  ret
  
;%define nconcat(a, b) a %+ b
%define PIC1 0x20
%define PIC2 0xA0

extern inside_irq;

;args: [irq_number, pic_number] (pic1 for master, pic2 for slave)



align 8
global _cpu_exception_flag
_cpu_exception_flag:
dd 0

global except_depth;
_except_depth:
dd 0

;takes two arguments


global exr_0, exr_1, exr_2, exr_3, exr_4, exr_5;
global exr_6, exr_7, exr_8, exr_9, exr_10, exr_11;
global exr_12, exr_13, exr_14, exr_15, exr_16, exr_17, exr_18;

align 8
exr_0: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 0, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 0;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler0;
  mov ebx, .aftercall
  call _exc_handler0;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_1: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 1, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 1;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler1;
  mov ebx, .aftercall
  call _exc_handler1;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back


;exr_1: ;special debug exception
;  iret;

exr_2: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 2, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 2;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler2;
  mov ebx, .aftercall
  call _exc_handler2;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_3: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 3, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 3;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler3;
  mov ebx, .aftercall
  call _exc_handler3;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_4: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 4, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 4;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler4;
  mov ebx, .aftercall
  call _exc_handler4;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_5: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 5, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 5;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler5;
  mov ebx, .aftercall
  call _exc_handler5;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_6: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 6, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 6;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler6;
  mov ebx, .aftercall
  call _exc_handler6;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_7: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 7, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 7;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler7;
  mov ebx, .aftercall
  call _exc_handler7;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_8: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 8, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 8;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler8;
  mov ebx, .aftercall
  call _exc_handler8;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_9: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 9, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 9;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler9;
  mov ebx, .aftercall
  call _exc_handler9;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_10: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 10, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 10;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler10;
  mov ebx, .aftercall
  call _exc_handler10;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_11: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 11, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 11;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler11;
  mov ebx, .aftercall
  call _exc_handler11;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_12: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 12, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 12;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler12;
  mov ebx, .aftercall
  call _exc_handler12;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_13: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 13, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 13;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler13;
  mov ebx, .aftercall
  call _exc_handler13;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_14: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 14, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 14;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler14;
  mov ebx, .aftercall
  call _exc_handler14;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_15: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 15, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 15;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler15;
  mov ebx, .aftercall
  call _exc_handler15;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_16: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 16, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 16;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler16;
  mov ebx, .aftercall
  call _exc_handler16;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_17: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 17, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 17;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler17;
  mov ebx, .aftercall
  call _exc_handler17;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back

exr_18: 
  align 8;
  
  mfence
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, 18, RED)
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, 18;
  
  push ebp;
  push dword [ebp + DWSIZE];
  push dword [ebp];
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern _exc_handler18;
  mov ebx, .aftercall
  call _exc_handler18;
  .aftercall:
  
  pop eax;
  add esp, DWSIZE*3;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp
    
    mfence
    
    
  mov [dword 0xB8000], dword _CGRE;
  sti;

    iret
  
  .cleardebug:
    
  pushad;
  
  push dword BLACK
  push dword 101
  push dword DEBUG_EXC
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;

    jmp .back


;takes two arguments


global isr_0, isr_1, isr_2, isr_3, isr_4, isr_end
global isr_5, isr_6, isr_7, isr_8, isr_9, isr_10
global isr_11, isr_12, isr_13, isr_14, isr_15

align 8;
_isr_7_message:
  db 'IRQ 7 detected!\n\0'
  
;special spurious-irq-handling code
isr_7:
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push _isr_7_message;
  call e9printf;
  pop eax;
  
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret

  
_isr_15_message:
  db 'IRQ 15 detected!\n\0'

;special spurious-irq-handling code
isr_15:
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push _isr_15_message;
  call e9printf;
  pop eax;

  
  mov al, 20h
  out PIC2, al
  
  ;io_wait()
  out 80h, al 

  
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


;isr_0: isr_wrapper(          0, PIC1) ;timer
isr_1 : 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  mfence
  
  
  cli;
  mov [dword 0xB8000], dword _CRED;

  ;push ebp  ;frame pointer
  ;mov  ebp, esp;
  
  pushad
  pushfd
  
  cld
  extern _isr_handler1;
  call _isr_handler1;
  
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  popfd
  popad
  
  mfence
  ;pop ebp  ;frame pointer
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret

 ;keyboard
isr_2 : 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler2;
  call _isr_handler2;
  pop ebp;
  
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_3 : 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler3;
  call _isr_handler3;
  pop ebp;
  
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_4 : 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler4;
  call _isr_handler4;
  pop ebp;
  
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_5 : 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler5;
  call _isr_handler5;
  pop ebp;
  
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_6 : 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler6;
  call _isr_handler6;
  pop ebp;
  
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


;isr_7 : isr_wrapper(          7, PIC1 ;spurious irq
isr_8 : 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler8;
  call _isr_handler8;
  pop ebp;
  
  
  mov al, 20h
  out PIC2, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_9 : 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler9;
  call _isr_handler9;
  pop ebp;
  
  
  mov al, 20h
  out PIC2, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_10: 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler10;
  call _isr_handler10;
  pop ebp;
  
  
  mov al, 20h
  out PIC2, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_11: 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler11;
  call _isr_handler11;
  pop ebp;
  
  
  mov al, 20h
  out PIC2, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_12: 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler12;
  call _isr_handler12;
  pop ebp;
  
  
  mov al, 20h
  out PIC2, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_13: 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler13;
  call _isr_handler13;
  pop ebp;
  
  
  mov al, 20h
  out PIC2, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


isr_14: 
  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;inc dword [inside_irq];
  ;dosti;

  
  push ebp  ;push frame pointer
  mov  ebp, esp;
  
  cld
  extern _isr_handler14;
  call _isr_handler14;
  pop ebp;
  
  
  mov al, 20h
  out PIC2, al
  
  ;io_wait()
  out 80h, al 

  
  pop ebp ;pop frame pointer
  
  popfd;
  popad;
  mfence
  
  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret


;isr_15: isr_wrapper(         15, PIC2)
isr_end:
 
; The linker script specifies _start as the entry point to the kernel and the
; bootloader will jump to this position once the kernel has been loaded. It
; doesn't make sense to return from this function as the bootloader is gone.
section .text
global _disable_PIC;
_disable_PIC:
  mov al, 0xff
  out 0xa1, al
  out 0x21, al
  ret

align 8;
__k_gdtr DW 0 ; For limit storage
         DD 0 ; For base storage
 
; From flat, protected mode
; "Flat" meaning the base of your data segment is 0 (regardless of whether paging is on or off). This is the case 
; if you're just been booted by GRUB, for instance.

global _setGDT_prot2
_setGDT_prot2:
  
  cli;
  mov [dword 0xB8000], dword _CRED;

  
  mov eax, thegdt
  mov [__k_gdtr+2], eax

  ;size of gdt minus 1  
  mov ax, GDT_ENTRIES*8 - 1
  mov [__k_gdtr], ax
    
  lgdt [__k_gdtr];
  
  ;load data segment register via
  ;long jump
  jmp 0x08:.flush;
  
  .flush:
    mov ax, 0x10;
    mov ds, ax;
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ;set main TSS
    mov ax, 0x18
    ltr ax;
    
    ret

global read_gdtr
read_gdtr:
  mov eax, [esp + 4]
  sgdt [eax]
  ret
  
global read_lidt
read_lidt:
  mov eax, [esp + 4]
  sidt [eax]
  ret

global read_eflags;
read_eflags:
  pushfd
  pop eax 
  ; mov eax, 1
  ret

align 8

extern next_task;
extern k_curtaskp;
extern k_lasttaskp;
extern k_debug;
extern k_debug2;
extern _isr_handler0;

extern get_next_task_timer;
extern task_switch_granularity;

_isr__message:
  db 10 ; LF
  db 9, '1: %x  %x', 10
  db 9, '2: %x  %x', 10
  db 9, '3: %x  %x', 10
  db 9, '4: %x  %x', 10
  db 9, '5: %x  %x', 10
  db 10 ; LF
  db 0

isr0_debug_stack_end: align 8

  times 1024*32 db 0
  ;resb 1024*32

isr0_debug_stack:



isr0_temp_int1: align 8
  dd 1
isr0_temp_int2: align 8
  dd 1



raw_next_task_jumpback:
  dd 0

;this is not thread-safe!
;expects jumpback pointer in ebx
;will sti
raw_next_task:
  mov [raw_next_task_jumpback], ebx
  
  ;save esp (signal system will probably want it later)
  mov eax, dword [k_curtaskp]
  mov dword [eax], esp
  
  ;move to next task
  mov eax, [k_curtaskp]
  add eax, DWSIZE
  mov eax, [eax]
  mov dword [k_curtaskp], eax
  mov esp, [eax]
  
  
  ;pop ds;
  popad;
  ;popa;
  popfd;
  ;popf;

  
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

  
  jmp [raw_next_task_jumpback]
  
isr_0:
;  isr0_debug_stack()
  
  ;increment tick counter
  extern kernel_tick;
  add dword [kernel_tick], 1
  
  
  ;pushf;
  pushfd;
  ;pusha;
  pushad;
  ;push ds;


  mov eax, dword [k_curtaskp];
  mov dword [eax], esp;
  
  ;move to next task
  mov eax, [k_curtaskp]
  add eax, DWSIZE;
  mov eax, [eax];
  mov dword [k_curtaskp], eax
  mov esp, [eax];
  
  ;set_debug_char(DEBUG_ISR00, 105, GREEN)
  ;docli
  ;set_debug_int(25, 15, [eax], BLUE)
  ;dosti
  
  ;send ok to PIC
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  
  ;pop ds;
  popad;
  ;popa;
  popfd;
  ;popf;

  
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

  
  sti
  fclex
  iret

isr_debug_stack_bottom:

  times 32*1024 db 0
  ;resb 32*1024

isr_debug_stack_top:

; timer irq, used for task-switching
issr_0:
  cli
  
  ;pushf;
  pushfd;
  ;pusha;
  pushad;
  ;push ds;

  
  ;save old stack position
  mov eax, dword [k_curtaskp];
  mov [eax], ebp;

  ;increment tick counter
  extern kernel_tick;
  add dword [kernel_tick], 1

  ;move to next task
  mov eax, [k_curtaskp]
  add eax, DWSIZE
  mov eax, [eax]
  
  mov dword [k_curtaskp], eax
  mov esp, eax
  mov esp, [esp];
  
  ;send ok to PIC
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  
  ;pop ds;
  popad;
  ;popa;
  popfd;
  ;popf;


  sti
  iret

; timer irq, used for task-switching
isr_00:
  
  cli;
  mov [dword 0xB8000], dword _CRED;

  
  ;pushf;
  pushfd;
  ;pusha;
  pushad;
  ;push ds;

  
  ;prevent bad prefetching behaviours
  mfence
  
  mov ebp, esp;
  
  ;save old stack position
  mov eax, dword [k_curtaskp];
  mov [eax], ebp;

  ;call isr0_debug on temporary stack
  ;extern isr0_debug;
  ;mov esp, isr_debug_stack_top;
  ;push ebp
  ;call isr0_debug
  ;pop esp
  
  ;increment tick counter
  extern kernel_tick;
  add dword [kernel_tick], 1
  
  ;move to next task
  mov eax, [k_curtaskp]
  add eax, DWSIZE
  mov eax, [eax]
  
  mov dword [k_curtaskp], eax
  mov esp, eax
  mov esp, [esp];
  
  ;send ok to PIC
  
  mov al, 20h
  out PIC1, al
  
  ;io_wait()
  out 80h, al 

  
  
  ;pop ds;
  popad;
  ;popa;
  popfd;
  ;popf;


  ;prevent bad prefetching behaviours
  mfence

  
  mov [dword 0xB8000], dword _CGRE;
  sti;

  iret
  
global __initTask2
extern _task_cleanup;

;it3_fcall:
;  ctx_push;
;  jmp __initTask3.next;
  
global __initTask3
__initdTask3: align 8
  
  cli;
  mov [dword 0xB8000], dword _CRED;
;
  push ebp;
  pushad;
  
  ;set threading head
  mov eax, [k_curtaskp];
  mov [eax], esp;
  mov ebp, esp;
  
  mov esp, [k_curtaskp];
  mov esp, [esp];
  
  popad
  pop ebp
  
  ;enable interrupts again
  
  mov [dword 0xB8000], dword _CGRE;
  sti;
;
  ret;

__initTask3: align 8
  
  cli;
  mov [dword 0xB8000], dword _CRED;
;
  ;mov ebp, esp
  
  ;set threading head
  mov eax, [k_curtaskp];
  mov [eax], esp;
  
  ;store entry point
  mov ebx, dword [esp + DWSIZE*1] 

  ;switch to new stack
  mov eax, dword [esp + DWSIZE*2] ;second argument is Task* pointer
  mov esp, [eax]
  
  ;argc/argv
  push dword [eax + 20];
  push dword [eax + 16];

  ;near return to _task_cleanup
  push dword _task_cleanup;
  
  ;eflags, required by interrupt handler
  pushfd
  
  ;mask out interrupt flag
  mov eax, [esp]
  or eax, (1<<9)
  mov [esp], eax;
  
  ;far return
  push dword 0x08;
  push ebx
  
  ;thread context
  
  ;pushf;
  pushfd;
  ;pusha;
  pushad;
  ;push ds;
;
  
  ;save new task's esp for later use
  mov ecx, esp;
  
  ;restore original thread's stack
  mov esp, [k_curtaskp];
  mov esp, [esp];
  
  ;get new task again
  mov eax, dword [esp + DWSIZE*2] ;second argument is Task* pointer
  
  ;update task's head
  mov dword [eax], ecx;
  
  ;enable interrupts again
  
  mov [dword 0xB8000], dword _CGRE;
  sti;
;
  ret;
    
align 8
switch_task_scratch:
dd 8

global task_yield
task_yield:
  
  cli;
  mov [dword 0xB8000], dword _CRED;

  
  ;set up irq-compatible far call: eflags, segment, return pointer.
  pushfd
  
  ;mask in interrupt flag
  mov eax, [esp]
  or eax, (1<<9)
  mov [esp], eax;
  
  call 0x08:__switchTask
  ret
  
;dw __switchTask, seg __switchTask
__switchTask:
  ;argument
  
  
  ;pushf;
  pushfd;
  ;pusha;
  pushad;
  ;push ds;
;
  
  ;save stack
  mov eax, dword [k_curtaskp];
  mov dword [eax], esp;
  
  ;move to next task
  mov eax, [k_curtaskp]
  add eax, DWSIZE;
  mov eax, [eax];
  mov dword [k_curtaskp], eax
  
  ;set stack
  mov esp, [eax];
  
  
  ;pop ds;
  popad;
  ;popa;
  popfd;
  ;popf;
;
  
  mov [dword 0xB8000], dword _CGRE;
  sti;
;
  
  ;emulate IRQ far return, which pops
  ;an eflags register off the stack after 
  ;doing the return
  push eax
  
  mov eax, [esp+DWSIZE*2] ;should be far return segment
  mov [esp+DWSIZE*3], eax
  mov eax, [esp+DWSIZE*1] ;should be far return pointer
  mov [esp+DWSIZE*2], eax
  
  pop eax
  
  add esp, 4
  
  db 0xcb; force far return
  dd 0;
  
global __initMainTask
__initMainTask:
  ;save current stack head
  mov eax, dword [k_curtaskp];
  mov [eax], esp;
  ret;

global set_PIT_count;

set_PIT_count:
	pushfd
	
  cli;
  mov [dword 0xB8000], dword _CRED;

	out 0x40, al        ; Set low byte of reload value
	rol ax, 4           ; al = high byte, ah = low byte
	out 0x40, al        ; Set high byte of reload value
	rol ax, 169         ; al = low byte, ah = high byte (ax = original reload value)
	popfd
	ret

align 8

global get_eip
get_eip:
  mov eax, [esp];
  ret;

global __initFPU

__initFPU:
  ret;
  

global emergency_proc_exit
emergency_proc_exit:
  cli
  
  ;set up emergency stack
  mov [emergency_proc_exit_stack], esp
  mov esp, [emergency_proc_exit_stack + 4]
  
  extern _emergency_proc_exit
  call _emergency_proc_exit
  
  pop esp
  
  ;call task_yield;
  ;mov ebx, .next
  ;jumpback should already be in ebx
  
  jmp raw_next_task
  ;.next:
  ;sti
  ;iret

global imemset
imemset:
  push ebp;
  mov ebp, esp;
  
  mov eax, [esp+DWSIZE*3]
  mov ebx, [esp+DWSIZE*2]
  mov ecx, [esp+DWSIZE]
  
  .back:
  mov [ecx+eax], ebx;
  dec eax;
  jnz .back
  
  pop ebp;
  ret
