{
From: CHRIS PRIEDE
Subj: Rebooting...

issue DOS Flush Buffers call AND reboot }

procedure SafeReboot; far; assembler;
asm
  mov   ah, 0Dh
  int   21h
  xor   cx, cx
@1:
  push  cx
  int   28h
  pop   cx
  loop  @1
  mov   ds, cx
  mov   word ptr [472h], 1234h
  dec   cx
  push  cx
  push  ds
end;
