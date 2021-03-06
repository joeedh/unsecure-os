

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






extern terminal_set_idebug;



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
  mov [dword 0xB8000], dword _CLGN ; _CRED

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



section .text

global inside_irq, inside_exc
align 8
inside_irq: dd 0
inside_exc: dd 0

align 8

__k_idtr: 
DW 0 ; For limit storage
DD 0 ; For base storage
         
global _setIRT
_setIRT:
  
  cli;
  mov [dword 0xB8000], dword _CLGN ; _CRED

  
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

;args: [irq_number, pic_number] (pic1 for master, pic2 for slave)



align 8
global _cpu_exception_flag
_cpu_exception_flag:
dd 0

;make exc_has_error table
align 16
global exc_has_error

;see page 2186 of intel docs
exc_has_error:
dd 0  ;0
dd 0  ;1
dd 0  ;2
dd 0  ;3
dd 0  ;4
dd 0  ;5
dd 0  ;6
dd 0  ;7
dd 1  ;8
dd 0  ;9
dd 1  ;10
dd 1  ;11
dd 1  ;12
dd 1  ;13
dd 1  ;14
dd 0  ;15
dd 0  ;16
dd 1  ;17
dd 0  ;18
dd 0  ;19
dd 0  ;20

  times DWSIZE*12 db 0
  ;resb DWSIZE*12
;

;saves state in ctx_push-compatible order
;

extern _on_exception;
global _exception_resume

;args: new eip, new esp
_exception_resume:
  cli
  
  ;save eip
  mov eax, [esp+DWSIZE]
  mfence;
  
  ;switch to new stack
  mov esp, [esp+DWSIZE*2]
  mfence;
  
  push eax
  mfence
  
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov ecx, [eax+DWSIZE*7]
  mov edx, [eax+DWSIZE*6]
  mov ebx, [eax+DWSIZE*5]
  
  mov ebp, [eax+DWSIZE*3]
  mov esi, [eax+DWSIZE*2]
  mov edi, [eax+DWSIZE*1]
  
  ;load eflags
  push dword [eax]
  popfd
  
  ;skip esp
  ;mov esp, [eax+DWSIZE*4]
  
  ;do eax
  mov eax, [eax + DWSIZE*8]

  mfence
  
  sti
  ret
  
  ;push new eip as return pointer
  ;call .get_eip
  ;.get_eip:
  ;  ;lea dword [esp], eax
  ;  mov [esp], eax
  ;  mfence
  ;  ret

__on_exception:
  push ecx
  push ebx
  push eax
  
  call _on_exception
  
;saves state in ctx_push-compatible order
;

;macro takes two arguments
;exception handler, modifies stack so as to jump to the real handler after iret


global exr_0, exr_1, exr_2, exr_3, exr_4, exr_5;
global exr_6, exr_7, exr_8, exr_9, exr_10, exr_11;
global exr_12, exr_13, exr_14, exr_15, exr_16, exr_17, exr_18;

align 8
exr_0: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 0*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  0
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_1: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 1*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  1
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret


;exr_1: ;special debug exception
;  iret;

exr_2: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 2*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  2
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_3: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 3*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  3
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_4: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 4*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  4
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_5: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 5*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  5
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_6: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 6*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  6
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_7: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 7*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  7
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_8: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 8*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  8
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_9: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 9*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  9
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_10: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 10*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  10
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_11: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 11*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  11
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_12: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 12*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  12
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_13: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 13*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  13
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_14: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 14*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  14
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_15: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 15*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  15
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_16: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 16*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  16
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_17: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 17*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  17
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret

exr_18: 
  align 8;
  
  
  push eax
  
  mov eax, [k_curtaskp]
  add eax, 56
  
  mov [eax+DWSIZE*7], ecx
  mov [eax+DWSIZE*6], edx
  mov [eax+DWSIZE*5], ebx
  
  mov [eax+DWSIZE*4], esp
  add dword [eax+DWSIZE*4], DWSIZE*6 ;stack should be: eax, return addr, cs (0x08), eflags
  
  mov [eax+DWSIZE*3], ebp
  mov [eax+DWSIZE*2], esi
  mov [eax+DWSIZE*1], edi
  
  ;save eax
  pop ebx
  mov [eax+DWSIZE*8], ebx
  
  ;save eflags
  pushfd
  pop ebx
  or ebx, 1<<9 ;ensure interrupt are enabled
  
  mov [eax], ebx

  
  inc dword [inside_exc]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;deal with stack frame pointer
  mfence
  push ebp
  mov ebp, esp
  mfence
  
  ;make sure code value argument to handler defaults to 0
  mov ebx, 0
  
  ;check if theres an error code on the stack
  ;mov eax, exc_has_error
  ;add eax, 18*DWSIZE
  ;mov eax, dword [eax]
  ;test eax, 1
  
  ;no error code?
  ;jnz .next

  ;get error code
  ;mov edx, [esp+DWSIZE]
  ;add ebp, DWSIZE
  
  ;.next:
  
  ;update eip in cpudata structure
  mov ecx, [k_curtaskp]
  add ecx, 56+DWSIZE*9 ;add offset to eip pointer
  mov eax, dword [ebp + DWSIZE]
  mov dword [ecx], eax
  
  ;arguments to __on_exception are stored in eax, ebx, ecx
  
  ;store code
  mov eax,  18
  
  ;store pointer to cpuid structure
  mov ecx, [k_curtaskp]
  add ecx, 56
  
  ;change long-return address
  mov dword [ebp + DWSIZE], __on_exception

  ;clear exceptions
  fclex
  
  pop ebp

  dec dword [inside_exc]
  iret


