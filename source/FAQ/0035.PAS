{

Two ways to create dial tones: digital sample for each tone, or generate tone
with a digital to analog convertor. The MCI mmSystem uses MS Windows 3.1 high
resolution timer. The following demonstrate other ways to generate tones: }

program PlayTone;
{ Author: John Howard }
uses WinProcs;
(* Comments from Don Phillip Gibson, CompuServe [75725,1752] are enclosed in
   star brackets *)
const Magic : integer=376;
      Tempo : integer = 120;
      NoteType : integer = 4;
(*
        Magic is used as a multiplier to determine the duration of a
        note.  The Windows API documentation for setVoiceSound
        indicates that duration should be a straight forward
        calculation of yea-so-many clock ticks.  It just isn't so.
        Brute force experimentation found 376.  It seems to work fine
        regardless of processor speed or whatever.  I've tested on
        386/33, 386/16, and 8088/4.7 machines -- they all work.  Let
        me tell you, it was sure fun setting up and running Windows on
        that 8088/4.7 CGA equipment.

    The actual tone production routines follow.  If you've explored
    the API music functions at all, you may wonder why I'm using
    setVoiceSound instead of setVoiceNote.  setVoiceNote seems, on the
    surface, to be the automatic way to write these sorts of things,
    but it just doesn't work very well.  Whole notes and half notes
    are incorrectly produced, dots are impossible, and the nicety of
    having legato is gone.  setVoiceSound works much better, though it
    does require that you calculate a duration rather than just
    specifying tempo and length.

Windows wants the fractional and integer portions of the frequency
stuffed respectively into the low and high words of a long integer.

setVoiceSound doesn't provide for a rest.  Instead, I've plugged an
impossibly high pitch into the [0] slot of that array.  It's
presumably playing, but you shouldn't hear it.
*)
var   Pitch : array[0..84] of LongInt;
      Herz  : array[0..11] of Real;
      Tone  : integer;              { index }

 function Duration(Tempo, NoteType : integer) : integer;
 var Temp : real;
 begin
   Temp := 60 / Tempo * Magic * 4 / NoteType;
   Duration := trunc(Temp);
 end;

BEGIN  {main}
Pitch[0] := MakeLong(0,20000);
Tone := 0;                          { example tone index }
Herz[Tone] := 523.25;               { note 'C' white frequency }
Pitch[Tone+1] := MakeLong(trunc(frac(Herz[Tone])),trunc(int(Herz[Tone])));
setVoiceSound(1,Pitch[Tone+1],Duration(Tempo,NoteType) * 7 div 8 );
                                    {1. Accept note number}
setVoiceSound(1,Pitch[0],Duration(Tempo,NoteType) * 1 div 8 );
                                    {2. Sound off, zero means silence}
                                    {3. Translate note into 'frequency'}
                                    {4. Setup timer chip}
                                    {5. Setup frequency}
                                    {6. Sound on}
                                    {7. Setup note length delays}
