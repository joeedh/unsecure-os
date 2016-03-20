;section .eh_frame
;global .eh_frame
;.eh_frame:
;  push eax;
;  push eax;
;  push eax;
;  push eax;
;  push eax;

section .text
align 8  

%define TTY_BUFFER_ROWS 900

%define MAX_TASKS 32

%define GDT_SIZE 5 ;number of gdt entries
%define PROCESS_SIZE 408 ;number of Process struct
%define TASK_SIZE 56 ;size of Task struct

%define DWSIZE 4

%define VGA_WIDTH 80
%define VGA_HEIGHT 25

%define BLUE   9   ;vga_light_blue, actually
%define BLACK  0  
%define WHITE  15 
%define RED    4    
%define GREEN  10 

; Declare constants used for creating a multiboot header.
MBALIGN     equ  1<<0                   ; align loaded modules on page boundaries
MEMINFO     equ  1<<1                   ; provide memory map
;MODINFO     equ  1<<3
;DRIVEINFO   equ  1<<7

FLAGS       equ  MBALIGN | MEMINFO   ; this is the Multiboot 'flag' field
MAGIC       equ  0x1BADB002          ; 'magic number' lets bootloader find the header
CHECKSUM    equ -(MAGIC + FLAGS)     ; checksum of above, to prove we are multiboot

extern terminal_set_debug;
extern terminal_set_idebug;

%macro _set_debug_char 3
  pushad;
  
  push dword %3
  push dword %2
  push dword %1
  call terminal_set_debug
  pop eax;
  pop eax;
  pop eax;
  
  popad;
%endmacro

%macro _set_debug_int 4
  pushad;
  
  push dword %4
  push dword %3
  push dword %2
  push dword %1
  
  call terminal_set_idebug
  
  pop eax;
  pop eax;
  pop eax;
  pop eax;
  
  popad;
%endmacro

%macro set_debug_char 3
  ;_set_debug_char %1 %2 %3
%endmacro

%macro set_debug_int 4
  ;_set_debug_int %1 %2 %3 %4
%endmacro
 
; debug channels for set_debug_char 
%define DEBUG_ISR00 4
;00-14 are reserved
%define DEBUG_ISR14 18

%define DEBUG_EXC  1
%define DEBUG_KEY  5

; Declare a header as in the Multiboot Standard. We put this into a special
; section so we can force the header to be in the start of the final program.
; You don't need to understand all these details as it is just magic values that
; is documented in the multiboot standard. The bootloader will search for this
; magic sequence and recognize us as a multiboot kernel.
section .multiboot
align 8

;size of tag header is added automatically
%macro tag 3 ;type, flags, size
  dw %1;
  dw %2;
  dd %3 + 8;
%endmacro

%macro optional_tag 3 ;type, flags, size
  dw %1;
  dw %2 | 1;
  dd %3 + 8;
%endmacro

;let's try multiboot2 spec
  dd 0xE85250D6
  dd 0x0 ;arch, 0 for x86 32-bit protected mode
  dd 16  ;header length
  ;dd -(0xE85250D6 + 16) ;checksum
  dd -0xe85250e6 ;checksum

;tag1:
;  optional_tag 1,0,4*32
;bootinfo:
;  times 32 dd 0;
tag2:
  tag 3,0,4 ;entry address tag
  dd _start;

;tag3: ;alignment
;  tag 6,0,4 ;module alignment flag
;  dd 0 ;unused
;tag4: ;memory
;  tag 4,0,8
;_mem_upper:  dd 0;
;_mem_lower:  dd 0;
  
;	dd MAGIC
;	dd FLAGS
;	dd CHECKSUM

section .gdt, nobits
global __k_gdt;

__k_gdt:
align 8
resb 8*6
global __k_gdt_end;
__k_gdt_end:
  
; Currently the stack pointer register (esp) points at anything and using it may
; cause massive harm. Instead, we'll provide our own stack. We will allocate
; room for a small temporary stack by creating a symbol at the bottom of it,
; then allocating 65536 bytes for it, and finally creating a symbol at the top.
global stack_top;

section .bootstrap_stack, nobits
stack_bottom: align 8
resb 65536
stack_top:

