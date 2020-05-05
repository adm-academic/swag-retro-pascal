TOPIC    :  Cool stuff Borland left out of their TP manuals. ;-)
FOR      :  TP 4.0+
-----------------------------------------------------------------
This  post  is  about  cool  programming  concepts  that  will be
referred  to either  directly or  indirectly in  my ON PASCAL ...
tutorial series of messages.

The underlying  programming style that will  be implemented in my
posts  is  called  OBP,  Object  Based  Programming,  or  Modular
Programming. This programming style provides many of the benefits
of Object  Oriented Programming (OOP) without  actually having to
use OOP code in your programs.

These benefits are namely: 1)the  ability to manage complexity in
your programs, 2)easy to use reusable  object code in the form of
TPUs, and  3)fewer program bugs.  Further, you are  able to stick
with traditional programming methods with OBP.

The following  are definitions of cool  programming concepts. You
are  going to  have to  accept on  faith that  these are NOT just
boring definitions!!!  Every time you write  a program you should
be thinking about and using this  cool stuff. As Borland does not
talk about them in the context of OBP, I will. ;-)

So, ... It is time to rattle your brains a little.

-----------------------------------------------------------------
ABSTRACTION
-----------
It  is the  process by  which programmers  distill the  essential
characteristics of some conception that distinguishes it from all
others. Abstraction is why High Level Programming Languages (HLL)
were invented!  HLLs achieve abstraction  by allowing programmers
to write programs without having to bit-twiddle. Bit-twiddling is
for Assembly  Programming. Every HLL implements  abstraction to a
certain degree.  Hence, bit-twiddlers should  stay with ASM,  and
everybody  else should  start  thinking  in terms  of abstraction
rather than bit-twiddling in their programs!!! ;-)


ABSTRACT DATA TYPE (ADT)
------------------------
A data type that  is defined in terms of  the operations that can
be  performed  on  objects  of  that  type  rather  than  by  the
properties   of  the   objects  themselves.   ADTs  represent  an
intermediate    step   between    traditional   programming   and
object-oriented programming.  Among the many  cool uses of  ADTs,
they can make  your code portable. Think of  ADTs as the ultimate
level of abstraction in high level programming.


BINDING TIME
------------
The point in a program at which reference to a program's elements
or  abstractions   are  bound  to   specific  computer's  storage
locations and values.


BLOCK
-----
A block  is a  segment of  source code  that can  be selected and
acted upon as a whole. Think  of blocks as being a relative level
of abstraction.


CAST
COERCION
--------
A data  conversion from  one type  to another.  They are  used to
selectively turn off type checking in TP.


DATA TYPE
---------
A definition of a  set of data that specifies  the possible range
of values of the set, the operations that can be performed on the
values, and the way in which the values are stored in memory. The
concept of a data type  makes data manipulation more abstract and
hides the  underlying binary representation of  the data. We will
be using  Modules to implement  Data Types in  TP. Think of  data
types instead of just types as they are the total package!!!


DYNAMIC BINDING
LATE BINDING
---------------
Binding that occurs during program  execution. We will achieve to
a degree  this  type  of  binding  with  traditional  programming
methods using procedural types and pointers.


GLOBAL VARIABLE
---------------
A variable  whose  value  can  be  accessed  and  modified by any
statement in  a program. These variables  exist during the entire
time  a  program  executes.  Conventional  wisdom  is that Global
variables are  to be avoided  as they can  easily result in  side
effects.


INFORMATION HIDING
------------------
A design practise  in which implementation details  for both data
structures  and  algorithms  within  a  module  are  hidden  from
routines using  same. What is  hidden does not  contribute to the
essential  characteristics  of  the  abstraction.  In  theory, it
allows you to use modules in  a manner different from the planned
way without breaking  the routine that calls it.  In short units,
modules, and routines  are supposed to give out  information on a
need to know basis only, in order to avoid side effects.


LOCAL VARIABLE
--------------
A program variable whose scope in TP  is limited to a given block
of code  or routine. These  variables exist only  while the given
routine is executing. Conventional wisdom  is that you should use
Local rather than Global variables in your program.


MODULAR DESIGN
--------------
An approach to software design in  which a program is broken down
into  small units,  or modules,  each of  which can be developed,
tested,  and finished  independently before  being combined  with
other modules.


MODULAR VARIABLE
----------------
A conceptual subset  of global variables.  They exist during  the
entire  length  of  program  execution  but  can  be accessed and
modified ONLY by  a block of code known as  a module. They are to
be considered good global. In TP, we will be implementing Modular
variables  with OBP.  You will  need  to  use these  since it  is
impractical to avoid all use of global variables.

--> Continued to next message

 * SLMR 2.1a * Great minds discuss ideas; Small ones discuss people!
---
 * Communications Systems BBS, Richmond, VA, (804)285-7231
 * PostLink(tm) v1.20  COMMSYS (#923) : RelayNet(tm)

{SWAG=???.SWG,JOHN GOHDE,On Pascal ... #0011 2:2}
--> Continued from previous message

MODULE
------
A collection  of routines  and  data  structures that  performs a
particular task or implements a particular abstract data type. We
will  implement modules  in TP  as a  conceptual block of related
units.


OBJECT BASED PROGRAMMING (OBP)
MODULAR PROGRAMMING
------------------------------
A precursor of  object-oriented programming in  which the program
is broken down into several independently compiled modules. It is
considered a refinement of  structured programming or traditional
programming  methods. OBP  recognizes the  strong role  that data
plays in programs.


PASCAL
------
A programming language designed to encourage programmers to write
modular and well structured  programs. With Pascal the programmer
is supposed to deal with  abstractions rather than always working
directly  with computer  memory.  Pascal  was designed  for those
programmers who  want the highest levels  of abstraction possible
in their programs.  Did you know that?  ;-)


SIDE EFFECT
-----------
An unanticipated  effect or change  of state caused  by a routine
that happens when  the program is executed. In  other words, they
are program "bugs".


STATIC BINDING
EARLY BINDING
--------------
Binding that  occurs during program compilation  or linkage. This
is the binding used with traditional programming methods.


STRONG TYPING
-------------
A characteristic  of Pascal  that does  not allow  the program to
change the type of a variable during program execution.


STRUCTURED PROGRAMMING (SP)
TRADITIONAL PROGRAMMING METHODS
-------------------------------
A style   of   programming   designed   to   make  programs  more
comprehensible  and  programming  errors  less frequent. Strictly
speaking, SP concentrates on algorithms  or flow of control while
neglecting the role of data or objects.


TYPE
----
Defines the nature of a variable. It is a level of abstraction.


TYPE CHECKING
-------------
The examination by  a compiler of the operations  in a program to
make sure that  the operations make sense, that  the correct data
types are being used, and  that all expressions are guaranteed to
be type-consistent.


VISIBILITY
SCOPE OF ...
-----------
This refers to the extent a given identifier can be referenced in
a program. Another way of looking at  this issue is how long does
an identifier in a program exist.
-----------------------------------------------------------------

