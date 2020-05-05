SECTION 7 - DOS Programming
                           
This document contains information that is most often provided
to users of this section.  There is a listing of common
Technical Information Documents that can be downloaded from the
libraries, and a listing of the five most frequently asked
questions and their answers.
         
TI1184   Overview of Borland Pascal 7.0 and Turbo Pascal 7.0
TI1722   Declaring an array on the heap
TI1760   Creating a temporary stack in real or protected mode
TI1171   Problem Report Form
TI1719   Booting Clean

LC2P01.FAQ   Linking C to Pascal  Frequently Asked Questions
EZDPMI.ZIP   Unit encapsulating common DPMI requests for
             protected mode programming 
BIGSTU.PAS   How to cope with memory allocations > 64K 
PASALL.ZIP   Collection of Technical Information Sheets from 
             1986 on
NEWRTM.ZIP   Latest RMT.EXE and DPMI16BI.OVL
MOUSE.ZIP    General purpose mouse unit for text/graphic modes

Q.   "How do I link an object file that is a library of
     functions created in C?"

A.   Download the file "LC2P01.FAQ.  The C run-time library is
     needed by the object file.  Since Pascal can't link the C
     RTL as is, you will need the RTL source and will need to
     modify it so that it can be linked by TP.

Q.   "How do I get the ASCII key numbers for the Arrow keys?"

A.   Below is a short program that reveals this information.

     program DisplayAscii;
     uses Crt;
     var
       ch:char;
     begin
       repeat               { repeat until Ctrl-C }
            ch := Readkey;
            Write(Ord(CH):4);
       until ch = ^C;          
     end.

     The program can be terminated by pressing Ctrl-C.  You'll
     see that keypresses such as UpArrow actually generated two
     bytes:  a zero followed by the extended key code. 

Q.   "Why do I get runtime error 4 while using the following
     line:  reset(InFile)?"

A.   The error message means that you have run out of file
     handles.  The FILES= statement in your CONFIG.SYS doesn't
     change the fact that a process can, by default, open a
     maximum of 20 files (and DOS grabs 5 of those).  The
     SetHandleCount() API function can be used to increase the
     number of handles useable by your application.

Q.   "I am using overlays with BP7 with Objects.  If Overlay A
     calls a procedure or function in Overlay B, does Overlay A
     stay in memory while Overlay B runs?  Or does Overlay B
     wipe out Overlay A, and when Overlay B finishes, it reloads
     Overlay A?"

A.   It depends on the size of the overlays and the size of the
     overlay buffer you set up.  In general you can think of the
     overlay buffer as a pool of memory where overlaid units can
     be stored.  Every time you call a routine in an overlaid
     unit, that overlay is loaded into the buffer.  If the
     buffer is already full, then the oldest unit in the buffer
     is discarded to make room for the new one.  If you've got a
     small overlay buffer and large overlaid units, they may
     well kick each other out as they load.  If you've got a
     large overlay buffer the program may well keep everything
     in memory the entire time.
 
Q.   "I am getting DosError = 8 when using EXEC() to execute a 
     program from within my program.  How do I correct this?"

A.   DosError = 8 means that there is not enough memory 
     available to run the program being EXEC'ed.  Normally your
     program grabs all available memory and doesn't leave any 
     for the program being EXEC'ed.  Be sure to use the $M 
     directive which minimizes the memory required by your
     program.  

Q.   "I am getting DosError = 2 when using EXEC() to copy a 
     file from one directory to another.  The file does exist
     and the command line is correct.  What is the problem?"
A.   You might have assumed that because COMMAND.COM is on your
     path, EXEC will find it.  Nope.  EXEC needs the full path
     name.  You can use GetEnv('COMSPEC') to get the value of
     the environment variable COMSPEC which should be the full
     path.  
     


