Unit BitOper;
{$F+,O+}
Interface

Function GetBit(a,n: byte):byte;              { �����頥� ���祭�� n-��� ���
}
Function SetBitZero(a,n:byte):byte;                      { ����뢠�� n-� ���
}
Function SetBitOne(a,n:byte):byte;                    { ��⠭�������� n-� ���
}

Implementation

Function GetBit(a,n: byte):byte;              { �����頥� ���祭�� n-��� ���
}
Begin
    GetBit:=1 and (a shr n);
End;

Function SetBitZero(a,n:byte):byte;                      { ����뢠�� n-� ���
}
Begin
    SetBitZero:=a and (not(1 shl n));
End;

Function SetBitOne(a,n:byte):byte;                    { ��⠭�������� n-� ���
}
Begin
    SetBitOne:=a or (1 shl n);
End;

End.
