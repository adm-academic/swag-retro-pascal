QNA-4/8/91
Turbo Pascal for Windows
1.0
Local Heap and Global Heap
TPW's New, GetMem, Dispose and Freemem all use Window's global heap.

[[[]]]

The Local Heap is very small, and not used by TPW, and is occasionally used
by Windows functions (like edit controls).

The Global Heap is generally very big, and is where your pascal program's
"heap" is stored.  The GetMem, FreeMem, New, and Dispose procedures all
operate on the Global Heap.

<<<>>>
QNA-4/8/91
Turbo Pascal for Windows
1.0
Exec from within a TPW program.
Use WinExec in the WinDOS to launch DOS and WinApp programs.

[[[]]]
Question:
   I want to be able to EXEC a DOS or Windows program in Windows. How do I
  do that?
Answer:
   Take a look at the WinExec procedure in your Windows Reference Guide.
  You can use Exec on both WinApps and DOSApps.


<<<>>>
QNA-4/8/91
Turbo Pascal for Windows
1.0
TPW New and GetMem procedures
New, GetMem, HeapBlock, HeapLimit in TPW

[[[]]]
The way memory allocation works for new and getmem is as follows:

There are two system variables:  HeapBlock and HeapLimit.

When memory is allocated for a size less than HeapBlock (Default is 1k)
then the memory will be suballocated in a block of size HeapBlock
(default is 8k).
Allocation of blocks larger than HeapLimit will have there own block.  All
allocations will be in global memory.

You will not be able to change the way this works.


<<<>>>
QNA-4/8/91
Turbo Pascal Windows
1.0
WinCrt and Windows 3.0
WinCrt cannot be used with OWL.

[[[]]]

 WinCrt is an emulation of the Dos and Crt units.  Basically, it provides a
quick and dirty means of output to a Windows window.  It's not intended
to be a Dos to Windows porting service - WinCrt apps are not full Windows
apps - just a Windows window with some text, key scanning loops, and
scrollbars.

  Note that writelns to the 'screen' will cause a runtime error in TPW
unless the WinCrt unit is used. (WinCrt opens the standard Input and
Output files, which are closed by default in TPW).  The Readln, Keypressed,
procedures, etc., are also only valid under the WinCrt umbrella. The text
colors and text inverse are not supported.  And since WinCrt takes control of
the message loop and dispatch services of your windows app, WinCrt cannot be
used in conjunction with OWL. You can call Windows API functions directly,
however.


<<<>>>
QNA-4/8/91
Turbo Pascal Windows
1.0
PChars in TPW.
What is a PChar type?

[[[]]]

  PChar is a special pointer type that has been added to the Pascal
