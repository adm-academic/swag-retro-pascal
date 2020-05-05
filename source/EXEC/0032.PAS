{
> Could someone tell me the format of a standard EXE and an NE and how they
> relate?

RTM, boy. Right from Tech Help 4.0:

               Standard EXE-format files begin with this header.

Offset Size Contents
������ ���� ������������������������������������������������������������������
            �������Ŀ
 +0      2  �4Dh 5aH� .EXE file signature ('MZ')
            �������Ĵ
 +2      2  �PartPag� length of partial page at end (generally ignored)
            �������Ĵ
 +4      2  �PageCnt� length of image in 512-byte pages, including the header
            �������Ĵ
 +6      2  �ReloCnt� number of items in relocation table
            �������Ĵ
 +8      2  �HdrSize� size of header in 16-byte paragraphs
            �������Ĵ
+0aH     2  �MinMem � minimum memory needed above end of program (paragraphs)
            �������Ĵ
+0cH     2  �MaxMem � maximum memory needed above end of program (paragraphs)
            �������Ĵ
+0eH     2  �ReloSS � segment offset of stack segment (for setting SS)
            �������Ĵ
+10H     2  �ExeSP  � value for SP register (stack pointer) when started
            �������Ĵ
+12H     2  �ChkSum � file checksum (negative sum of all words in file)
            �������Ĵ
+14H     2  �ExeIP  � value for IP register (instruction pointer) when started
            �������Ĵ
+16H     2  �ReloCS � segment offset of code segment (for setting CS)
            �������Ĵ
+18H     2  �TablOff� file-offset of first relocation item (often 001cH)
            �������Ĵ
+1aH     2  �Overlay� overlay number (0 for base module)
            ���������
1cH         size of formatted portion of EXE header
            ����������������� � � ���������������Ŀ Relocation table.  Starts
+ ?     4*? �offset  segment�  �offset  segment� at file offset [EXE+18H].
            ����������������� � � ����������������� Has [EXE+6] DWORD entries.
+ ?     ?   filler to a paragraph boundary
+ ?     ?   start of program image
������������������������������������������������������������������������������
 Since an EXE file may be loaded on any segment, all absolute segment
 references (such as FAR CALLs, long address pointers, and references such as
 MOV AX,data_seg) must be adjusted to work for the memory location in which
 they are loaded.  Here are the steps used by the DOS program loader (Fn 4bH )
 to load an EXE file:

 1. Create a PSP via DOS Fn 26H.

 2. Read 1cH bytes of the EXE file (the formatted portion of the EXE header)
    into a local memory area.

 3. Determine the load module size = ( (PageCnt*512)-(HdrSize*16) ) - PartPag

 4. Determine file offset of load module = (HdrSize * 16)

 5. Select a segment address, START_SEG, for loading (usually PSP + 10H)

 6. Read the load module into memory starting at START_SEG:0000

 7. LSEEK (set file pointer) to the start of the relocation table (TablOff)

 8. For each relocation item (ReloCnt):
    a. read the item as two 16-bit words (I_OFF,I_SEG)
    b. add RELO_SEG=(START_SEG+I_SEG)    (find the address of relocation ref)
    c. fetch the word at RELO_SEG:I_OFF  (read current value)
    d. add START_SEG to that word        (perform the segment fixup)
    e. store the sum back at its original address (RELO_SEG:I_OFF)

 9. Allocate memory for the program according to MaxMem and MinMem

10. Initialize registers and execute the program:
    a. ES = DS = PSP
    b. Set AX to indicate the validity of drive IDs in command line
    c. SS = START_SEG+ReloSS, SP = ExeSP
    d. CS = START_SEG+ReloCS, IP = ExeIP (use: PUSH seg; PUSH offset; RETF)

Note: Recent additions to the EXE format, specifically the CodeView, OS/2,
      and Windows versions of the EXE file contain additional information
      embedded in the executable file.

You won't happen to load a new executable with your bbs software coz new
executables work under special environments, such as: Windows, OS/2 and
other. You should use the above technique for dealing with custom loading of
EXEs by your program. Think of your own format... Well... But if you still
wish to learn the format for NE, try Borland Pascal Windows Help file,
search for 'File Formats', the format of new-executable. This topic is too
large to post here.
}