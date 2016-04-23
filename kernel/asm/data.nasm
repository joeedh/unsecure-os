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
reszero(65536)
tss_stack_top:
reszero(32);

section .irq.table, nobits
global idt_table;

idt_table: align 8
  resb 8*256
  
global idt_table_end;
idt_table_end:
