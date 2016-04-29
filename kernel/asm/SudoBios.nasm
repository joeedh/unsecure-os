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
