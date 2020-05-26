{*****************************************************************************
 * Function ...... GetExt()
 * Purpose ....... To return the extention (minus the dot) of a filepath
 * Parameters .... Path      Filepath/mask to return the extension of
 * Returns ....... Three character DOS file extension
 * Notes ......... Uses functions Right, Empty, and PadR
 * Author ........ Martin Richardson
 * Date .......... October 23, 1992
 *****************************************************************************}
FUNCTION GetExt( Path: DirStr ): ExtStr;
VAR dir  : DirStr;
    name : NameStr;
    ext  : ExtStr;
BEGIN
     FSPLIT( path, dir, name, ext );
     IF NOT Empty( Name ) THEN
         GetExt := Right( PadR( ext, 4, ' ' ), 3 )
     ELSE
         GetExt := '    ';
END;

