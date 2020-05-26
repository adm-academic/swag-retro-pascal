SECTION 4 - Vintage Pascal

This document contains information that is most often provided
to users of this section.  There is a listing of common
Technical Information Documents that can be downloaded from the
libraries, and a listing of the five most frequently asked
questions and their answers.
  
TI407   Using the serial port in a Pascal application
TI152   Interupt handler for 3.X and lower
TI226   Async routines for versions 3.X and lower
TI232   Absolute disk read for version 3.x and lower

Q.   "Are any of the ToolBox programs that shipped with versions
     3.0 and 4.0 still available.  For instance, can I get an
     upgraded copy of the Database ToolBox or the Editor
     ToolBox."

A.   No. These programs are no longer in any form from any
     company. If you want to get a copy of them, you would need
     to purchase them from a current owner.

Q.   "Can the ToolBox programs be used from version 7.0?"

A.   It depends. As a rule, the answer is yes, all you need to do
     is recompile and they will run fine. This is totally
     fortuitous, however, and Borland has, and will, do nothing
     to update these programs. See TI1728 for help upgrading the
     Editor ToolBox.

Q.   "How can I convert my Turbo Pascal 3.0 program to version
     7?"

A.   There is a file called up UPGRADE.ZIP which is available on
     the forums. This can help in the process of upgrading the
     files. Most of the code from version 3.0 will run fine under
     7.0, but not all of it.

Q.   "When I use the Turbo Vision editors unit from Version 6.0 I
     never see the numbers 3, 4, 6 and 7 when I try to type them
     in."  

A.   This was a bug in the first version of TP6.0. The fix is
     available in EDITOR.PAT, found in LIB1.

Q.   "What ever happened to FreeMem and FreePtr?"

A.   These Turbo Pascal 5.x identifiers are no longer used by the
     heap manager.  Simply delete references to FreeMin from your
     code. If you're using routines that use FreePtr to compress
     the heap or perform other implementation-dependent
     operations on the heap, you'll need to update these
     routines. (If you just need to lower the top of memory in
     order to do an Exec, you can call the SetMemTop procedure
     from the Turbo Vision Memory unit.) See the Programmer's
     Guide for more information about how the heap manager
     works.
    