(*
I don't know why I've got to send one last 'empty' note to the
voice queue, but without it, the last real note doesn't get played.
That's the purpose of the next statement.
*)
setVoiceSound(1,0,1);
setVoiceThreshold(1,0);
StartSound;
repeat until GetThresholdStatus = 1;
CloseSound;
END. {main}

            1-800-451-6644 Philips/Signetics BBS Filename: DTMF.ZIP
{ snippet follows }
; The following code uses both timers in an 80c31 to generate
; DTMF tones, and signalling tones such as BUSY, RING-BACK, etc.
; This file also contains the connections for a very crude 2 bit
; per tone A\D converter wich uses 4 bits of P1 and a low pass filter.
; Compensation for twist isn't included but could be handled by
; playing with the hi and low tone dac values and the summing amp
; input resistors.
;
; If this code is used in any application I only request that
; credit be given to me: 
;        Bert Rinne
;        Advanced Logic Systems Inc.
;        13 Twin Meadows Dr.
;        Hudson N.H. 03051
;        (C) 1993
;   *** Another method of tone generation is documented in the
;        'YUCK' Zilog Z8 microcontrollers book circa 1991 using the
;        Super8. It is a waveform synthesis model using a 8Khz sampled
;        data system with 1 timer and an 8 bit dac. If anyone should
;        adapt the technique to the '51/'31 family please post the
;        code on this BBS in return for the info.
;                
;                                        Bert Rinne 12/93
SIGNAL_LOW      equ     021h    ;2 bytes for signal fLOW timer
SIGNAL_HIGH     equ     023h    ;2 bytes for signal fHIGH timer
fHIGH           equ     025h    ; frequency high
fLOW            equ     026h    ; frequency low
CNT_10mS        equ     027h    ; decrement 10 millisecond used as a timer
;   HARDWARE CONFIGURATION                     ____/\/\/\___
;--------,                                     |           |
; 8031   |      47k                            +-----][----|
;   P1.0 |-----/\/\/\------,                   |           |
;        |      12k        +--/\/\/\--,        |    \      |
;   P1.1 |-----/\/\/\------'          |        |   |   \   |
;        |                            +---][---+---|-    \_|____||___ 
;        |      47k                   |            |     /      ||
;   P1.2 |-----/\/\/\------,          |         ,--|+  /
;        |      12k        |--/\/\/\--'         |  |/
;   P1.3 |-----/\/\/\------'                    |
;--------'                                      +2.5V
; 
; the dac uses 3 bits per channel internal to the mpu and
; counts as follows 000 001 010 011 100 101 110 111
; using bit 2 as the sign and complementing bits 0 & 1 we
; get 000 001 010 011 111 110 101 100 and
; output 00 01 10 11 11 10 01 00
; The above was coupled to a 100mw amp and used to dial the phone
; via acoustical coupling (held phone near speaker) with no errors.
;
; Funky DAC courtesy of Don Lancaster's wonderful book - 
; The CMOS Cookbook, Howard Sams Inc.
;
;       DIALING TONES (dtmf)
;
;                       1209    1336    1477    1633
;
;               697       1       2       3       A
;
;               770       4       5       6       B
;
;               852       7       8       9       C
;
;               941       *       0       #       D 
;
;   Using the formula  f = -(((osc/12)/bits-per-cycle)/desired-freq.)
;
;   thus at 11.059 MHz clock and 8 bits per cycle:
;
;     desired        timer value     actual freq
;       697     =       -165            698.2
;       770     =       -150            768
;       852     =       -135            853.3
;       941     =       -122            944
;
;       1209    =       -95             1212.6
;       1336    =       -86             1339.5
;       1477    =       -78             1476.9
;       1633    =       -71             1622.5
; Low frequency  low byte
F697    equ     LOW(-165)
F770    equ     LOW(-150)
F852    equ     LOW(-135)
F941    equ     LOW(-122)
; High frequency  low byte
F1209   equ     LOW(-95)
F1336   equ     LOW(-86)
F1477   equ     LOW(-78)
F1633   equ     LOW(-71)
;       Tone time on    >40 mS          Bell spec minimum so we
;       Tone time off   >40 mS          will use 100mS on/70 mS off
;
;       SIGNAL TONES
; NOTE *** the signal tone values are adjusted by LOAD_DTMF:
; to compensate for latency time while re-loading the timers.
; The latency time is 2 us. and is critical for 
; valid signal tone frequencies.
;
;                       Low  High (Hz)
;       Dial tone       350  440         steady tone            -13dBm
;       ring-back       440  480         2 sec on/ 4 sec off    -19dBm
;       busy            480  620        .5 sec on/.5 sec off    -24dBm
; NOTE: *******
;        Although the following are not implemented, they are valid
;        signal tones:
;
;        Reorder:        480  620        .25 sec on/.25 sec off        -24dBm
;
;        Partial dial tone
;                        480                steady tone                -17dBm
;
;        Auto credit call prompting:
;                        941  1477        940 mSEC                -10dBm/freq.
;        followed by        440  350        exponentially decaying from -10dBm
;                                        @ a time constant of 200mSec.
;
;        Reference:        Mitel Semiconductor Data book circa '86-'87.
;                        "Credit must be given where due."
;
;        Pulse dialing can be accomplished very easily using the timers
;        and if you're reading this you can figure it out.
;
;     desired        timer value     actual freq
;       350             -329            350
;       440             -262            439.7
;       480             -240            480
;       620             -186            619
F350    equ     -329
F440    equ     -262
F480    equ     -240
F620    equ     -186
TONE_TBL:
; 0
        db      F941                    ;fLOW  = 941
        db      F1336                   ;fHIGH = 1336
        db      76                      ;76 * fLOW intrs = 10mS
        db      0
; 1
        db      F697                    ;fLOW  = 697  
        db      F1209                   ;fHIGH = 1209
        db      56                      ;56 * fLOW intrs = 10 mS
        db      0
; 2
        db      F697                    ;fLOW  = 697  
        db      F1336                   ;fHIGH = 1336 
        db      56
        db      0
; 3
        db      F697                    ;fLOW  = 697  
        db      F1477                   ;fHIGH = 1477 
        db      56
        db      0
; 4
        db      F770                    ;fLOW  = 770  
        db      F1209                   ;fHIGH = 1209
        db      62
        db      0
; 5
        db      F770                    ;fLOW  = 770  
        db      F1336                   ;fHIGH = 1336
        db      62
        db      0
; 6
        db      F770                    ;fLOW  = 770  
        db      F1477                   ;fHIGH = 1477 
        db      62
        db      0
; 7
        db      F852                    ;fLOW  = 852  
        db      F1209                   ;fHIGH = 1209
        db      68
        db      0
; 8
        db      F852                    ;fLOW  = 852    (853)
        db      F1336                   ;fHIGH = 1336   (1340)
        db      68
        db      0
; 9
        db      F852                    ;fLOW  = 852    (853)
        db      F1477                   ;fHIGH = 1477   (1477)
        db      68
        db      0
; A
        db      F697                    ;fLOW  = 697    (698)
        db      F1633                   ;fHIGH = 1633   (1622)
        db      56
        db      0

; B
        db      F770                    ;fLOW  = 770    (768)
        db      F1633                   ;fHIGH = 1633   (1622)
        db      62
        db      0
; C
        db      F852                    ;fLOW  = 852    (853)
        db      F1633                   ;fHIGH = 1633   (1622)
        db      68
        db      0
; D
        db      F941                    ;fLOW  = 941    (944)
        db      F1633                   ;fHIGH = 1633   (1622)
        db      76
        db      0
; *
        db      F941                    ;fLOW  = 941    (944)
        db      F1209                   ;fHIGH = 1209   (1213)
        db      76
        db      0
; #
        db      F941                    ;fLOW  = 941    (944)
        db      F1477                   ;fHIGH = 1477   (1477)
        db      76
        db      0

