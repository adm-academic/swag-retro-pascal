{
>I am looking for some code to turn on/off the modem and use
>it to make telephone calls.  If you have the code, pleas post
>it if you could.  Many thanks.

I really don't know about making a call, but here are two procs to turn
on/off an internal modem:
}
procedure modem_on; assembler;
asm
  mov ax,4401h
  int 15h
end;

procedure modem_off; assembler;
asm
  mov ax,4400h
  int 15h
end;
