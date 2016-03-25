section .gdt, nobits
global __k_gdt;

__k_gdt:
align 8
resb 8*8
global __k_gdt_end;
__k_gdt_end:

section .text
align 8
global tasks, terminal_buffer

terminal_buffer: align 8
reszero(VGA_HEIGHT*VGA_WIDTH*2)

global terminal_history, terminal_linelasts;

terminal_history: align 8;
  reszero(TTY_BUFFER_ROWS*VGA_WIDTH*2)
terminal_linelasts: align 8;
  reszero(TTY_BUFFER_ROWS)
tasks: align 8
  reszero(TASK_SIZE*MAX_TASKS)
tasks_end:

global processes;
processes: align 8
  reszero(PROCESS_SIZE*MAX_TASKS)
processes_end:

global tss_stack_top, tss_stack_bottom;

tss_stack_bottom: align 8
reszero(65536)
tss_stack_top:

section .irq.table, nobits
global idt_table;

idt_table: align 8
  resb 8*256
  
global idt_table_end;
idt_table_end:
