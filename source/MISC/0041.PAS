{*****************************************************************************
 * Function ...... RTOI()
 * Purpose ....... To convert a real to an integer
 * Parameters .... RealNum    Real type number
 * Returns ....... The integer part of RealNum
 * Notes ......... Simply truncates the decimals
 *               . Uses function Left
 * Author ........ Martin Richardson
 * Date .......... May 13, 1992
 *****************************************************************************}
FUNCTION RTOI( RealNum: REAL ): LONGINT;
VAR
   s: STRING;
   l: LONGINT;
   i: INTEGER;
BEGIN
     STR( RealNum:17:2, s );
     s := Left( s, LENGTH(s) - 3 );
     VAL( s, l, i );
     RTOI := l;
END;

