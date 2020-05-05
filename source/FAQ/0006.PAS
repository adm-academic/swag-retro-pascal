

TITLE: TURBO PASCAL MEMORY ISSUES
===========================================================

TP 4.0 5.0 5.5 EXEC - SETTING HEAP MEMORY
Q. How do I set the heap memory when executing a child process?
A. Probably the best way to do this is through trial and error. 
   Set the heap maximum to some large value, and run the program.
   If it runs out of memory, then divide the maximum by 2, and so
   on, until the parent and child programs have enough memory. 
   The same can be done with the heap minimum.  Also, if you have
   access to CompuServe, you can download a routine that swaps
   the parent program between memory and disk.

TP 4.0 5.0 5.5 - ALLOCATING AND RECLAIMING MEMORY USING DOS 
Q. What Dos functions can I use to reclaim memory to Dos? 
A. You essentially must write your own GetMem and FreeMem
   routines.  GetMem would make a call to Dos function $48 and
   FreeMem would make a call to Dos function $49.  For more
   details on these functions please consult an IBM PC
   programmer's guide.

TP 4.0 5.0 5.5 - MEMORY CONTROL BLOCKS
Q. How many memory control blocks does a Turbo Pascal program
   use?
A. Just one.


TP 5.0 5.5 - EMS SUPPORT
Q. Does Turbo Pascal 5.0+ support EMS?
A. Yes. Turbo Pascal 5.0+ will use up to 64K (if selected in
   TINST) of EMS for storing the edit buffer. In addition, you
   can instruct the Overlay unit to place your overlaid units on
   EMS. Finally, EMS.PAS on the distribution disk shows you how
   to access EMS memory.


TP 5.5 - HEAP SPACE STILL CREATED WITH HEAP MAX 0
Q. Compiling to disk with my heap maximum set to 0 still creates
   heap space when running .EXE file.  Why?
A. This has to do with the way DOS allocates memory for .EXE
   files in chunks of 512 bytes, rather than in chunks of 16
   bytes. As a result of DOS's allocation, you always get 0-496
   bytes more than you request.

