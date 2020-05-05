
Windows API function:

BOOL GetUserName(

    LPTSTR  lpBuffer,	// address of name buffer 
    LPDWORD  nSize 	// address of size of name buffer 
   );

Delphi example:

procedure X;
var
  USize : DWORD;
  pUName : pchar;
  sUName:string;
begin
  USize := 30;
  getmem(pUName, USize);
  if GetUserName(pUName, USize) then
     sUserName := StrPas(pUName)
  else
     sUserName := 'Unknown';
  freemem( pUName, USize );
end;
