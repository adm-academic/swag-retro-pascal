SECTION 19 - Protected Mode Programming
                                    
This document contains information that is most often provided
to users of this section.  There is a listing of common
Technical Information Documents that can be downloaded from the
libraries, and a listing of the five most frequently asked
questions and their answers.

TI1184   Overview of Borland Pascal 7.0 and Turbo Pascal 7.0
TI1722   Declaring an array on the heap 
TI1760   Creating a  temporary stack in real or protected mode 
TI1188   Creating protected mode apps with Borland Pascal 
TI1171   Problem Report Form 
TI1719   Booting Clean

NEWRTM.ZIP   Latest RTM.EXE and DPMI16BI.OVL 
PASALL.ZIP   Collection of Technical Information sheets from 
             1986 on 
EZDPMI.ZIP   Unit encapsulating all common DPMI requirements for 
             protected mode programming
BIGSTU.PAS   How to cope with memory allocations > 64K
MOUSE.ZIP    General Purpose mouse unit for text/graphics mode

Q.   "When using the BP7 IDE to compile a protected mode
     application, how do I step through the code like I do with
     real mode applications?"

A.   To debug protected mode programs, you must use the external
     debugger (TDX).  You can put it on the TOOLS menu to make
     it just a keystroke away.

Q.   "When I convert a program from Real Mode to Protected Mode,
     do I have to change the GetMem calls to GlobalAlloc and
     GlobalDiscard?" 

A.   No, you don't have to change the GetMem calls.  GetMem is a
     better allocation method.  Getmem will do a better job of
     allocating memory. It allocates the memory in 8K chunks,
     then suballocates from that. The reason for this is that
     there are a maximum of 2000 selectors availble in BP7, so
     you don't want to waste them. GlobalAlloc calls the DPMI
     directly to allocate the memory, bypassing the heap manager.
     GlobalAlloc is there for when you need to bypass the heap
     manager for some reason, but you normally don't want to do
     that.

Q.   "How do I profile a protected mode application using BP7?"

A.   You can only profile real mode applications, Borland does
     not supply a protected mode profiler.  

Q.   "I have ported a large program to protected mode and am
     getting a General Protection Fault on calls to GetMem.  What
     could be causing this?"

A.   In DPMI, a Local Descriptor Table (LDT) can contain 8192
     selectors.  The Run Time Manager (RTM) maintains an
     internal table to track allocated selectors.  The RTM table
     has a capacity of approximately 2K selectors.  GlobalAlloc
     and GetMem calls that need to allocate a new block will fail
     when that 2K table is full.

Q.   "I have a protected mode application that was created with
     BP7. When running the program in a DOS box under Windows,
     the computer locks up.  What could be causing this?"

A.   Check the "XMS KB Required" and "XMS KB Limit" settings in
     the .PIF file used for the DOS box.  The "Required" setting
     should be 0 and the "Limit" should be at least 2048K.
