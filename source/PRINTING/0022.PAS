{ Number of parallel ports installed in the system.
  Part of the Heartware Toolkit v2.00 (HTparal.PAS) for Turbo Pascal.
  Author: Jose Almeida. P.O.Box 4185. 1504 Lisboa Codex. Portugal.
          I can also be reached at RIME network, site ->TIB or #5314.
  Feel completely free to use this source code in any way you want, and, if
  you do, please don't forget to mention my name, and, give me and Swag the
  proper credits. }

FUNCTION Parallel_Ports : byte;
{ DESCRIPTION:
    Number of parallel ports installed in the system.
  SAMPLE CALL:
    NB := Parallel_Ports; }

BEGIN { Parallel_Ports }
  Parallel_Ports := MemW[$0000:$0410] shr 14;
END; { Parallel_Ports }
