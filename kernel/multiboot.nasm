%define POINTERSIZE 2
%define TASK_SIZE 52 ;size of Task struct
%define DWSIZE 4
%define LOCK_SIZE 8;


%define VGA_WIDTH 80
%define VGA_HEIGHT 25

; Declare constants used for creating a multiboot header.
MBALIGN     equ  1<<0                   ; align loaded modules on page boundaries
MEMINFO     equ  1<<1                   ; provide memory map
FLAGS       equ  MBALIGN | MEMINFO      ; this is the Multiboot 'flag' field
MAGIC       equ  0x1BADB002             ; 'magic number' lets bootloader find the header
CHECKSUM    equ -(MAGIC + FLAGS)        ; checksum of above, to prove we are multiboot
 
; Declare a header as in the Multiboot Standard. We put this into a special
; section so we can force the header to be in the start of the final program.
; You don't need to understand all these details as it is just magic values that
; is documented in the multiboot standard. The bootloader will search for this
; magic sequence and recognize us as a multiboot kernel.
section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

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
; then allocating 16384 bytes for it, and finally creating a symbol at the top.
global stack_top;

section .bootstrap_stack, nobits
align 4
stack_bottom:
resb 16384
stack_top:

section .irq.table, nobits
global idt_table;

align 8
idt_table:
  align 8
  resb 8*256
  
global idt_table_end;
idt_table_end:

section .irq

__k_idtr DW 0 ; For limit storage
         DD 0 ; For base storage
         
global _setIRT
_setIRT:
  cli
  
  push eax;
  push ebx;
  
  mov eax, idt_table ;- 1048576
  mov [__k_idtr+2], eax

  ;size of idt minus 1
  mov ax, 2047
  mov [__k_idtr], ax
    
  lidt [__k_idtr];
  
  ;pushfd
  ;pop eax
  ;mov ebx,4096
  ;por eax,rbx
  ;push eax
  ;popfd
  
  
  pop ebx;
  pop eax
    
    ;sti
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
  
  pushad
  pushfd
  
  cld
  extern nconcat(_isr_handler, %1);
  call nconcat(_isr_handler, %1);
  
  mov al, 20h
  out %2, al
  
  popfd
  popad
  ;sti
  
  cli;
  add dword [inside_irq], 0;
  sti;
  
  irq_iret
%endmacro


align 8
global _cpu_exception_flag
_cpu_exception_flag:
dd 0x0;

%macro exc_wrapper 2
  pushad;
  pushfd;
  
  cld
  
  mov eax, %2;
  push eax;
  
  ;clear exceptions
  fclex;
  
  extern nconcat(_exc_handler, %1);
  call nconcat(_exc_handler, %1);
  
  pop eax;
  
  popfd;
  popad;
%endmacro

align 8
exr_0: exc_wrapper 0, 1
exr_1: exc_wrapper 1, 2
exr_2: exc_wrapper 2, 4
exr_3: exc_wrapper 3, 8
exr_4: exc_wrapper 4, 16
exr_5: exc_wrapper 5, 32
exr_6: exc_wrapper 6, 64
exr_7: exc_wrapper 7, 128
  
%macro isr_wrapper_clilock 2
  irq_entry
  
  cli
  pushad
  pushfd
  
  cld
  extern nconcat(_isr_handler, %1);
  call nconcat(_isr_handler, %1);
  
  mov al, 20h
  out %2, al
  
  popfd
  popad
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
isr_1 : isr_wrapper_clilock  1, PIC1
isr_2 : isr_wrapper          2, PIC1
isr_3 : isr_wrapper          3, PIC1
isr_4 : isr_wrapper          4, PIC1
isr_5 : isr_wrapper          5, PIC1
isr_6 : isr_wrapper          6, PIC1
;isr_7 : isr_wrapper          7, PIC1
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
 
	; We are now ready to actually execute C code. We cannot embed that in an
	; assembly file, so we'll create a kernel.c file in a moment. In that file,
	; we'll create a C entry point called kernel_main and call it here.
	
   extern kernel_main
	 call kernel_main
  
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
  mov ax, 39 ;__k_gdt_end - __k_gdt
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
    
    ;set main tss
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

;section task_def nobits
global tasks

align 8
tasks: align 8
resb TASK_SIZE*512;
tasks_end:

;section task_stuff
align 8

extern next_task;
extern k_curtaskp;
extern k_lasttaskp;
extern k_debug;
extern k_debug2;
extern _isr_handler0;

%macro ctx_push 0
  pushad;
  pushfd;
  push ds;
%endmacro

%macro ctx_pop 0
  pop ds;
  popfd;
  popad;
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
  
align 8
; timer/task-switcher irq
isr_0:
  cli ;disable interrupts for handler
  
  irq_entry
  
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
  mov al,20h
  out 20h,al
  
  ctx_pop

  ;clear_nt
  
  sti ;  re-enable interrupts
  irq_iret
  
global __initTask, __initTask2
extern set_k_curtaskp;

global scratchptr3;

align 8;
scratchptr: dd 32;
align 8;
scratchptr2: dd 32;
align 8;
scratchptr3: dd 32;

extern _task_cleanup;

global __switchB;
__switchB:
  ctx_push
  
  ;set new stack head 
  mov eax, [k_curtaskp];
  mov eax, dword [eax + 12];
  
  mov dword [eax], esp;
  
  jmp __initTask2.next;
  
__initTask2:
  ;save old stack position
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
  mov ebx, __initTask2.next;
  
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
  call ebx;
  call _task_cleanup;
  
  .next:
  
  ;reset stack
  mov esp, ecx
  
  sti;
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

align 8;
terminal_buffer:
resb VGA_HEIGHT*VGA_WIDTH*2;

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
