{*******************************}
{*         ����� ���⮣�     *}
{*  ���������᭮�� ������  *}
{*          VSTasks v 1.01     *}
{*   ��� Turbo Pascal ver 7.0  *}
{* (c) Copyright VVSsoft Group *}
{*******************************}
{$F+$S-}

{  v.1.01  ---  �� �ࠢ����� � ���ᨥ� 1.0 ��ࠢ��� ��室 �� �����- }
{               ��楤��� �� ���⨦����  END. � �।��饩 ���ᨨ �㦭� }
{               �뫮 ��易⥫쭮 ��। END-�� �⠢���  HaltCurrentTask, }
{               ����  ��⥬� "��᫠".  ������  ��  ���⨦����  ���� }
{               �����-��楤��� ��⮬�⮬ ����� ����뢠���� ...    }
{                                                                       }
{                               (c) VVSsoft Group.  ������� ��������.   }

Unit VSTasks;

interface {--------------------------------------------}

Type

 PTaskRec =^TTaskRec;  { ---- ����⥫� ����� -----}
 TTaskRec =
  record
   NumProc  : word;        { 㭨����� ����� ����� }
   Next     : PTaskRec;    { ᫥���騩 ����⥫� ����� }
   OrignSP,                { ���祭�� SP ��� ������ }
   OrignSS  : word;        { ���祭�� SS ��� ������ }
   Stack    : pointer;     { 㪠��⥫� �� �⥪ ����� }
   SSize    : word;        { ࠧ��� �⥪� ����� }
  end;

Const

  CountTask   : word = 0;       { �ᥣ� ��ॣ����஢���� ����ᮢ }
  PCurTask    : PTaskRec = Nil; { 㪠��⥫� �� ⥪���� �믮��塞�� ������ }
  HeadStack   : PTaskRec = Nil; { 㪠��⥫� �� ������ �⥪� }
  UniNumber   : word = 1;       { 㭨����� ����� ��� ᮧ��������� ����� }
  CurTask     : word = 0;       { ����� ⥪�饣� ����� }

{----------------- ���� �訡�� ॣ����樨 ����� --------------}

  vstMemoryLow       = 1;   { ��� ����� ��� ᮧ����� �⥪� ����� }
  vstEmptyStackTask  = 2;   { ��� ��ॣ����஢����� ����ᮢ }
  vstMAXLimitProc    = 3;   { ᫨誮� ����� ����ᮢ }

Var
  TaskError     : byte;     { ��᫥���� �訡�� }


procedure StartTasks;
{--- ����� ����ᮢ �� �믮������ ---}

procedure SwithTasks; far;
{--- ��४��祭�� ����� ����砬� ---}

function RegisterTask(TaskPoint : pointer; SizeStack: word): word;
{--- ॣ������ ����� �᫨ - 0, � �訡�� � ��६����� TaskError ---}
{--- �����頥� ����� ��ॣ����஢������ ����� ---}

procedure HaltCurrentTask;
{--- ��⨥ ⥪�饩 ����� ---}

procedure HaltAllTasks;
{--- ��⨥ ��� ����� ---}

implementation
{----------------------------------------------------------------}

Var
    OriginalSS,                { ���� �ਣ����쭮�� �⥪� �ணࠬ��     }
    OriginalSP     : word;     { 㪠��⥫� �ਣ����쭮�� �⥪� �ணࠬ�� }
    PDopPoint      : PTaskRec; { �������⥫�� 㪠��⥫� }

{------- ��८�।������ �㭪樨 ��� ࠡ��� � BASM�� ---------}

function mMemAvail: word;
Var M: longint;
    T: record
        L,H: word;
       end;
begin
 M:=MaxAvail;
 If M>$FFFF then mMemAvail:=$FFFF
  else
   begin
    Move(M,T,SizeOf(longint));
    mMemAvail:=T.L;
   end;
end;

function mGetMem(S:word): pointer;
Var P:pointer;
begin
 GetMem(P,S);
 mGetMem:=P;
end;

procedure mFreeMem(P: pointer;S: word);
Var D: pointer;
begin
 D:=P;
 FreeMem(P,S);
end;

procedure StartTasks; assembler;
{ --- ����� ����ᮢ �� �믮������ --- }
asm
    { 1) ��������� � �⥪� ॣ�����;
      2) ��������� � �⥪� ��� ��室� �� �������� ����ᮢ;
      3) ���࠭��� ॣ����� SS � SP ��� �᭮���� �ணࠬ��;
      4) ���� ���� ����� ��� ����᪠;
      5) �����⠭����� �� ⥪�騥 ��६����;
      6) �����⠭����� SS:SP � ����⠭����� ॣ�����;
      7) �ந����� "������ ��室" (�⠩ �室) RETF � �����;
      8) ��᫥ ������ � ��� ��室� �� �����, ����⠭�����
         ॣ�����. }
   {----------------------------------------------------}
                 PUSH BP                    { ��࠭塞 ॣ�����            }
                 PUSH DI                    {}
                 PUSH SI                    {}
                 PUSH DS                    {}
                 PUSH ES                    {}
                 LEA  DI, @ExitPoint        { � DI ᬥ饭�� ��室�          }
                 PUSH CS                    { ��࠭塞 ��� ��室� ��     }
                 PUSH DI                    { ����ᮢ                     }
                 MOV  OriginalSS, SS        { ��࠭塞 SS:SP               }
                 MOV  OriginalSP, SP        {}
                 MOV  AX, CountTask         { �᫨ ��� ��ॣ����஢. ����� }
                 XOR  BX, BX                {}
                 CMP  AX, BX                {}
                 JE   @Exit                 { ��।� ����ᮢ ����       }
                 MOV  DI, HeadStack.word[0] { � ES:DI 㪠��⥫� ��          }
                 MOV  ES, HeadStack.word[2] { ����⥫� �����            }
                 MOV  AX, ES:[DI]           { ����� ⥪�饣� �����       }
                 MOV  CurTask, AX           {}
                 MOV  PCurTask.word[0], DI  { PCurTask ࠢ�� ��ࢮ��        }
                 MOV  PCurTask.word[2], ES  { ������                      }
                 CLI                        {}
                 MOV  SS, ES:[DI+8]         { �����⠭���� �⥪�           }
                 MOV  SP, ES:[DI+6]         {}
                 STI                        {}
                 POP  BP                    { ���⠭�������� ॣ�����       }
                 POP  ES                    { �����                      }
                 POP  DS                    {}
                 RETF                       { "��室" � �����             }
 @Exit:          POP  AX                    { ���⠥� �� �⥪� ���㦭��     }
                 POP  AX                    {}
                 MOV  AL, vstEmptyStackTask {}
                 MOV  TaskError, AL         {}
 @ExitPoint:     POP  ES                    { ����⠭�������� ॣ�����      }
                 POP  DS                    {}
                 POP  SI                    {}
                 POP  DI                    {}
                 POP  BP                    {}
end;

procedure SwithTasks; assembler;
{ --- ��४��祭�� ����� ����砬� --- }
asm
    { 1) C��࠭���� ��� ॣ���஢ ⥪�饣� ����� [DS,ES,BP];
      2) ��宦����� ᫥���饣� ����� ��� �ᯮ������;
      3) C��࠭���� 㪠��⥫�� SS:SP �� �⥪ ⥪�饣� �����;
      4) ��������� 㪠��⥫�� SS:SP �� �⥪ ��� ��᫥���饣� �����;
      5) ��������� ��� ⥪��� ��६�����;
      6) ����⠭������� ॣ���஢ ��� ������ ����� [BP,ES,DS]; }
   {-----------------------------------------------------------------}
                 PUSH DS                    { ��࠭���� ॣ���஢ ��ண�  }
                 PUSH ES                    { �����                      }
                 PUSH BP                    {}
                 MOV  AX, SEG @Data         { ��⠭���� ᥣ���� ������     }
                 MOV  DS, AX                {}
                 MOV  ES, PCurTask.word[2]  { � ES:DI 㪠��⥫� �� ����⥫�}
                 MOV  DI, PCurTask.word[0]  { ⥪�饣� �����             }
                 MOV  ES:[DI+8], SS         { ��࠭塞 SS:SP � ⥪�饬     }
                 MOV  ES:[DI+6], SP         { ����⥫� �����            }
                 MOV  BX, ES:[DI+4]         { � BX:SI 㪠��⥫� �� ᫥���騩}
                 MOV  SI, ES:[DI+2]         { �����                       }
                 MOV  ES, BX                { 㦥 � ES:SI                   }
                 XOR  AX, AX                { �஢�ઠ �� Nil               }
                 CMP  BX, AX                {}
                 JNE  @Next                 { �᫨ �� Nil-� ��ࠡ�⪥       }
                 CMP  SI, AX                {}
                 JNE  @Next                 {}
                 MOV  ES, HeadStack.word[2] { ���� ᫥���騩 - ��砫��   }
                 MOV  SI, HeadStack.word[0] { ����⥫� HeadStack           }
 @Next:          MOV  PCurTask.word[2], ES  { ���塞 㪠��⥫� �� ⥪�騩   }
                 MOV  PCurTask.word[0], SI  { ����⥫�                     }
                 MOV  AX, ES:[SI]           { ���塞 ����� ⥪�饣� �����}
                 MOV  CurTask, AX           {}
                 CLI                        {}
                 MOV  SS, ES:[SI+8]         { ���塞 㪠��⥫� �⥪�        }
                 MOV  SP, ES:[SI+6]         { ��� ���� �����             }
                 STI                        {}
                 POP  BP                    { ����⠭������� ॣ���஢      }
                 POP  ES                    { ������ �����               }
                 POP  DS                    {}
