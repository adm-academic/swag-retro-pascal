{****************************************************************************
 * Procedure ..... SetBlink;
 * Purpose ....... To enable blinking vice intensity
 * Parameters .... None
 * Returns ....... Nothing
 * Notes ......... Colors with the background attribute high-bit set will
 *                 blink.
 * Author ........ Martin Richardson
 * Date .......... October 28, 1992
 ****************************************************************************}
PROCEDURE SetBlink; ASSEMBLER;
ASM
   MOV  AX, 1003h
   MOV  BL, 01h
   INT  10h
END;