section .text
global tasks, terminal_buffer

terminal_buffer: align 8
times VGA_HEIGHT*VGA_WIDTH*2 db 0;

global terminal_history, terminal_linelasts;

terminal_history: align 8;
  times TTY_BUFFER_ROWS*VGA_WIDTH*2 db 0;
terminal_linelasts: align 8;
  times TTY_BUFFER_ROWS db 0;
tasks: align 8
  times TASK_SIZE*MAX_TASKS db 0;
tasks_end:

global processes;
processes: align 8
  times PROCESS_SIZE*MAX_TASKS db 0;
processes_end:

global tss_stack_top, tss_stack_bottom;

tss_stack_bottom: align 8
times 65536 db 0
tss_stack_top:

section .irq.table, nobits
global idt_table;

idt_table: align 8
  resb 8*256
  
global idt_table_end;
idt_table_end:

section .text

__k_idtr DW 0 ; For limit storage
         DD 0 ; For base storage
         
global _setIRT
_setIRT:
  cli
  
  push ax;
  push eax;
  push ebx;
  
  mov eax, idt_table
  mov [__k_idtr+2], eax

  ;size of idt minus 1
  mov ax, 2047
  mov [__k_idtr], ax
    
  lidt [__k_idtr];
  
  pop ebx;
  pop eax
  pop ax;
  
  ret
  
%define nconcat(a, b) a %+ b
%define PIC1 0x20
%define PIC2 0xA0

extern inside_irq;

%macro irq_entry 0
  cli;
  ;inc dword [inside_irq];
  ;sti;
%endmacro

%macro irq_iret 0
  ;cli;
  ;dec dword [inside_irq];
  
  sti;
  iret
%endmacro

;args: irq_number pic_number (pic1 for master, pic2 for slave)
%macro isr_wrapper 2
  irq_entry;
  
  ;cli
  push ebp  ;frame pointer
  mov  ebp, esp;
  
  pushad
  pushfd
  
  cld
  extern nconcat(_isr_handler, %1);
  call nconcat(_isr_handler, %1);
  
  mov al, 20h
  out %2, al
  
  popfd
  popad
  pop ebp;
  ;sti
  
  irq_iret
%endmacro


align 8
global _cpu_exception_flag
_cpu_exception_flag:
dd 0

global except_depth;
_except_depth:
dd 0

%macro exc_wrapper 2
  cli;
  push ebp ;deal with stack frame pointer
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char DEBUG_EXC, 69, RED
  set_debug_int DEBUG_EXC, 5, %1, RED
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, %2;
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern nconcat(_exc_handler, %1);
  call nconcat(_exc_handler, %1);
  
  pop eax;

  dec dword [_except_depth];
  
  jz .cleardebug;
  .back:
  
  popfd;
  popad;
  
  pop ebp ;pop saved frame pointer
  sti;
  iret;
  
  .cleardebug:
    set_debug_char DEBUG_EXC, 101, BLACK
    jmp .back
%endmacro

global exr_0, exr_1, exr_2, exr_3, exr_4, exr_5;
global exr_6, exr_7, exr_8, exr_9, exr_10, exr_11;
global exr_12, exr_13, exr_14;

align 8
exr_0: exc_wrapper 0, 1
;exr_1: exc_wrapper 1, 2

exr_1: ;special debug exception
  iret;
  
exr_2: exc_wrapper 2, 4
exr_3: exc_wrapper 3, 8
exr_4: exc_wrapper 4, 16
exr_5: exc_wrapper 5, 32
exr_6: exc_wrapper 6, 64
exr_7: exc_wrapper 7, 128
exr_8: exc_wrapper 8, 256
exr_9: exc_wrapper 9, 512
exr_10: exc_wrapper 10, 1024
exr_11: exc_wrapper 11, 2048
exr_12: exc_wrapper 12, 4096
exr_13: exc_wrapper 13, 8192
exr_14: exc_wrapper 14, 16384
  
%macro isr_wrapper_clilock 2
  irq_entry
  
  cli
  push ebp  ;frame pointer
  mov  ebp, esp;
  
  pushad
  pushfd
  
  cld
  extern nconcat(_isr_handler, %1);
  call nconcat(_isr_handler, %1);
  
  mov al, 20h
  out %2, al
  
  popfd
  popad
  
  pop ebp  ;frame pointer
  sti
  
  irq_iret
