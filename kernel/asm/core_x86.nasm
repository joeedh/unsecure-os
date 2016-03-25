m4_changecom(`;', `')

m4_include(`definitions.nasm')
m4_include(`bootheader.nasm')
m4_include(`data.nasm')

section .text
align 8

__k_idtr: 
DW 0 ; For limit storage
DD 0 ; For base storage
         
global _setIRT
_setIRT:
  docli
  
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

;args: [irq_number, pic_number] (pic1 for master, pic2 for slave)
m4_define(`isr_wrapper', `
  irq_entry
  
  pusha
  pushad
  pushfd
  
  mov al, 105
  out byte 0xE9, byte al
  mov al, 48 + $1
  out byte 0xE9, byte al
  mov al, 10
  out byte 0xE9, byte al
  mov al, 0
  out byte 0xE9, byte al
  
  push ebp  ;frame pointer
  mov  ebp, esp;
  cld
  extern nconcat(_isr_handler, $1);
  call nconcat(_isr_handler, $1);
  pop ebp;
  
  mov al, 20h
  out $2, al
  
  popfd
  popad
  popa
  
  irq_iret
')


align 8
global _cpu_exception_flag
_cpu_exception_flag:
dd 0

global except_depth;
_except_depth:
dd 0

;takes two arguments
m4_define(`exc_wrapper', `
  align 8;
  
  ;deal with stack frame pointer
  push ebp 
  mov ebp, esp;
  
  pushad;
  pushfd;
  
  ;set_debug_char(DEBUG_EXC, 69, RED)
  ;set_debug_int(DEBUG_EXC, 5, $1, RED)
  
  mov al, 101
  out byte 0xE9, byte al
  out 0x80, al
  mov al, 48 + $1
  out byte 0xE9, byte al
  out 0x80, al
  mov al, 10
  out byte 0xE9, byte al
  out 0x80, al
  mov al, 0
  out byte 0xE9, byte al
  out 0x80, al
  
  cld
  
  inc dword [_except_depth];
  
  mov eax, $2;
  push eax;
  
  ;clear exceptions
  fclex;
  extern nconcat(_exc_handler, $1);
  call nconcat(_exc_handler, $1);
  pop eax;

  dec dword [_except_depth];
  jz .cleardebug;

  .back:
    popfd;
    popad;
    
    fclex;
    
    ;pop saved frame pointer
    pop ebp 
    dosti;
    iret;
  
  .cleardebug:
    set_debug_char(DEBUG_EXC, 101, BLACK)
    jmp .back
')

global exr_0, exr_1, exr_2, exr_3, exr_4, exr_5;
global exr_6, exr_7, exr_8, exr_9, exr_10, exr_11;
global exr_12, exr_13, exr_14, exr_15, exr_16, exr_17, exr_18;

align 8
exr_0: exc_wrapper( 0, 1)
;exr_1: exc_wrapper( 1, 2)

exr_1: ;special debug exception
  iret;
  
exr_2: exc_wrapper( 2, 4)
exr_3: exc_wrapper( 3, 8)
exr_4: exc_wrapper( 4, 16)
exr_5: exc_wrapper( 5, 32)
exr_6: exc_wrapper( 6, 64)
exr_7: exc_wrapper( 7, 128)
exr_8: exc_wrapper( 8, 256)
exr_9: exc_wrapper( 9, 512)
exr_10: exc_wrapper( 10, 1024)
exr_11: exc_wrapper( 11, 2048)
exr_12: exc_wrapper( 12, 4096)
exr_13: exc_wrapper( 13, 8192)
exr_14: exc_wrapper( 14, 16384)
exr_15: exc_wrapper( 15, (1<<14))
exr_16: exc_wrapper( 16, (1<<15))
exr_17: exc_wrapper( 17, (1<<16))
exr_18: exc_wrapper( 18, (1<<17))

;takes two arguments
m4_define(`isr_wrapper_clilock', `
  irq_entry
  
  docli
  ;push ebp  ;frame pointer
  ;mov  ebp, esp;
  
  pushad
  pushfd
  
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
  
  cld
  extern nconcat(_isr_handler, $1);
  call nconcat(_isr_handler, $1);
  
  mov al, 20h
  out $2, al
  
  popfd
  popad
  
  ;pop ebp  ;frame pointer
  dosti
  
  irq_iret
')

global isr_0, isr_1, isr_2, isr_3, isr_4, isr_end
global isr_5, isr_6, isr_7, isr_8, isr_9, isr_10
global isr_11, isr_12, isr_13, isr_14, isr_15

align 8;
_isr_7_message:
  db 'IRQ 7 detected!\n\0'
  
;special spurious-irq-handling code
isr_7:
  pushad;
  pushfd;
  
  push _isr_7_message;
  call e9printf;
  pop eax;
  
  mov al, 20h
  out 20h, al
  
  popfd;
  popad;
  iret;
  
_isr_15_message:
  db 'IRQ 15 detected!\n\0'

;special spurious-irq-handling code
isr_15:
  pushad;
  pushfd;
  
  push _isr_15_message;
  call e9printf;
  pop eax;
  
  mov al, 20h
  out PIC2, al
  
  popfd;
  popad;
  iret;

;isr_0: isr_wrapper(          0, PIC1) ;timer
isr_1 : isr_wrapper_clilock(  1, PIC1) ;keyboard
isr_2 : isr_wrapper(          2, PIC1)
isr_3 : isr_wrapper(          3, PIC1)
isr_4 : isr_wrapper(          4, PIC1)
isr_5 : isr_wrapper(          5, PIC1)
isr_6 : isr_wrapper(          6, PIC1)
;isr_7 : isr_wrapper(          7, PIC1 ;spurious irq
isr_8 : isr_wrapper(          8, PIC2)
isr_9 : isr_wrapper(          9, PIC2)
isr_10: isr_wrapper(         10, PIC2)
isr_11: isr_wrapper(         11, PIC2)
isr_12: isr_wrapper(         12, PIC2)
isr_13: isr_wrapper(         13, PIC2)
isr_14: isr_wrapper(         14, PIC2)
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
  docli
  
  mov eax, __k_gdt
  mov [__k_gdtr+2], eax

  ;size of gdt minus 1  
  mov ax, GDT_ENTRIES*8 - 1
  mov [__k_gdtr], ax
    
  lgdt [__k_gdtr];
  
  jmp 0x08:.flush;
  
  .flush:
    mov ax, 0x10;
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

extern get_next_task_timer;
extern task_switch_granularity;

isfdsfr_0:
  pushad
  pushfd
  
  ;move to next task
  ;mov eax, [k_curtaskp]
  ;add eax, DWSIZE;
  ;mov eax, [eax];
  ;mov dword [k_curtaskp], eax
  
  ;set_debug_char(DEBUG_ISR00, 105, GREEN)
  ;docli
  ;set_debug_int(25, 15, [eax], BLUE)
  ;dosti
  
  ;send ok to PIC
  mov al,20h
  out 20h,al
  
  popfd
  popad
  iret

isr_debug_stack_bottom:
reszero(32*1024)
isr_debug_stack_top:

; timer irq, used for task-switching
isr_0:
  docli
  ctx_push
  
  mov ebp, esp;
  
  ;save old stack position
  mov eax, dword [k_curtaskp];
  mov [eax], ebp;

  ;call isr0_debug on temporary stack
  ;extern isr0_debug;
  ;mov esp, isr_debug_stack_top;
  ;push ebp;
  ;call isr0_debug;
  ;pop esp;
  
  ;increment tick counter
  extern kernel_tick;
  add dword [kernel_tick], 1;
  
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
  
  dosti;
  iret
  
global __initTask2
extern _task_cleanup;

it3_fcall:
  ctx_push;
  jmp __initTask3.next;
  
global __initTask3
__initTask3: align 8
  docli;
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
  
  ;call 0x08:it3_fcall
  .next:
  
  ;save new task's esp for later use
  mov ebp, esp;
  
  ;restore original thread's stack
  mov esp, [k_curtaskp];
  mov esp, [esp];
  
  ;get new task again
  mov eax, dword [esp + DWSIZE*2] ;second argument is Task* pointer
  
  ;update task's head
  mov dword [eax], ebp;
  
  ;popad;
  
  ;enable interrupts again
  dosti;
  ret;
    
global task_switch;
task_switch:
  docli;
  mov eax, [esp + 4];
  mov [k_debug], eax;
  
  ;set up far call.  push argument.
  call 0x08:__switchTask;
  
  ret;

align 8
switch_task_scratch:
dd 8

;dw __switchTask, seg __switchTask
__switchTask:
  ;argument
  
  ;dosti;
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
  
  dosti;
  db 0xcb; force far return
  dd 0;
  
global __initMainTask
__initMainTask:
  ;save current stack head
  mov eax, [k_curtaskp];
  mov [eax], esp;
  ret;

global set_PIT_count;

set_PIT_count:
	pushfd
	docli
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
