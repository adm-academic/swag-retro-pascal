
TP 5.0 5.5 - LINKER ELIMINATES UNUSED DATA
Q. Does the built-in linker eliminate unused data?
A. Yes. Unused code AND data are stripped when you compile to
   disk.  However, if more than one variable is defined in the
   same VAR block and any one is used, the others will not be
   stripped from the .EXE.  For example:

     var  A, B: integer;
     var  C: integer;
     begin
       A:= 0;
     end.

  In this example, although variable B is never used, it was
  defined in the same block as a variable A. Therefore, B will
  not be linked out.  Variable C will be removed from the .EXE as
  it is not used and is not in the same VAR block.