;takes two arguments


global isr_0, isr_1, isr_2, isr_3, isr_4, isr_end
global isr_5, isr_6, isr_7, isr_8, isr_9, isr_10
global isr_11, isr_12, isr_13, isr_14, isr_15

align 8;
_isr_7_message:
  db 'IRQ 7 detected!\n\0'
  
;special spurious-irq-handling code
isr_7:
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret

  
_isr_15_message:
  db 'IRQ 15 detected!\n\0'

;special spurious-irq-handling code
isr_15:
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


;isr_0: isr_wrapper(          0, PIC1) ;timer
isr_1 : 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
  ;dosti;

  
  mfence
  
  
  cli;
  mov [dword 0xB8000], dword _CLGN ; _CRED

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
  
  mov [dword 0xB8000], dword _CGRE
  sti

  
  popfd;
  popad;
  mfence
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret

 ;keyboard
isr_2 : 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_3 : 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_4 : 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_5 : 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_6 : 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


;isr_7 : isr_wrapper(          7, PIC1 ;spurious irq
isr_8 : 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_9 : 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_10: 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_11: 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_12: 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_13: 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret


isr_14: 
  
  inc dword [inside_irq]
  
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  mfence
  pushad;
  pushfd;
  ;docli;
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
  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  
  mov [dword 0xB8000], dword _CGRE
  sti

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
  mov [dword 0xB8000], dword _CLGN ; _CRED

  
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
  
  
  popad;
  popfd;

  
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
  inc dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
  ;increment tick counter
  extern kernel_tick;
  add dword [kernel_tick], 1
  
  
  pushfd;
  pushad;


  ;save stack
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

  
  
  popad;
  popfd;

  
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

  
  dec dword [inside_irq]
  
  ;save registers
  pushad
  pushfd
  
  
  ;calculate character to display
  mov eax, [inside_irq]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEIRQ
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;calculate character to display
  mov eax, [inside_exc]
  add eax, 48 ;add ascii of 0 character
  
  ;push arguments
  push dword 10
  push eax
  push dword DEBUG_INSIDEEXC
  
  call terminal_set_debug
  
  ;pop arguments
  add esp, DWSIZE*3

  
  ;restore registers
  popfd
  popad

  
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
  
  pushfd;
  pushad;

  
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

  
  
  popad;
  popfd;


  sti
  iret

; timer irq, used for task-switching
isr_00:
  
  cli;
  mov [dword 0xB8000], dword _CLGN ; _CRED

  
  pushfd;
  pushad;

  
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

  
  
  popad;
  popfd;


  ;prevent bad prefetching behaviours
  mfence

  
  mov [dword 0xB8000], dword _CGRE
  sti

  iret
  
global __initTask2
extern _task_cleanup;

;it3_fcall:
;  ctx_push;
;  jmp __initTask3.next;
  
global __initTask3
__initdTask3: align 8
  
  cli;
  mov [dword 0xB8000], dword _CLGN ; _CRED
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
  
  mov [dword 0xB8000], dword _CGRE
  sti
;
  ret;

global _thread_ctx_push
_thread_ctx_push:
  push ebp;
  push ebx;
  push ecx;
  
  mov ebp, esp;
  
  mov eax, [ebp + DWSIZE]; stack pointer
  
  ;save old stack for later
  mov ecx, esp;
  
  ;set new stack pointer
  mov esp, eax;
  
  ;push context, minus far return pointer+seg
  
  pushfd;
  pushad;
;
  
  ;set return value for final new stack in eax
  mov eax, esp;
  
  ;restore original stack pointer
  mov esp, ecx;
  
  pop ecx;
  pop ebx;
  pop ebp;
  ret;
  
__initTask3: align 8
  
  cli;
  mov [dword 0xB8000], dword _CLGN ; _CRED
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
  
  ;ensure interrupts are enabled in eflags
  mov eax, [esp]
  or eax, (1<<9)
  mov [esp], eax;
  
  ;far return
  push dword 0x08;
  push ebx
  
  ;thread context
  
  pushfd;
  pushad;
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
  
  mov [dword 0xB8000], dword _CGRE
  sti
;
  ret;
    
align 8
switch_task_scratch:
dd 8

global task_yield
task_yield:
  
  cli;
  mov [dword 0xB8000], dword _CLGN ; _CRED

  
  ;check if we're inside an irq or exception handler
  ;mov eax, 0
  ;add eax, dword [inside_irq]
  ;add eax, dword [inside_exc]
  ;jnz .inside_irq_exc
  
  ;set up irq-compatible far call: eflags, segment, return pointer.
  pushfd
  
  ;mask in interrupt flag
  mov eax, [esp]
  or eax, (1<<9)
  mov [esp], eax;
  
  call 0x08:__switchTask
  ret
    
  .inside_irq_exc:
    ;do nothing
    
    ret
    
;dw __switchTask, seg __switchTask
__switchTask:
  ;argument
  
  
  
  pushfd;
  pushad;

  
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
  
  
  popad;
  popfd;


  
  
  mov [dword 0xB8000], dword _CGRE
  sti
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
  mov [dword 0xB8000], dword _CLGN ; _CRED

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
_old_emergency_proc_exit:
  cli
  
  ;set up emergency stack
  mov [emergency_proc_exit_stack], esp
  mov esp, [emergency_proc_exit_stack + 4]
  
  ;extern _emergency_proc_exit
  ;call _emergency_proc_exit
  
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
