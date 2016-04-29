
global vbe3_bios_image
vbe3_bios_image:
  dd 0

global vbe3_bios_sel, vbe3_bios_offset
global vbe3_ctrlr_info:
  push ebp
  mov ebp, esp
  
  pushad
  
  ;get entry point from pminfo structure and put into ecx
  mov ecx, [esp + 4]
  mov ecx, [ecx]
  mov ecx, [ecx]
  ;add ecx, 4 ;entry point
  
  ;get 16-bit code selector from videobios struct and put into ebx
  mov ebx, [ebp + 4]
  mov ebx, [ebx]
  add ebx, 8 ;entry point
  mov ebx, [ebx]
  
  ;get stack pointer into edx
  mov edx, [esp+4];
  mov edx, [edx]
  add edx, 8;
  mov edx, [edx]
  
  ;build 16-bit stack
  mov [edx], esp
  mov [edx-12], ecx ;call address
  sub edx, 16
  
  mov esp, edx
  mov edx, [esp]
  
  ;construct far call opcode
  ;we have to do this since we don't know what the GDT
  ;descriptors will be at compile-time
  
  ;we're building a 32-bit seg:offset opcode operand.
  ;offset is set here, while seg is set in vesa.c.
  ;vbe3_bios_sel is set by vesa.c
  mov word [vbe3_bios_offset], cx
  
  db 0x9a ;call instruction
vbe3_bios_sel:
  dw 0 ;first 16 bits of operand
vbe3_bios_offset:
  dd 0 ;final 32 bits of operand
  
  pop esp
  popad
  
  pop ebp
  ret