end;

function RegisterTask(TaskPoint: pointer; SizeStack: word): word; assembler;
{ --- ॣ������ ����� --- }
{ �᫨ ��駢�饭 0, � �訡�� � ��६����� TaskError }
asm
    { 1) �������� � ����� ����⥫� �����;
      2) �뤥����� ����� ��� �⥪ �����;
      3) ��宦����� 㭨���쭮�� ����⥫� �����;
      4) ��離� ����⥫� ������ ����� � 楯��� ����ᮢ;
      5) ���࠭���� � �⥪� ����� ���� �室� � ����� � ॣ���஢;
      6) ��室 � �᭮���� �ணࠬ��. }
    {---------------------------------------------------------}
                 XOR  AX, AX                {}
                 NOT  AX                    {}
                 CMP  AX, UniNumber         {}
                 JE   @TooManyProc          { ᫨誮� ����� ����ᮢ       }
                 CALL mMemAvail             { �஢�ઠ ������ �����       }
                 MOV  BX, SizeStack         {}
                 CMP  AX, BX                {}
                 JB   @LowMem               { �᫨ ����� ���               }
                 PUSH BX                    {}
                 CALL mGetMem               { � DX:AX 㪠��⥫� �� �⥪     }
                 PUSH DX                    {}
                 PUSH AX                    {}
                 CALL mMemAvail             { ������ ��� TTaskRec           }
                 MOV  CX, TYPE TTaskRec     {}
                 CMP  AX, CX                {}
                 JB   @LowMemAndFree        { �᫨ �� 墠��                }
                 PUSH CX                    { ��⮢�� ��ࠬ����             }
                 CALL mGetMem               { �뤥�塞 ������               }
                 PUSH ES                    {}
                 MOV  ES, DX                { ES:DI 㪠�뢠�� �� ����⥫�  }
                 MOV  DI, AX                { ������ �����               }
                 MOV  AX, UniNumber         { ��ᢠ����� 㭨����� �����  }
                 MOV  ES:[DI], AX           {}
                 INC  AX                    { ���६��� UniNumber           }
                 MOV  UniNumber, AX         {}
                 MOV  BX, HeadStack.word[0] { 㪠��⥫� �� ᫥���騩        }
                 MOV  CX, HeadStack.word[2] { ����⥫� = HeadStack         }
                 MOV  ES:[DI+2], BX         {}
                 MOV  ES:[DI+4], CX         {}
                 POP  CX                    { � CX  ���祭�� ES             }
                 POP  AX                    { � AX ᬥ饭�� �⥪�           }
                 MOV  ES:[DI+10], AX        { ᬥ饭�� 㪠��⥫� Stack      }
                 MOV  BX, SizeStack         { ��࠭塞 ࠧ��� �⥪� �      }
                 MOV  ES:[DI+14], BX        { SSize ⥪�饣� ����⥫�      }
                 ADD  AX, BX                { ����塞 ���祭�� SP         }
                 JNC  @NotCorrect           { �᫨ ���४�� �� �㦭�       }
                 XOR  AX, AX                {}
                 NOT  AX                    { AX=$FFFF                      }
 @NotCorrect:    SUB  AX, $01               {}
                 POP  BX                    { � BX ᥣ���� �⥪�            }
                 MOV  ES:[DI+12], BX        { ᥣ���� 㪠��⥫� Stack       }
                 MOV  ES:[DI+8], BX         { OrignSS=BX                    }
                 PUSH ES                    { ��࠭塞 ᥣ���� 㪠��⥫�   }
                 MOV  ES, CX                { ����⠭����� ES               }
                 MOV  CX, TaskPoint.WORD[0] { ᬥ饭�� ��砫� �����        }
                 MOV  DX, TaskPoint.WORD[2] { ᥣ���� ��砫� �����         }
                 PUSH BP
                 CLI                        {}
                 MOV  SI, SS                { ��࠭塞 SS � SI             }
                 MOV  BP, SP                { ��࠭塞 SP � BP             }
                 MOV  SS, BX                { �����⠭�������� �⥪        }
                 MOV  SP, AX                {}
                 MOV  BX,SEG    HaltCurrentTask { ��⮬���᪨� ��室 �    }
                 MOV  AX,OFFSet HaltCurrentTask { ��楤��� HaltCurrentTask }
                 PUSH BX                    { �� ���⨦���� ������ END   }
                 PUSH AX                    { ⥪�饩 ��楤���-�����    }
                 PUSH DX                    { ��࠭塞 ��� �室� �       }
                 PUSH CX                    { �����                       }
                 PUSH DS                    { ��࠭塞 � ��� DS            }
                 PUSH ES                    { -\\- ES                       }
                 MOV  DX, SP                { ��⮢�� �ᥢ�� BP             }
                 ADD  DX, $02               { ��⠫������ ��� � �⥪        }
                 PUSH DX                    {}
                 MOV  CX, SP                {}
                 MOV  SS, SI                { ����⠭�������� �⥪          }
                 MOV  SP, BP                {}
                 STI                        {}
                 POP  BP                    { ����⠭�������� BP            }
                 MOV  AX, ES                {}
                 POP  ES                    {}
                 MOV  ES:[DI+6], CX         { OrignSP=CX                    }
                 PUSH ES                    {}
                 MOV  ES, AX                {}
                 POP  AX                    {}
                 MOV  HeadStack.WORD[0], DI { �����⠭�������� 㪠��⥫�   }
                 MOV  HeadStack.WORD[2], AX { HeadStack                     }
                 MOV  AX, CountTask         { ���६����㥬 CountTask      }
                 INC  AX                    {}
                 MOV  CountTask, AX         {}
                 MOV  AX, UniNumber         { �����頥�� ����� �����   }
                 DEC  AX                    {}
                 JMP  @Exit                 { ��室 �� ��楤���            }
 @TooManyProc:   MOV  AL, vstMAXLimitProc   {}
                 MOV  TaskError, AL         {}
                 JMP  @ErrExit              {}
 @LowMemAndFree: MOV  BX, SizeStack         {}
                 PUSH BX                    {}
                 CALL mFreeMem              {}
 @LowMem:        MOV  AL, vstMemoryLow      {}
                 MOV  TaskError, AL         {}
 @ErrExit:       XOR  AX, AX                {}
 @Exit:
