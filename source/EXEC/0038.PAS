{ Have NO IDEA what the message say ..  they are in Russian ! GDAVIS}
{$IFDEF VIRTUALPASCAL}
����� � OS/2 ����� ���
� ���� ���p��� ? �� � ᢮��
�� ? :)
{$ENDIF}
{$IFDEF DPMI}
����� � DPMI ����� ���
� ���� ���p��� ? �� � ᢮��
�� ? :)
{$ENDIF}
{$IFDEF OS2}
����� � OS/2 ����� ���
� ���� ���p��� ? �� � ᢮��
�� ? :)
{$ENDIF}

Unit MainOvr;
Interface

Uses Overlay,Dos;

Implementation

{.$DEFINE BUILDEXE}

Var
   Ovr_Name : PathStr;
          D : DirStr;
          N : NameStr;
          E : ExtStr;

Begin
  FSplit(ParamStr(0),D,N,E);
{$IFDEF BUILDEXE}
  Ovr_Name:=D+N+'.EXE';
{$ELSE}
  Ovr_Name:=D+N+'.OVR';
{$ENDIF}
  Repeat
    OvrInit(ovr_name);
    If OvrResult=OvrNotFound
      Then
        Begin
          WriteLn('���૥��� 䠩� �� ������ : ',ovr_name);
          Write  ('������ �ࠢ��쭮� ��� :');
          ReadLn(Ovr_Name);
        End;
  Until OvrResult<>OvrNotFound;
  If OvrResult<>OvrOk
    Then
      Begin
        WriteLn('�訡�� ����������� ��e૥�� ',OvrResult);
{$IFDEF STONYBROOK}
        Halt(1);
{$ELSE}
        RunError;
{$ENDIF}
      End;
  OvrInitEMS;
  If OvrResult<>OvrOk
    Then
      Begin
        Case OvrResult Of
          OvrNoEMSDriver : Write('�ࠩ��� EMS ���⠭�����');
          OvrNoEMSMemory : Write('���� ᢮������ EMS �����');
          OvrIOError     : Write('�訡�� �⥭�� 䠩��');
        End;
        Write(' - EMS ������ �� �ᯮ�짥���.');
      End;
  OvrSetRetry(OvrGetBuf div 3);
end.
