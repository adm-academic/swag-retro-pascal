Function EncryptDecrypt(S : String : K : String) : String;
Var
  I,Q : Integer;
  O   : String[255];
begin
  Q := 1;
  O := "";
  For I := 1 to Length(S) Do
    begin
      O := O + Chr(Ord(S[I]) Xor Ord(K[Q]));
      Inc(Q); If Q > Length(K) Then Q := 1;
    end;
  EncryptDecrypt := O;
end;

A couple of thoughts on this.

1. If K is short then the decryption is very easy.
2. The routine would be VERY slow as it is using String concatenation.  It
   would be MUCH faster if the O := "" line was changed to O[0] := S[0] and
   the O := O + ... line was replaced With -
   O[I] := ...

TeeCee
