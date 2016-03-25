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