end;

procedure HaltCurrentTask; assembler;
{ --- ��⨥ ⥪�饩 ����� --- }
asm
    { 1) ��宦����� � ��।� ����ᮢ ᫥���饣� �����;
      2) ��४��祭�� �� ��� SS � SP;
      3) �����⠭���� ��� ��६�����;
      4) ����⮦���� �⥪� �।��饣� �����;
      5) �������� �� ��।� ����ᮢ ����⥫� �����;
      6) �������� �� ����� ����⥫� �����;
      7a) �᫨ �� ������ ᫥���騩 ����� - � ����⠭�������
          ��� ॣ���஢ � RETF;
      7b) �᫨ ����� ����ᮢ ���, � ��⠭���� SS:SP �᭮����
          �ணࠬ�� � RETF � ���. }
   {--------------------------------------------------------------}
                 MOV  AX, SEG @Data         { �����⠭���� ᥣ���� DS     }
                 MOV  ES, PCurTask.word[2]  { � ES:DI 㪠��⥫� �� ⥪�騩  }
                 MOV  DI, PCurTask.word[0]  { ����⥫�                     }
                 XOR  AX, AX                { ���㫥��� �������⥫쭮��     }
                 MOV  PDopPoint.word[0], AX { 㪠��⥫�                     }
                 MOV  PDopPoint.word[2], AX {}
                 MOV  AX, ES                { AX:DI                         }
                 MOV  DX, HeadStack.word[2] { � DX:BX ���祭�� ��砫� �⥪� }
                 MOV  BX, HeadStack.word[0] { ����ᮢ                     }
 @Loop:          CMP  DX, AX                { �஢�ઠ ࠢ���⢠ 㪠��⥫�� }
                 JNE  @NextProc             { AX:DI � DX:BX                 }
                 CMP  BX, DI                { �᫨ �� ࠢ��, � ���� ࠢ���}
                 JNE  @NextProc             {}
                 JMP  @DelProcess           { � 㤠����� �����           }
 @NextProc:      MOV  ES, DX                { ��ந� ॣ���஢�� ����       }
                 MOV  SI, BX                { ES:SI - 㪠��⥫�             }
                 MOV  PDopPoint.word[0], BX { ��࠭塞 㪠��⥫� ��        }
                 MOV  PDopPoint.word[2], DX { �।��騩 ����� ����⥫�  }
                 MOV  DX, ES:[SI+4]         { � DX:BX 㪠��⥫� �� ᫥���騩}
                 MOV  BX, ES:[SI+2]         { ����� �⥪� ����⥫��      }
                 JMP  @Loop                 {}
 @DelProcess:    MOV  ES, AX                { ES:DI                         }
                 MOV  BX, ES:[DI+2]         { � BX ᬥ饭�� ᫥���饣�      }
                 MOV  PCurTask.word[0], BX  { �����                      }
                 MOV  DX, ES:[DI+4]         { ⮦� � ᥣ���⮬              }
                 MOV  PCurTask.word[2], DX  {}
                 XOR  CX, CX                { �஢��塞 PDopPoint �� Nil    }
                 CMP  CX, PDopPoint.word[0] {}
                 JNE  @NotNil               { �᫨ �� Nil                   }
                 CMP  CX, PDopPoint.word[2] {}
                 JNE  @NotNil               {}
                 MOV  HeadStack.word[0], BX { ����⠢�塞 㪠��⥫� ��     }
                 MOV  HeadStack.word[2], DX { ��砫� �⥪�                  }
                 JMP  @FreeMem              {}
 @NotNil:        PUSH ES                    {}
                 PUSH DI                    {}
                 MOV  ES, PDopPoint.word[2] { � ES:DI 㪠��⥫� ��          }
                 MOV  DI, PDopPoint.word[0] { �।��騩 �����            }
                 MOV  ES:[DI+2], BX         { ����⠢�塞 㪠��⥫� Next � }
                 MOV  ES:[DI+4], DX         { �।��饣� �����          }
                 POP  DI                    { � ES:DI 㪠��⥫� �� 㤠�塞�}
                 POP  ES                    { �����                       }
 @FreeMem:       CLI                        {}
                 MOV  SS, OriginalSS        { ����⠭�������� �⥪          }
                 MOV  SP, OriginalSP        { �᭮���� �ணࠬ��            }
                 STI                        {}
                 MOV  DX, ES:[DI+12]        { � DX:BX 㪠��⥫� ��  �⥪    }
                 MOV  BX, ES:[DI+10]        { 㤠�塞��� �����           }
                 MOV  CX, ES:[DI+14]        { � CX ࠧ��� �⥪�             }
                 PUSH ES                    {}
                 PUSH DI
                 PUSH DX                    { ��⮢�� �⥪ � �᢮�������    }
                 PUSH BX                    { ������ �⥪� 㤠�塞���       }
                 PUSH CX                    { �����                      }
                 CALL mFreeMem              {}
                 POP  DI                    {}
                 POP  ES                    {}
                 MOV  CX, TYPE TTaskRec     { ࠧ��� ����� TTaskRec -> CX  }
                 PUSH ES                    { 㤠�塞 ����⥫� ����� �� }
                 PUSH DI                    { �����                        }
                 PUSH CX                    {}
                 CALL mFreeMem              {}
                 XOR  AX, AX                { ���㫨�� ����� ��饣� �����}
                 MOV  CurTask, AX           {}
                 MOV  AX, CountTask         { ���६��� CountTask           }
                 DEC  AX                    {}
                 MOV  CountTask, AX         {}
                 JZ   @Exit                 { ����ᮢ ����� ���          }
                 MOV  ES, PCurTask.word[2]  { PCurTask -> ES:DI             }
                 MOV  DI, PCurTask.word[0]  {}
                 MOV  BX, ES                {}
                 XOR  AX, AX                {}
                 CMP  AX, BX                { �᫨ PCurTask �� ࠢ��        }
                 JNE  @SetProcess           { Nil, � �����⠭�����        }
                 CMP  AX, DI                { ⥪�騩 �����               }
                 JNE  @SetProcess           {}
                 MOV  ES, HeadStack.word[2] { HeadStack -> ES:DI            }
                 MOV  DI, HeadStack.word[0] {}
                 MOV  PCurTask.word[2], ES  { ES:DI -> PCurTask             }
                 MOV  PCurTask.word[0], DI  {}
 @SetProcess:    MOV  AX, ES:[DI]           { NumProc -> AX                 }
                 MOV  CurTask, AX           {}
                 CLI                        {}
                 MOV  SS, ES:[DI+8]         { �����⠭���� �⥪�           }
                 MOV  SP, ES:[DI+6]         {}
                 STI                        {}
                 POP  BP                    { ����⠭������� ॣ���஢      }
                 POP  ES                    { �����                      }
                 POP  DS                    {}
 @Exit:
