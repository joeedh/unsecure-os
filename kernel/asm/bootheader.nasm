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
  mb2_tag 1, 0, 24
  dd 6;
  dd 2;
  dd 4;
  dd 15;
  dd 10;
  dd 5;

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
  
;mb2_tag 5, 0, 12 ; framebuffer
;dd 120
;dd 64
;dd 0
  
;mb_sentinel: align 4
  mb2_tag 0, 0, 0   ; null_terminated?

reszero(512) ;ensure padding before stack

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
	docli
.hang:
	hlt
	jmp .hang

