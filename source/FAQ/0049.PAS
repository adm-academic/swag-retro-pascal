#DATA $NAME "An Introduction to Boolean Arithmetic" / $AUTHOR "Light Ray" / $VERSION 001 / $DATE  950709 / $TYPE  { TEXT ASCII
 CRLF } #DATA

          ********************************************************
          *                                                      *
          *                    An Introduction To                *               
          *                                                      *
          *                     Boolean Arithmetic               *
          *                      aka Binary Math                 *
          *                                                      *
          *                           by                         *
          *                                                      *
          *                        Light Ray                     *
          *                                                      *
          ********************************************************

  NOTE: This refers to "binary arithmetic" as in arithmetic involving
  the manipulation of binary bits, not necessarily arithmetic involving
  two operands.

  PREREQUISITE: NumberBases.* / NUMBASES.*

  The following operations will be summarized in this 
  document:  NOT, AND, NAND, OR, NOR, and XOR.

  //===================\\
  || SIMPLE OPERATIONS ||
  \\===================//

  The NOT, AND, OR, and XOR operations are "atomic."  That is, these are
  the simplest operations and any other operation can be "built" using
  them.

  +-------------------+
  | The NOT Operation |
  +-------------------+

  NOT is sometimes known as the "Inverse" operation.

  NOT simply reverses the state of all bits.  A one becomes a zero and
  a zero becomes a one.

  The expression "NOT A" is written as "A" with an overscore. (an overscore
  is a horizontal line above the letter).

       +--------------+--------------+
       | Input (A)    | Output (B)   |         _
       +--------------+--------------+     B = A 
       |     0        |     1        |
       |     1        |     0        |
       +--------------+--------------+

  The converse of a not operator is true.  If A = NOT B, then B = NOT A.

  
  +-------------------+
  | The AND Operation |
  +-------------------+

  The and operation is a binary operator.  It takes two parameters, usually
  in the form "a AND b".

  AND results in 1 only when both operands are 1, otherwise it results in
  zero.

  AND is sometimes written as a dot or multiplication sign.

  Here is the truth table for C = A AND B

       +--------------+--------------+--------------+
       | Input (A)    | Input (B)    | Output (C)   |
       +--------------+--------------+--------------+  
       |     0        |     0        |     0        |  C = A AND B
       |     1        |     0        |     0        |  C = A * B
       |     0        |     1        |     0        |
       |     1        |     1        |     1        |
       +--------------+--------------+--------------+

  +-------------------+
  | The OR Operation  |
  +-------------------+

  The OR operation is a binary operator.  It takes two parameters, usually
  in the form "a OR b".

  OR results in 1 when at least one input is 1.  This can be rephased to
  say that the output is 0 only when both inputs are zero, otherwise it
  is one.

  OR is alternatively written as a plus sign.

  Here is the truth table for C = A OR B

       +--------------+--------------+--------------+
       | Input (A)    | Input (B)    | Output (C)   |
       +--------------+--------------+--------------+  
       |     0        |     0        |     0        |  C = A OR B
       |     1        |     0        |     1        |  C = A + B
       |     0        |     1        |     1        |
       |     1        |     1        |     1        |
       +--------------+--------------+--------------+

  +-------------------+
  | The XOR Operation |
  +-------------------+

  XOR is a binary operation and is a derrivative of the OR operator.
  
  XOR stands for "EXCLUSIVE OR", meaning that it results in ONE if and
  only if either operand is one, but results in zero of neither or both
  operands are one.

  XOR is alternatively written as a plus enclosed by a circle, written
  in ASCII as a plus in parenthesis.

       +--------------+--------------+--------------+
       | Input (A)    | Input (B)    | Output (C)   |
       +--------------+--------------+--------------+  
       |     0        |     0        |     0        |  C = A XOR B
       |     1        |     0        |     1        |  C = A (+) B
       |     0        |     1        |     1        |
       |     1        |     1        |     0        |
       +--------------+--------------+--------------+

  //===================\\
  || COMLEX OPERATIONS ||
  \\===================//

  These operations may be built using the other operations.


  +--------------------+
  | The NOR Operation  |
  +--------------------+

   A NOR B is one only when (A==0) and (B==0).

   [ "==" is read "is".  (A==B) is true (1) when A equals B, otherwise
    it is false (0). ]

   if    C = A NOR B
   then  C = NOT (A OR B) 

   C = NOT (A OR B) is alternatively written as A+B with an overscore:
       _______
   C = (A + B)
   
       +--------------+--------------+--------------+
       | Input (A)    | Input (B)    | Output (C)   |  
       +--------------+--------------+--------------+  
       |     0        |     0        |     1        |  C = NOT (A + B)
       |     1        |     0        |     0        |      _______
       |     0        |     1        |     0        |  C = (A + B)
       |     1        |     1        |     0        |
       +--------------+--------------+--------------+  C = (A==0) AND (B==0)

  +---------------------+
  | The NAND Operation  |
  +---------------------+

   if   C = A NAND B
   then C = NOT (A AND B)

       +--------------+--------------+--------------+
       | Input (A)    | Input (B)    | Output (C)   |  
       +--------------+--------------+--------------+  
       |     0        |     0        |     1        |  C = NOT (A * B)
       |     1        |     0        |     1        |      _______
       |     0        |     1        |     1        |  C = (A * B)
       |     1        |     1        |     0        |
       +--------------+--------------+--------------+  C = NOT ((A==1) AND (B==1))


  ---------------------------------
   END
  ---------------------------------

  This was typed and editted by Light Ray at the Digital Forest BBS,
  which may be reached at +1 (714) 586-6142.  It is located in 
  Mission Viejo, California, United States of America.  This document
  is based on Explorer Post 340 "lab notes" by "rlh" dated 5/10/95.
  Please send any comments, suggestions, compaints, or addittions to
  me at dr261@cleveland.freenet.edu, even if all you say is "I read
  your file."  I may also be reached at 1:103/925, 66:714/10, or
  50:100/505.

  Light Ray
               
 Written by Tobin Fricke sometime in 1995.  Feel free to contact me. 
 My email addresses are: tobin@mail.edm.net, fricke@roboben.engr.ucdavis.edu,
 and dr261@cleveland.freenet.edu.  You should be able to contact me via one 
 of those.
  