end;

procedure HaltAllTasks; assembler;
{ --- ��⨥ ��� ����� --- }
asm
    { 1) ���㫥��� ��� ��६�����;
      2) �������� ��।� ����ᮢ � �⥪���;
      3) ��⠭���� SS:SP �᭮���� �ணࠬ�� � RETF � ���. }
                 MOV  AX, SEG @Data         { ����⠭�������� ᥣ���� DS    }
                 MOV  DS, AX                {}
                 XOR  AX, AX                { PCurTask=Nil                  }
                 MOV  PCurTask.word[0], AX  {}
                 MOV  PCurTask.word[2], AX  {}
                 CLI                        {}
                 MOV  SS, OriginalSS        { ����⠭�������� �⥪ �ணࠬ��}
                 MOV  SP, OriginalSP        {}
                 STI                        {}
 @Loop:          XOR  AX, AX                {}
                 CMP  AX, CountTask         { ᬮ�ਬ ���� �� ������      }
                 JE   @StackEmpty           { �᫨ ��� ��室                }
                 MOV  ES, HeadStack.word[2] { � ES:DI 㪠��⥫� �� ����   }
                 MOV  DI, HeadStack.word[0] { ����� ��।� ����ᮢ     }
                 MOV  DX, ES:[DI+4]         { DX:BX 㪠��⥫� �� ᫥���騩  }
                 MOV  BX, ES:[DI+2]         { ����� �⥪� ��� Nil         }
                 MOV  HeadStack.word[2], DX { HeadStack = DX:BX             }
                 MOV  HeadStack.word[0], BX {}
                 MOV  AX, ES:[DI+12]        { � AX:CX 㪠��⥫� �� �⥪     }
                 MOV  CX, ES:[DI+10]        { �����                      }
                 PUSH ES                    { ��⮢�� �⥪ ��� �맮�� ���-}
                 PUSH DI                    { ���� ���⪨ �����           }
                 PUSH AX                    { AX:CX - 㪠��⥫� �� �⥪     }
                 PUSH CX                    { �����                      }
                 MOV  AX, ES:[DI+14]        { � AX ࠧ��� �⥪�             }
                 PUSH AX                    {}
                 CALL mFreeMem              { 㭨�⮦��� �⥪ �����      }
                 MOV  AX, TYPE TTaskRec     { � AX ࠧ��� ����⥫� �����}
                 PUSH AX                    {}
                 CALL mFreeMem              { 㭨�⮦��� ����⥫� ����� }
                 MOV  AX, CountTask         { ���६����㥬 CountTask      }
                 DEC  AX                    {}
                 MOV  CountTask, AX         {}
                 JMP  @Loop                 { 㭨�⮦��� ᫥���騩 �����  }
 @StackEmpty:    MOV  CurTask, AX           { CurTask=0                     }
end;

{----------------------------------------------------------------}
end.