Windows language definition.  A PChar is a pointer to an array of
characters with a maximum size of 64K and terminated by a null character
(#0).  This is a C string, and comes with all the memory management hassles
and pointer arithmetic advantages of C. The PChars and arrays of char are
type compatible, and a Strings unit is devoted to C-string manipulation
functions (all start with "STR").  When passing a string literal to a
procedure, the compiler will figure out whether the string literal
should be stored in c-string format or in pascal string format, or both.


<<<>>>
QNA-4/8/91
Turbo Pascal for Windows
1.0
TDW popping in dual mode in TPW.
How to make TDW come up in dual mode from within TPW.

[[[]]]
Question:
 I want to make TDW come up in dual mode from within the TPW.
Answer:
  Add the following lines to the tpw.ini file:

  [Debugger]
  Exepath=<pathname>
  Switches=<command-line options>

  where <pathname> is the path to the TDW.EXE and <command-line options>
  are the options you normally want to use with TDW, this will do it.  The
  command-line option for the dual display is -do.


<<<>>>
QNA-4/8/91
Turbo Pascal for Windows
1.0
Changing Button Text
Use SetCaption method in OWL or SendMessage API to change button text.

[[[]]]
Question:
How do you change the text on a button?

Answer:
To change the text on a button, send a WM_SETTEXT message with the string for
the lParam.  For example:

  SendMessage(btnWindow, WM_SETTEXT, 0, 'New Button Title');

Or if you are using OWL, call the SetCaption method of TButton.


<<<>>>
QNA-4/8/91
Turbo Pascal for Windows
1.0
Status line in a MDI Application.
How can I have a status line in an MDI Application?

[[[]]]

To have a status line in an MDI application, override the windows MDI
WMSize method like this:

  TGDIDemoWindow.WMSize(var Message: TMessage);
  begin
    TMDIWindow.WMSize(Message);
    {Calculate the new size of the client area}
    MoveWindow(ClientWnd^.HWindow, size of the new client area)
  end;

This will keep the client window from obscuring your status line or other
controls you might like to have in your window.


<<<>>>
QNA-4/8/91
Turbo Pascal for Windows
1.0
TPW  1.0 Hot Sheet.
Feature set of TPW 1.0.

[[[]]]
Turbo Pascal for Windows 1.0 Hot Sheet.

Feature Highlights
----------------------
NEW! state-of-the-art Windows integrated development environment
(IDE).

        Runs under Windows
        Multiple editor windows
        Full Mouse Support
        Supports TP6 type hot keys
        Multi-file editor that can edit files up to 1MB
        complete save and restore of desktop

NEW! ObjectWindow library - Built in support for Windows, Menus,
Dialogs, Buttons, List boxes, Edit fields, Icons and more.  All
for use in your applications.

NEW! Full access to all Windows API functions and messages.

NEW! Fully Supports creation of DLLs.

NEW! Turbo Debugger for Windows

        Supports Windows messages
        Advanced breakpoints
        Reverse execution
        Automatic DLL debugging
        Object browser and inspectors
        Single and dual monitor support

INCLUDED! Whitewater Resource Toolkit - Visually create Dialogs,
Menus, Icons, Bitmaps and String resources.

INCLUDED! Resource Compiler

INCLUDED! Windows Help Compiler

Full featured inline assembler (BASM)

Private fields and methods in object declarations

Extended syntax directive ($X) that lets you treat functions like
procedures (and ignore function results)

286 code generation

Address references in typed constants

Far and near procedures directives ($F)

Link in initialized data ($L) from object (OBJ) files

Smart linker removes unused objects and code

complete math coprocessor emulation and support -
8087/80287/80387

NEW! Turbo Help hypertext on-line help facilities, including
references to all Windows API finctions and messages.

Turbo Pascal for Windows includes everything you need to create
Windows applications.  It does not require the Microsoft Windows
SDK.

System Requirements
---------------------
IBM PC or PS/2 and all 100% compatibles
Microsoft Windows 3.0 or later
2Mb of memory
EGA, Hercules or VGA graphics
Mouse or other pointing device
Hard Disk (Requires 6.5 Meg for full product)

Benchmarks
-----------
Machine                                Lines/Min
Compaq DeskPro 386/33        84,000

Documentation
----------------
1. User's Guide
2. Programmer's Guide
3. Windows Reference Guide
4. Windows Programming Guide
5. Whitwater Resource Toolkit Users Guide
6. Turbo Debugger for Windows Users Guide
7. Help Compiler Reference Guide

Pricing Information
-------------------------
Turbo Pascal for Windows   $249.95


Special Offer Information
---------------------------
Registered user of ANY BORLAND LANGUAGE PRODUCT $99.95 ***


***Turbo Pascal for Windows is exclusively for Windows
Development and does not replace Turbo Pascal version 6.0.  TP6
is the current product for standard DOS development.  The offer
is not an upgrade it is a limited special offer to our current
Turbo Pascal Customers.

<<<>>>
QNA-4/8/91
Turbo Pascal for Windows
1.0
The $G+ directive, 286 code generation, and Real Mode.
How can I detect if Windows is in Real mode?

[[[]]]
Question:

If I use the $G+ 286 code generation directive, how can I be sure that
Windows is running in Real mode?

Answer:
  The 286 code generation option allows the compiler to substitute more
efficient 286 instructions in place of normal 8088 instructions for things
like loops, jumps and memory operations.  If you compile your program with
$G+, then you should call GetWinFlags early in the startup of your
application - such as in your Application.Init.  Check for the wf_PtMode
flag set.  If it's not set, then you're not running in protected mode, and
you should display a message box and exit your program.  Setting the
Application's status variable to a non-zero value should also work, although
that would cause more code to be executed, implying greater risk of hitting a
286 instruction.

  All the precompiled units in TPW will run in real mode and are not
affected by the $G+ directive.  The $G+ directive only affects code that you
compile yourself.

<<<>>>
QNA-4/8/91
Turbo Pascal for Windows
1.0
Using the 80X87 emulator in TPW.
Do I need a coprocessor to run TPW?

[[[]]]
Question:
 Must TPW a the math coprocessor?

Answer:
  Windows implements its own 80x87 instruction emulator as a DLL that is
loaded when an 80x87 instruction is detected.  The reason that the '87 code
generation is an option is speed:  emulators are always slower than the
real hardware, and slower than using the 6 byte reals.  If you need double,
or  extended reals, or Comp integers, then you must turn on '87
code generation, and Windows will adjust itself to compensate if there
is no '87 hardware when the program is running.  You do not need a
coprocessor to compile or run the program.

<<<>>>

TN-4/8/91
Turbo Pascal for Windows
1.0
TPW "Can't find Debugger" error message
"Can't find Debugger" error message can be caused by not enough memory
available.
[[[]]]
With Turbo Pascal for Windows you can get the Can't Find Debugger error
message when there is not enough memory to load the debugger.  There
must be at lease 250K free in order to load the debugger.

If you have checked that TDW is in the path etc., and this error is still
displayed,  check the memory free...


<<<>>>
TN-4/8/91
Turbo Pascal for Windows
1.0
TPW Strings literals in the Data Segment
TPW String literals are stored in the Data Segment.

[[[]]]
Unlike the DOS version of Pascal, String Literals are stored in the data
segment along with all global variables etc.  If customer is running out
of data segment space, suggest using pointers to strings instead of
string literals.


<<<>>>