%endmacro

global isr_0, isr_1, isr_2, isr_3, isr_4, isr_end
global isr_5, isr_6, isr_7, isr_8, isr_9, isr_10
global isr_11, isr_12, isr_13, isr_14, isr_15

align 8;

;special spurious-irq-handling code
isr_7:
  pushad;
  pushfd;
  
  mov al, 20h
  out 20h, al
  
  popfd;
  popad;
  iret;

;isr_0: isr_wrapper          0, PIC1 ;timer
isr_1 : isr_wrapper_clilock  1, PIC1 ;keyboard
isr_2 : isr_wrapper          2, PIC1
isr_3 : isr_wrapper          3, PIC1
isr_4 : isr_wrapper          4, PIC1
isr_5 : isr_wrapper          5, PIC1
isr_6 : isr_wrapper          6, PIC1
;isr_7 : isr_wrapper          7, PIC1 ;spurior irq
isr_8 : isr_wrapper          8, PIC2
isr_9 : isr_wrapper          9, PIC2
isr_10: isr_wrapper         10, PIC2
isr_11: isr_wrapper         11, PIC2
isr_12: isr_wrapper         12, PIC2
isr_13: isr_wrapper         13, PIC2
isr_14: isr_wrapper         14, PIC2
isr_15: isr_wrapper         15, PIC2
isr_end:
 
; The linker script specifies _start as the entry point to the kernel and the
; bootloader will jump to this position once the kernel has been loaded. It
; doesn't make sense to return from this function as the bootloader is gone.
section .text
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
	cli
.hang:
	hlt
	jmp .hang

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
  cli
  
  mov eax, __k_gdt
  mov [__k_gdtr+2], eax

  ;size of gdt minus 1  
  mov ax, GDT_SIZE*8 - 1
  mov [__k_gdtr], ax
    
  lgdt [__k_gdtr];
  
  jmp 0x08:.flush;
  
  .flush:
    mov ax, 16;
    mov ds, ax;
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    
    ;set main TSS
    mov ax, 0x18;
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

%macro ctx_push 0
  ;pushf;
  pushfd;
  ;pusha;
  pushad;
  ;push ds;
%endmacro

%macro ctx_pop 0
  ;pop ds;
  popad;
  ;popa;
  popfd;
  ;popf;
%endmacro

%macro clear_nt 0  
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
%endmacro

extern get_next_task_timer;
extern task_switch_granularity;

isrdsf_0:
  pushad
  pushfd
  
  ;set_debug_char DEBUG_ISR00, 105, GREEN
  set_debug_int DEBUG_ISR00, 15, k_curtaskp, GREEN
  
  ;send ok to PIC
  mov al,20h
  out 20h,al
  
  popfd
  popad
  iret

align 8
; timer/task-switcher irq
isr_0:
  ;irq_entry
  cli;
  ctx_push
  
  ;increment tick counter
  extern kernel_tick;
  add dword [kernel_tick], 1;

  ;save old stack position
  mov eax, dword [k_curtaskp];
  mov [eax], esp;
  
  ;move to next task
  mov eax, [k_curtaskp]
  add eax, DWSIZE;
  mov eax, [eax];
  
  mov dword [k_curtaskp], eax
  mov esp, eax
  mov esp, [esp];
  
  ;send ok to PIC
  mov al, 20h
  out PIC1, al
  
  ctx_pop
  
  ;push eax;
  ;mov eax, dword [esp+4];
  ;set_debug_int DEBUG_ISR00, 15, eax, GREEN
  ;pop eax;
  
  set_debug_int DEBUG_ISR00, 15, [k_curtaskp], GREEN
  
  ;irq_iret
  sti;
  iret
  
global __initTask2
extern _task_cleanup;

_farTestA2:
  jmp __farTestA_tag.next
  
global __farTestA;
__farTestA:
  mov ebx, esp;
  mov esp, [esp+4]; //stack head argument
  
  call 0x08:_farTestA2
global __farTestA_tag
__farTestA_tag:
  
  .next:
  mov eax, esp; //return value
  mov esp, ebx;
  
  ret;


