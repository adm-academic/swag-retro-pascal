{
> How do I clear the screen fast (asm code please) in mode 13h
> (320x200x256)???????
}
Procedure ClearScreen(Col : Byte); assembler;
asm
   mov  ax, $A000
   mov  es, ax
   mov  cx, 32000
   xor  di, di
   mov  al, Col
   mov  ah, al
   rep  stosw
end;
{ that should do it.  It'll clear it to Col }
