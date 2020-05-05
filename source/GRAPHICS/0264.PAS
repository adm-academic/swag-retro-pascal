{  Hi

Many of fast ellipse drawing routines uses two loops
to draw a part of an ellipse curve, first from 0 to 45
degrees and second from 45 to 90 degrees. But there is
an algorithm that uses only one loop. I think, that's
the shortest and fastest way to draw ellipses on raster
screens.

If you know about a better ellipse drawing algorithm
send me your hints !
                    ;-) Gerd

Email: gerd.platl@siemens.at
--------------------------------------------------------
{$A+,B+,G-,I-,O-,V-,D-,L-,Q-,R-,S-,E-,N-  TP 7.0 Opt.}

program FastEllipseDrawingDemo;    {02-04-96,04-08-97}

uses  Crt, Dos;

const maxX = 319;
      maxY = 199;           {video mode 19: 320x200/256}
var   v:array[0..maxY,0..maxX] of byte absolute $A000:0;
{
procedure PutPixel (x,y: integer; color: byte);
begin  v[y,x] := color; end;
}
procedure PutPixel (x,y: integer; color: byte); assembler;
asm
  mov ax,0A000h
  mov es,ax        {es = $A000}
  mov ax,y
  shl ax,6
  mov bx,ax        {bx = y * 64}
  shl ax,1
  shl ax,1         {ax = y * 256}
  add bx,ax        {bx = y * 320}
  add bx,x         {bx = y * 320 + x}
  mov al,color     {load color}
  mov es:[bx],al   {set point}
end;

procedure DrawEllipse (mx,my, a,b, color: integer);

var   x,  mx1,mx2,  my1,my2: integer;
      aq,bq, dx,dy, r,rx,ry: longint;

begin
  PutPixel (mx + a, my, color);
  PutPixel (mx - a, my, color);

  mx1 := mx - a;   my1 := my;
  mx2 := mx + a;   my2 := my;

  aq := longint (a) * a;        {calc sqr}
  bq := longint (b) * b;
  dx := aq shl 1;               {dx := 2 * a * a}
  dy := bq shl 1;               {dy := 2 * b * b}
  r  := a * bq;                 {r  := a * b * b}
  rx := r shl 1;                {rx := 2 * a * b * b}
  ry := 0;                      {because y = 0}
  x := a;

  while x > 0
  do begin
    if r > 0
    then begin                  { y + 1 }
      inc (my1);   dec (my2);
      inc (ry, dx);             {ry = dx * y}
      dec (r, ry);              {r = r - dx + y}
    end;
    if r <= 0
    then begin                  { x - 1 }
      dec (x);
      inc (mx1);   dec (mx2);
      dec (rx, dy);             {rx = dy * x}
      inc (r, rx);              {r = r + dy * x}
    end;
    PutPixel (mx1, my1, color);
    PutPixel (mx1, my2, color);
    PutPixel (mx2, my1, color);
    PutPixel (mx2, my2, color);
  end;
end;

var    a,b: integer;   r: registers;

begin
  r.ax:=$13;   Intr($10,r);
  repeat
    a := 1+Random (100);
    b := 1+Random (99);
    DrawEllipse (a + Random (maxX - 2 * a),
                 b + Random (maxY - 2 * b), a,b,
                 1 + Random (255));
  until keypressed;
  TextMode(3);
end.
