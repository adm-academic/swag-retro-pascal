PASCAL.FAQ             Frequently asked questions about Pascal

The aim of this document is to give answers to frequently asked
questions in the pascal echo. Thumb rules before asking for help are to
look in the manuals and in the online help first. Many problems can be
solved by just looking into either / both of them. Here are some
topics, that come very often in the Pascal Echo.

                                 Part I
       #1: Changing the case of strings
       #2: Compiler errors
       #3: Redirection of output

---------------------------------------------------------------------
                               #1 Strings

Q1: How do I access a single char in a string ?
Q2: How can I make a string all upper cases ?

A1: A string is an Array[0..255] of Char, where the 0th char is the
    length of the string. To access any character in the string, you can
    write

    MyChar := String[ I ];

A2: To map a single character to uppercase, you can use the UpCase()
    function of the run time library. To turn a whole string into upper
    cases, just use this function :

Function UpperCase( const S : String ) : String;
Var I : Integer;
Begin
  { first store the length in the result }
  UpperCase[ 0 ] := S[ 0 ]
  { now translate each char in S into a upper case char in UpperCase }
  For I := 1 to Length( S ) do
    UpperCase[ I ] := UpCase( S[ I ]);
End;

There is a assembler implementation in the manuals ( the linking
assembly language chaprt ), and there are many other optimized upper
case routines out there.

---------------------------------------------------------------------
                           #2 Compiler Errors

Q1: I get a "Code segment too large" error. How can I fix it ?
Q2: I get a "Data segment too large" error. How can I fix it ?

A1: This error means, that you have more than 64K code in one part
    of your program. To reduce the size of this code segment, you need
    to move parts of it into other units. This is possible to virtually
    unlimited units.

A2: This error means, that you have more than 64K data in your program.
    You need to put some data on the heap ( -> GetMem / FreeMem / New
    / Dispose ) or to reduce your global data and make it local data on
    the stack.

---------------------------------------------------------------------
                        #3 Redirection of output

Q1: How can I make the output of my program redirectable under DOS ?

A1: In general, the output of TP programs _is_ redirectable, except if
    you use the CRT unit. Then you need to either reassign output to
    '' or to declare a Text variable called for example ReOutput ( for
    Redirectable Output ), and write the output to it.

Example :

Uses CRT;

Begin
  WriteLn( 'This will always show up. Just a copyright.' );
  Assign( Output, '' );
  Rewrite( Output );
  WriteLn( 'This is redirectable.' );
  AssignCRT( Output );
  Rewrite( Output );
  WriteLn( 'And this will alyways show up again.' );
End.

There are some myths that setting DirectVideo to False would result in
redirectable output even when using CRT, or that TP _always_ writes
directly to the screen, and that TP output is _never_ redirectable. You
can ignore thos myths, TP writes to the screen using DOS, _except_ if
you use the unit CRT. Then TP writes directly to the screen. If you set
the variable DirectVideo to False, TP uses BIOS calls to write to the
screen.
