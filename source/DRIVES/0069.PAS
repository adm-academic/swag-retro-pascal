{
Here is my DRIVES routine again to return all valid drive letters on a
PC.  This is a fix from the last version which incorrectly addressed
the local variables and wound up hosing memory.  I also added some
extensive comments for readability.  Enjoy! }

{*****************************************************************************
 * Function ...... Drives
 * Purpose ....... To return a string containing the valid drives for the
 *                 current system.
 * Parameters .... None
 * Returns ....... A string of the valid drive letters.
 * Notes ......... Rather than changing to each drive to see if it exists, we
 *                 can instead call DOS Function 26h - Parse a file name.
 *                 If the file name is invalid (eg, F:), then DOS will say
 *                 so.  So, by testing each drive letter as a file name,
 *                 DOS will tell us which are good and which are bad!
 * Author ........ Martin Richardson
 * Date .......... August 6, 1993
 * Update ........ 02-01-94: Corrected problem where local VAR variables were
 *                           not being used, but a random memory location was
 *                           instead!
 *                         : Added comments for clarity.
 *****************************************************************************}
FUNCTION Drives: STRING; ASSEMBLER;
VAR
   DriveInfo:   ARRAY[1..2]  OF CHAR;
   Buffer:      ARRAY[1..40] OF CHAR;
   DriveString: ARRAY[1..25] OF CHAR;
ASM
     PUSH   SI                     { Save Important Registers }
     PUSH   DI
     PUSH   ES
     PUSH   DS

     MOV    SI, SS                 { The Stack Segment (SS) points to the }
     MOV    DS, SI                 { VAR's above.  Point DS to it... }
     PUSH   DS
     POP    ES                     { ...and ES as well. }

     LEA    SI, DriveInfo          { DS:SI - Where we test each drive letter }
     LEA    DI, Buffer             { ES:DI - FCB Buffer }
     LEA    BX, DriveString        { DS:BX - Our resultant string }

     MOV    BYTE PTR [SI], '@'     { The character before 'A' }
     XOR    CX, CX                 { Zero out CX }

@Scan:
     INC    BYTE PTR [SI]          { Next Drive Letter }
     MOV    BYTE PTR [SI+1], ':'
     MOV    AX, $2906              { DOS Function 29h - Parse Filename }
     INT    21h                    {   DS:SI - String to be parsed }
                                   {   ES:DI - FCB }
     LEA    SI, DriveInfo          { DS:SI }
     CMP    AL, $FF                { AL = FFh if function fails (invalid }
     JE     @NotValid              {     drive letter) }

     INC    CX                     { Add one more to our string length... }
     PUSH   CX                     { ...and save it. }
     MOV    CL, BYTE PTR DS:[SI]   { Grab the valid drive letter... }
     MOV    [BX], CL               { ...and stuff it into our result }
     INC    BX                     { Next position in result string }
     POP    CX                     { Get our length counter back }

@NotValid:
     CMP    BYTE PTR [SI], 'Z'     { Did we go through all letters? }
     JNE    @Scan                  { Nope, so next letter }

     LEA    SI, DriveString        { Store DriveString to #Result }
     LES    DI, @Result
     INC    DI
     REP    MOVSB

     XCHG   AX, DI                 { This is the only way to store the }
     MOV    DI, WORD PTR @Result   {   length that I can get to work. }
     SUB    AX, DI
     DEC    AX
     STOSB

     POP    DS                     { Restore Important Registers }
     POP    ES
     POP    DI
     POP    SI
END;

