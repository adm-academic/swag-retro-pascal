{
BO BendTSEN

  Upper/lower changing of Strings are always a difficult problem,
  but as a person living in Denmark i must normally care about
  danish Characters, i know a lot of developers does not care about
  international Character and just use the normal UPCASE routines.
  I advise you to use these routines or make some that has the
  same effect, so we will not have any problems when searching for
  uppercased Strings.

  Made available to everyone 1993 by Bo Bendtsen 2:231/111 +4542643827

     Lowcase   Upper/high/capital letters
              �
     �         �
     �         �
     �         �
     �         �
     �         �
     �         �
     �         �
     �         �

}

Function UpChar(Ch : Char) : Char;
{ Uppercase a Char }
begin
  If Ord(Ch) In [97..122] Then Ch := Chr(Ord(Ch) - 32)
  Else If Ord(Ch) > 90 Then
    If Ch='' Then Ch:='�'
    Else If Ch='�' Then Ch:='�' Else If Ch='�' Then Ch:='�'
    Else If Ch='�' Then Ch:='�' Else If Ch='�' Then Ch:='�'
    Else If Ch='�' Then Ch:='�' Else If Ch='�' Then Ch:='�'
    Else If Ch='�' Then Ch:='�' Else If Ch='�' Then Ch:='�';
  UpChar:=Ch;
end;

Function StUpCase(S : String) : String;
{ Uppercase a String }
Var
  SLen : Byte Absolute S;
  x    : Integer;
begin
  For x := 1 To SLen Do S[x]:=UpChar(S[x]);
  StUpCase := S;
end;

Function LowChar(Ch : Char) : Char;
{ lowercase a Char }
begin
  If Ord(Ch) In [65..90] Then Ch := Chr(Ord(Ch) + 32)
  Else If Ord(Ch) > 122 Then
    If Ch='�' Then Ch := ' '
    Else If Ch='�' Then Ch:='�' Else If Ch='�' Then Ch:='�'
    Else If Ch='�' Then Ch:='�' Else If Ch='�' Then Ch:='�'
    Else If Ch='�' Then Ch:='�' Else If Ch='�' Then Ch:='�'
    Else If Ch='�' Then Ch:='�' Else If Ch='�' Then Ch:='�';
  LowChar := Ch;
end;

Function StLowCase(S : String) : String;
{ Lowercase a String }
Var
  SLen : Byte Absolute S;
  i    : Integer;
begin
  For i := 1 To SLen Do S[i]:=LowChar(S[i]);
  StLowCase := S;
end;

Function StToggleCase(S : String) : String;
{ lower = upper and upper = lower }
Var
  SLen : Byte Absolute S;
  i    : Integer;
begin
  For i := 1 To SLen Do
  begin
    If Ord(S[i]) In [65..90] Then S[i] := Chr(Ord(S[i]) + 32)
    Else If Ord(S[i]) In [97..122] Then S[i] := Chr(Ord(S[i]) - 32)
    Else If Pos(S[i],'��������') <> 0 Then S[i]:=UpChar(S[i])
    Else If Pos(S[i],'���������')<> 0 Then S[i]:=LowChar(S[i]);
  end;
  StToggleCase := S;
end;

Function StSmartCase(S : String) : String;
{ bO bEnDTSen will be converted into : Bo Bendtsen }
Var
  SLen : Byte Absolute S;
  i    : Integer;
begin
  s:=StLowCase(s);
  For i := 1 To SLen Do
  begin
    If i=1 Then S[1]:=UpChar(S[1])
    Else if S[i-1]=' ' Then S[i]:=UpChar(S[i])
    Else if (Ord(S[i-1]) In [32..64]) And (S[i-1]<>'''') Then
S[i]:=UpChar(S[i]);
  end;
  StSmartCase := S;
end;
