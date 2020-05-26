{*****************************************************************************
 * Function ...... IsFile()
 * Purpose ....... Checks for the existance of a file
 * Parameters .... sFile      File to check for
 * Returns ....... TRUE if sFile exists
 * Notes ......... None
 * Author ........ Martin Richardson
 * Date .......... May 13, 1992
 *****************************************************************************}
{ Checks for existance of a file }
FUNCTION IsFile( sFile: STRING ): BOOLEAN;
VAR s : SearchRec;
BEGIN
     FINDFIRST( sFile, directory, s );
     IsFile := (DOSError = 0) AND
               (s.Attr AND Directory <> Directory) AND
               (POS( '?', sFile ) = 0) AND
               (POS( '*', sFile ) = 0);
END;

