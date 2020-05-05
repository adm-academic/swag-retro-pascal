{
R C A Aldridge <RCA%IBM-B.RUTHERFORD.AC.UK@ib.rl.ac.uk>

+-------------------------------------+
| Input / Output via the printer port |
+-------------------------------------+
+--------------------------+------------------------------+
| By: Rafe Aldridge,       | E-Mail:                      |
|     Street Farm,         | until July 1994:             |
|     Dereham,             |  rca@ib.rl.ac.uk             |
|     Garvestone,          |                              |
|     Norfolk.             | Sept 1994 to July 1995:      |
|     NR9 4QT              |  rcaldrid@genvax.glam.ac.uk  |
|     England.             |                              |
+--------------------------+------------------------------+

Intro:
------
This document is intended for people with a good knowledge
of electronics and programming. It covers the basics of
getting TTL signals in and out of the IBM PC and compatibles
via the parallel port.

Don't let the disclaimer section put you off. I have to say it
to cover myself. Using the parallel port is a simple and fun way
of interfacing your PC to the outside world.

Please feel free to mail me with any problems or queries.
I will be glad to help.

---------------------------------------------------------------------

When building items to connect to the parallel port follow
these simple (and hopefully blindingly obvious) rules:
  o Only use TTL levels with the parallel port.
  o Always buffer signals.
  o If you plan to interface mains with the PC:
      - MAKE SURE YOU KNOW WHAT YOU'RE DOING
      - always use mains rated isolators
      - make sure mains cannot come in contact with the TTL
      - ensure that things are adequatly earthed

---------------------------------------------------------------------
Disclaimer:
-----------
THIS IS ONLY A ROUGH GUIDE FOR PEOPLE WHO ARE EXPERIENCED
IN PROGRAMMING AND ELECTRONICS. DUE TO THE WIDE RANGE OF
ITEMS THAT COULD BE CONNECTED TO THE PORT NO WARRANTY IS
OFFERED. RAFE ALDRIDGE IS NOT LIABLE UNDER ANY CIRCUMSTANCES
FOR DAMAGE OR PROBLEMS ARISING AS A RESULT OF APPLYING
ANY INFORMATION HERE.

---------------------------------------------------------------------
Programming:
------------
Hopefully if I explain this first the following will make more sense.

The following examples show how to input and output data to and from
the parallel port in Turbo Pascal 6+.

There are two ways of programming the parallel port.
  1. Via the BIOS
  2. Writing to the port directly.

1:
--
This is the method I use and seems to work okay.

{ get the status of the parallel port and return result in a byte }
function input_from_parallel_port : byte; assembler;
asm
  mov ah,2 { bios service }
  mov dx,0 { printer number; LPT1=0 LPT2=1 etc. }
  int 17h  { interrupt }
end;

{ send the byte b to the parallel port }
procedure output_to_parallel_port ( b : byte ); assembler;
asm
  mov ah,00  { bios service }
  mov al,b
  mov dx,0 { printer number; LPT1=0 LPT2=1 etc. }
  int 17h  { interrupt }
end;

{
2:
--
I personally have never done it this way. Don't even know if it will
work or not! The basic idea is to use the port array to send or
recieve a byte directly. I have used $387 as the address which is
LPT1 on my machine.

{ get the status of the parallel port and return result in a byte }
function input_from_parallel_port : byte;
begin
  input_from_parallel_port:=port [$387];
end;

{ send the byte b to the parallel port }
procedure output_to_parallel_port ( b : byte );
begin
  port [$387]:=b;
end;

{
Connector:
----------
The parallel port on the PC is accessed via a 25 way female
D type connector.

---------------------------------------------------------------------
Pins:
-----
There are 5 pins available for input and 8 for output.

 - input pins

| bit in AH | signal     | pin | state of bit when pin high
+-----------+------------+-----+-----------------------------------
|    7      | busy       |  11 | set to 1
|    6      | -ack       |  10 | set to 0
|    5      | paper out  |  12 | set to 1
|    4      | select     |  13 | set to 1
|    3      | -i/o error |  15 | set to 0
|    2      | unused     |  -  |
|    1      | unused     |  -  |
|    0      | timeout    |  -  |
+-----------+------------+-----+-----------------------------------

If things don't work as expected try tying pin 11 high (set printer
not busy). Some PCs don't like the printer being busy. Sometimes
this is made obvious by the timeout bit being set to 1 after a call
to output_to_parallel_port (1) above.

 - output pins

| bit in AH | signal | pin
+-----------+--------+-----
|    7      | D7     |  9
|    6      | D6     |  8
|    5      | D5     |  7
|    4      | D4     |  6
|    3      | D3     |  5
|    2      | D2     |  4
|    1      | D1     |  3
|    0      | D0     |  2
+-----------+--------+-----

- ground pins

Pins 18-25 are ground pins. Connect all of these to the 0volt
rail of the circuit under control.