global __farTestB;
__farTestB:
  mov ebx, esp;
  mov esp, [esp+4]; //stack head argument
  
  push dword 0x08;
  push dword __farTestB_tag;
  
global __farTestB_tag;
__farTestB_tag:

  mov eax, esp; //return value
  mov esp, ebx;
  
  ret;
  
global __switchB;
__switchB:
  ctx_push
  
  ;set new stack head 
  mov eax, [k_curtaskp];
  mov eax, dword [eax + 12];
  mov dword [eax], esp;
  
  ;jmp __initTask2.next;
  
global __initTask3
__initTask3:
  cli;
  ;mov ebp, esp;
  ;pushad;
  
  ;set threading head
  mov eax, [k_curtaskp];
  mov [eax], esp;
  
  ;store entry point
  mov ebx, dword [esp + DWSIZE*1] 

  ;switch to new stack
  mov eax, dword [esp + DWSIZE*2] ;second argument is Task* pointer
  mov esp, [eax]
  
  ;push argc/argv
  push dword [eax + 20];
  push dword [eax + 16];

  ;push return call to _task_cleanup
  push dword _task_cleanup;
  push dword _task_cleanup;

  push dword 0x08;
  push ebx
  
  ctx_push;
  
  mov dword [eax], esp;
  
  ;restore original thread's stack
  mov esp, [k_curtaskp];
  mov esp, [esp];
  
  ;popad;
  
  ;enable interrupts again
  sti;
  ret;
  
__initTask2old:
  ;save old stack position
  mov eax, dword [k_curtaskp];
  mov dword [eax], esp;
  mov ecx, esp;
  
  ;save third argument, pointer to new task
  mov eax, [esp + DWSIZE*3]; //new task
  mov ebx, [k_curtaskp];
  mov dword [ebx + 12], eax;
  
  mov eax, [esp + DWSIZE];   //new stack
  mov ebx, [esp + DWSIZE*2]; //entry point
  
  ;switch to new stack
  mov esp, [esp + DWSIZE];
  
  ;put entry point before return jump pointer, on new stack
  push ebx;
  push ebx;
  ;mov ebx, __initTask2.next;
  
  ;set up return jump pointer on new stack
  call 0x08:__switchB;
  
  ;we're now within the new thread
  ;jump to entry point
  pop ebx;
  
  ;mov argc/argv to right spot in stack
  mov eax, [k_curtaskp];
  push dword [eax + 20];
  push dword [eax + 16];
  
  ;enable interrupts again
  sti;

  ;call entry point for thread
  push ebp;
  mov ebp, esp  ; update stack frame pointer
  call ebx;
  pop ebp;
  
  push ebp;
  mov ebp, esp  ; update stack frame pointer
  call _task_cleanup;
  pop ebp;
  
  .next:
  
  ;reset stack
  mov esp, ecx
  ;mov eax, dword [k_curtaskp];
  ;mov esp, dword [eax];

  ;sti;
  ret;
    
global task_switch;
task_switch:
  cli;
  mov eax, [esp + 4];
  mov [k_debug], eax;
  
  ;set up far call.  push argument.
  call 0x08:__switchTask;
  
  ret;
  
;section .code;

align 8
switch_task_scratch:
dd 8

;dw __switchTask, seg __switchTask
__switchTask:
  ;argument
  
  ;sti;
  mov eax, [esp + 12];
  mov dword [k_debug2], eax;
  
  mov ebx,  dword [esp + 12]
  mov dword [switch_task_scratch], ebx;
  
  ctx_push;
  
  ;save stack
  mov eax, dword [k_curtaskp];
  mov dword [eax], esp;
  
  mov ebx, [k_curtaskp];
  mov esp, ebx;
  mov esp, [esp];
  
  ctx_pop;
  
  sti;
  db 0xcb; force far return
  dd 0;
  
global __initMainTask
__initMainTask:
  ;save current stack head
  mov eax, [k_curtaskp];
  mov [eax], esp;
  ret;
  
;section .vga_tty nobits

global terminal_buffer

;section .timerinit

global set_PIT_count;
set_PIT_count:
	pushfd
	cli
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
