; modified - http://board.flatassembler.net/topic.php?p=23957#23957
macro align value {
local _16bit, exit
virtual
  align value
  ..align=$-$$
end virtual
virtual at 0
  xchg eax, eax
  _16bit=$-1
end virtual

  if ..align>16
    jmp exit
    if ..align>127
      if _16bit
        ..align=..align-3
      else
        ..align=..align-5
      end if
    else
      ..align=..align-2
    end if
  end if
  times ..align/8 db $3E, $8D, $04, $05, $00, $00, $00, $00
  ..align=..align mod 8
  if ..align=7
    db $8D, $04, $05, $00, $00, $00, $00
  else if ..align=6
    db $8D, $80, $00, $00, $00, $00
  else if ..align=5
    db $3E, $8D, $54, $22, $00
  else if ..align=4
    db $8D, $44, $20, $00
  else if ..align=3
    db $8D, $40, $00
  else if ..align=2
    db $8B, $C0
  else if ..align=1
    db 90h
  end if
  exit:
}
