=====================
section 1. General questions
    101. Why won't my code work?
    102. What is this newsgroup about?
    103. What's the difference from comp.sys.ibm.pc.programmer?
    104. What other newsgroups should I know about?

section 2. Compile and link
    201. What the heck is "DGROUP > 64K"?
    202. How do I fix "automatic data segment exceeds 64K" or "stack
         plus data exceed 64K"?
    203. Will Borland C code and Microsoft C code link together?
    204. Why did my program bomb at run time with "floating point
         formats not linked"?
    205. Why did my program bomb with "floating point not loaded"?
    206. How can I change the stack size in Borland's C compilers?
    207. What's the format of an .OBJ file?
    208. What's the format of an .EXE header?
    209. What's the difference between .COM and .EXE formats?

section 3. Keyboard
    301. How can I read a character without echoing it to the screen,
         and without waiting for the user to press the Enter key?
    302. How can I find out whether a character has been typed, without
         waiting for one?
    303. How can I disable Ctrl-C/Ctrl-Break and/or Ctrl-Alt-Del?
    304. How can I disable the print screen function?
    305. How can my program turn NumLock (CapsLock, ScrollLock) on/off?
    306. How can I speed up the keyboard's auto-repeat?
    307. What is the SysRq key for?
    308. How can my program tell what kind of keyboard is on the system?
    309. How can I tell if input, output, or stderr has been redirected?

section 4. Disks and files
    401. What drive was the PC booted from?
    402. How can I boot from drive b:?
    403. Which real and virtual disk drives are valid?
    404. How can I make my single floppy drive both a: and b:?
    405. Why won't my C program open a file with a path?
    406. How can I redirect printer output to a file?
    407. How can my program open more files than DOS's limit of 20?
    408. How can I read, create, change, or delete the volume label?
    409. How can I get the disk serial number?
    410. What's the format of .OBJ, .EXE., .COM files?

section 5. Serial ports (COM ports)
    501. How do I set my machine up to use COM3 and COM4?
    502. How do I find the I/O address of a COM port?
    503. But aren't the COM ports always at I/O addresses 3F8, 2F8, 3E8,
         and 2E8?
    504. How do I configure a COM port and use it to transmit data?
section 6. Other hardware questions and problems
    601. Which 80x86 CPU is running my program?
    602. How can a C program send control codes to my printer?
    603. How can I redirect printer output to a file?
    604. Which video adapter is installed?
    605. How do I switch to 43- or 50-line mode?
    606. How can I find the Microsoft mouse position and button status?
    607. How can I access a specific address in the PC's memory?
    608. How can I read or write my PC's CMOS memory?
    609. How can I access memory beyond 640K?
section 7. Other software questions and problems
    701. How can a program reboot my PC?
    702. How can I time events with finer resolution than the system
         clock's 55 ms (about 18 ticks a second)?
    703. How can I find the error level of the previous program?
    704. How can a program set DOS environment variables?
    705. How can I change the switch character to - from /?
    706. Why does my interrupt function behave strangely?
    707. How can I write a TSR (terminate-stay-resident) utility?
    708. How can I write a device driver?
    709. What can I use to manage versions of software?
    710. What's this "null pointer assignment" after my C program
         executes?

section A. Downloading
    A01. What is garbo?  What is wustl?
    A02. What are Simtel and "mirror sites"?  What good are they?
    A03. Where do I find program <mumble>?
    A04. How can I check Simtel or garbo before I post a request for a
         program?
    A05. How do I download and decode a program I found?
    A06. Where is UUDECODE?
    A07. Why do I get errors when extracting from a ZIP file I
         downloaded?

section B. Vendors and products
    B01. How can I contact Borland?
    B02. How can I contact Microsoft?
    B03. What's the current version of PKZIP?
    B04. What's in Borland Pascal/Turbo Pascal 7.0?
    B05. What's in Microsoft C/C++ 7.0?
section C. More information
    C01. Are there any good on-line references for PC hardware
         components?
    C02. Are there any good on-line references for PC interrupts?
    C03. What and where is "Ralf Brown's interrupt list"?
    C04. Where can I find lex, yacc, and language grammars?
    C05. What's the best book to learn programming?
    C06. Where are FAQ lists archived?
    C07. Where can I get the latest copy of this FAQ list?



section 1. General questions
============================

Q101. Why won't my code work?

    First you need to try to determine whether the problem is in your
    use of the programming language or in your use of MSDOS and your PC
    hardware.  (Your manual should tell you which features are standard
    and which are vendor- or MSDOS- or PC-specific.  You _have_ read
    your manual carefully, haven't you?)

    If the feature that seems to be working wrong is something related
    to your PC hardware or to the internals of MS-DOS, this group is the
    right place to ask.  (Please check this list first, to make sure
    your question isn't already answered.)

    On the other hand, if your problem is with the programming language,
    the comp.lang hierarchy (including comp.lang.pascal and comp.lang c)
    is probably a better resource.  Please read the other group's FAQ
    list thoroughly before posting.  (These exist in comp.lang.c,
    comp.lang.c++, comp.lang.modula3, comp.lang.lisp, comp.lang.perl;
    they may exist in other groups as well.)  It's almost never a good
    idea to crosspost between this group and a language group.

    Before posting in either place, try to make your program as small as
    possible while still exhibiting the bad behavior.  Sometimes this
    alone is enough to show you where the trouble is.  Also edit your
    description of the problem to be as short as possible.  This makes
    it look more like you tried to solve the problem on your own, and
    makes people more inclined to try to help you.

    When you do post a question, it's good manners to say "email please;
    I'll post a summary."  Then everybody else in the group doesn't have
    to read ten virtually identical responses.  Of course, then you have
    to follow through.  A summary is not simply pasting together all the
    email you received.  Instead, write your own (brief) description of
    the solution:  this is the best way to make sure you really
    understand it.  Definitely don't repost people's cute signatures.

Q102. What is this newsgroup about?

    comp.os.msdos.programmer (comp.sys.ibm.pc.programmer until September
    1990) concerns programming for MS-DOS systems.  The article "USENET
    Readership report for Nov 92" in news.lists shows 42,000 readers of
    this newsgroup worldwide.  Traffic was 1090.7 Kbytes (exclusive of
    crossposts), comprised in 611 articles.

    Much of our traffic is about language products (chiefly from Borland
    and Microsoft).  More programming topics focus on C than on any one
    other language.

    Since most MS-DOS systems run on hardware that is roughly compatible
    with the IBM PC, on Intel 8088, 80188, or 80x86 chips, we tend to
    get a lot of questions and answers about programming other parts of
    the hardware.

Q103. What's the difference from comp.sys.ibm.pc.programmer?

    c.s.i.p.programmer is the old name of comp.os.msdos.programmer, and
    has been obsolete since September 1990.  However, many systems have
    not removed the old group, or have removed it but aliased it to the
    new name.  This means that some people still think they're posting
    to c.s.i.p.programmer even though they're actually posting to
    c.o.m.programmer.

    You can easily verify the non-existence of c.s.i.p.programmer by
    reference to the "List of Active Newsgroups" posted to news.groups.
    It's available as /pub/usenet/news.answers/active-newsgroups/part1
    from the archives (see "Where are FAQ lists archived?" in section C,
    "More information").

Q104. What other newsgroups should I know about?

    Your best bet is to read the periodic information postings in the
    comp.binaries.ibm.pc newsgroup.  Specially helpful articles:
        Using the comp.binaries.ibm.pc.d groups
        Beginner's guide to binaries
        Starter kit
        About archives and archivers
    Please wait for these articles to come around; don't post a request.

    Also check out news.announce.newusers, even if you're not a new
    user.  You may be surprised how much useful information is in the
    monthly postings there.  Lots of old-timers also get useful stuff
    from news.newusers.questions, especially the periodic postings.

    Remember that it's good manners to subscribe to any newsgroup and
    read it for a while before you post a question.  When you post, it's
    also good manners to ask for replies to be emailed and then to post
    a summary, which you've edited down to the absolute minimum size.

    You may also be interested in the following newsgroups.  Caution:
    Some of them have specialized charters; you'll probably get (and
    deserve) some flames if you post to an inappropriate group.

    - misc.forsale.computers and misc.forsale.computers.pc-clone are
      where you post notices of equipment, software, or computer books
      that you want to sell.  Please don't post or crosspost those
      notices to comp.os.msdos.programmer.

    - comp.os.ms-windows.programmer.tools and ...misc (formerly part of
      comp.windows.ms.programmer):  Similar to this group, but focus
      on programming for the MS-Windows platform.

    - comp.sys.ibm.pc.hardware is for more hardware-oriented discussions
      of the machines that run DOS.

    - comp.binaries.ibm.pc.wanted: AFTER you have looked in the other
      groups, this is the place to post a request for a particular
      binary program.

    - comp.binaries.msdos.announce (moderated) explains how to use the
      archive sites, especially garbo and Simtel, and lists files
      uploaded to them.  Discussions belong in comp.binaries.msdos.d,
      which replaced comp.binaries.ibm.pc.archives.

    - comp.binaries.ibm.pc.d is for discussions about programs posted in
      comp.binaries.ibm.pc, and only those programs.  This is a good
      place to report bugs in the programs, but not to ask where to find
      them (see cbip.wanted, above).  cbip.d is NOT supposed to be a
      general PC discussion group.

    - comp.sources.misc: a moderated group for source code for many
      computer systems.  It tends to get lots of Unix stuff, but you may
      also pick up some DOS-compatible code here.

    - alt.sources: an unmoderated group for source code.  Guidelines are
      posted periodically.

    - Turbo Vision is a mailing list, not a newsgroup; send email to
      listserv@vtvm1.cc.vt.edu if you want to subscribe.


section 2. Compile and link
===========================

Q201. What the heck is "DGROUP > 64K"?

    DGROUP is a link-time group of data segments, and the compiler
    typically generates code that expects DS to be pointing to DGROUP.
    (Exception: Borland's huge model has no DGROUP.)

    Here's what goes into DGROUP:

    - tiny model (all pointers near):  DGROUP holds the entire program.

    - small and medium models (data pointers near):  DGROUP holds all
      globals and static variables including string literals, plus the
      stack and the heap.

    - large, compact, and huge models in Microsoft (data pointers far):
      DGROUP holds only initialized globals and static variables
      including string literals, plus the stack and the near heap.

    - large and compact models in Borland (data pointers far): DGROUP
      holds initialized and uninitialized globals and static variables
      including string literals, but not the stack or heap.

    - huge model in Borland (data pointers far): there is no DGROUP, so
      the 64K limit doesn't apply.

    In all of the above, which is to say all six models in Microsoft C
    and all but huge in Borland C, DGROUP is limited to 64K including
    string literals (which are treated as static data).  This limitation
    is due to the Intel CPU's segmented architecture.

    See the next Q for possible remedies.

    For more information, see topics like "memory models" and "memory
    management" in the index of your compiler manual.  Also see
    TI738.ASC in PD1:<MSDOS.TURBO-C>BCHELP10.ZIP at Simtel for an
    extended general discussion of memory usage in Borland C programs,
    of which much applies to any C compiler in DOS.

Q202. How do I fix "automatic data segment exceeds 64K" or "stack plus
      data exceed 64K"?

    These messages are a variation of "DGROUP > 64K".  For causes,
    please see the preceding Q.

    If you get this error in tiny model, your program is simply too big
    and you must use a different memory model.  If you get this link
    error in models S, C, M, L, or Microsoft's H, there are some things
    you can do.  (This error can't occur in Borland's huge model.)

    If you have one or two big global arrays, simply declare them far.
    The compiler takes this to mean that any references to them will use
    32-bit pointers, so they'll be in separate segments and no longer
    part of DGROUP.

    Or you can use the /Gt[number] option with Microsoft or -Ff[=size]
    with Borland C++ 2.0 and up.  This will automatically put variables
    above a certain size into their own segments outside of DGROUP.

    Yet another option is to change global arrays to far pointers.  Then
    at the beginning of your program, allocate them from the far heap
    (_fmalloc in Microsoft, farmalloc in Borland).

    Finally, you can change to huge model (with Borland compilers, not
    Microsoft).  Borland's H model still uses far pointers by default,
    but "sets aside the [64K] limit" and has no DGROUP group, according
    to the BC++ 2.0 Programmer's Guide.  Microsoft's H model does use
    huge data pointers by default but retains DGROUP and its 64K limit,
    so switching to the H model doesn't buy you anything if you have
    DGROUP problems.

Q203. Will Borland C code and Microsoft C code link together?

    Typically this question is asked by someone who owns compiler A and
    is trying to write code to link with a third-party library that was
    compiled under compiler B.

    The answer to the question is, Not in general.  Here are some of the
    reasons:

    - "Helper" functions (undocumented functions for stack checking,
      floating-point arithmetic, and operations on longs) differ between
      the two compilers.

    - The compilers may embed instructions in the object code that tell
      the linker to look for their own run-time libraries.

    Those problems will generate link-time errors.  Others may not show
    up until run time:

    - Borland's compact, large, and huge models don't assume DS=SS, but
      Microsoft's do.  The -Fs option on the Borland compiler, or one of
      the /A options on Microsoft, should take care of this problem --
      once you know that's what's going on.

    - Check conventions for ordering and packing structure members, and
      for alignment of various types on byte, word, paragraph, or other
      boundaries.  Again, you can generally adjust your code to match if
      you know what conventions were used in compiling the "foreign"
      libraries.

    - Check the obvious and make sure that your code was compiled under
      the same memory model as the code you're trying to link with.
      (That's necessary, but no guarantee.  Microsoft and Borland don't
      use exactly the same conventions for segments and groups,
      particularly in the larger memory models.)

    That said, there are some circumstances where you can link hybrids.
    Your best chance of success comes if you avoid longs and floating
    point, use only 16-bit pointers, suppress stack checking, and
    specify all libraries used in the link.

Q204. Why did my program bomb at run time with "floating point formats
      not linked"?

    First, is that the actual message, or did it say "floating point not
    loaded"?  If it was the latter, see the next Q.

    You're probably using a Borland compiler for C or C++ (including
    Turbo C and Turbo C++).  Borland's compilers try to be smart and not
    link in the floating-point (f-p) library unless you need it.  Alas,
    they all get the decision wrong.  One common case is where you don't
    call any f-p functions, but you have %f or other f-p formats in
    scanf/printf calls.  The cure is to call an f-p function, or at
    least force one to be present in the link.

    To do that, define this function somewhere in a source file but
    don't call it:

        static void forcefloat(float *p)
            { float f = *p; forcefloat(&f); }

    It doesn't have to be in the module with the main program, as long
    as it's in a module that will be included in the link.

    A new solution for Borland C++ 3.0 was posted, but I don't own the
    product and have not been able to verify it.  Insert these
    statements in your program:

        extern unsigned _floatconvert;
        #pragma extref _floatconvert

Q205. Why did my program bomb with "floating point not loaded"?

    That is Microsoft C's run-time message when the code requires a
    numeric coprocessor but your computer doesn't have one installed.

    If the program is yours, relink it using the xLIBCE or xLIBCA
    library (where x is the memory model).

Q206. How can I change the stack size in Borland's C compilers?

    In Turbo C, Turbo C++, and Borland C++, you may not find "stack
    size" in the index but the global variable _stklen should be there.
    The manual will instruct you to put a statement like

        extern unsigned _stklen = 54321U;

    in your code, outside of any function.  You must assign the value
    right in the extern statement; it won't work to assign a value at
    run time.  (The "extern" in this context isn't ANSI C and ought not
    to be required, but the above statement is a direct quote from the
    Library Reference manual of Borland C++ 2.0.)  The linker may give
    you a duplicate symbol warning, which you can ignore.

Q207. What's the format of an .OBJ file?

    Here's what I've been told, though I have verified any of these
    references myself:

    - base .OBJ format:  Intel's document number #121748-001, {8086
      Relocatable Object Module Formats}.  (Note however that both
      Microsoft and Borland formats have extended the .OBJ format.)

    - Microsoft-specific .OBJ formats:  a "Microsoft OMF Specification"
      (document number ??), as well as a section in the MS-DOS
      encyclopedia.

    - A "tutorial on the .OBJ format" comes with the VAL experimental
      linker, which is VAL-LINK.ARC in PD1:<MSDOS.PGMUTL> at Simtel.

    If you have specific references, either to fpt-able documents or to
    published works (author, title, order number or ISBN), please email
    them to brown@ncoast.org for inclusion in the next edition of this
    list.

Q208. What's the format of an .EXE header?

    See pages 349-350 of {PC Magazine}'s June 30, 1992 issue (xi:12) for
    the old and new formats.  For a more detailed layout, look under INT
    21 function 4B in Ralf Brown's interrupt list.  Ralf Brown's list
    includes extensions for Borland's TLINK and Borland debugger info.

    Among the books that detail formats of executable files are {DOS
    Programmer's Reference: 2d Edition} by Terry Dettman and Jim Kyle,
    ISBN 0-88022-458-4; and {Microsoft MS-DOS Programmer's Reference},
    ISBN 1-55615-329-5.

Q209. What's the difference between .COM and .EXE formats?

    To oversimplify:  a .COM file is a direct image of core, and an .EXE
    file will undergo some further relocation when it is run (and so it
    begins with a relocation header).  A .COM file is limited to 64K for
    all segments combined, but an .EXE file can have as many segments as
    your linker will handle and be as large as RAM can take.

    The actual file extension doesn't matter.  DOS knows that a file
    being loaded is in .EXE format if its first two bytes are MZ or ZM;
    otherwise it is assumed to be in .COM format.  For instance, I am
    told that DR-DOS 6.0's COMMAND.COM is in .EXE format.


section 3. Keyboard
===================

Q301. How can I read a character without echoing it to the screen, and
      without waiting for the user to press the Enter key?

    The C compilers from Microsoft and Borland offer getch (or getche to
    echo the character); Turbo Pascal has ReadKey.

    In other programming languages, load 8 in register AH and execute
    INT 21; AL is returned with the character from standard input
    (possibly redirected).  If you don't want to allow redirection, or
    you want to capture Ctrl-C and other special keys, use INT 16 with
    AH=10; this will return the scan code in AH and ASCII code (if
    possible) in AL, except that AL=E0 with AH nonzero indicates one of
    the grey "extended" keys was pressed.  (If your BIOS doesn't
    support the extended keyboard, use INT 16 function 0 not 10.)

Q302. How can I find out whether a character has been typed, without
      waiting for one?

    In Turbo Pascal, use KeyPressed.  Both Microsoft C and Turbo C offer
    the kbhit( ) function.  All of these tell you whether a key has been
    pressed.  If no key has been pressed, they return that information
    to your program.  If a keystroke is waiting, they tell your program
    that but leave the key in the input buffer.

    You can use the BIOS call, INT 16 function 01 or 11, to check
    whether an actual keystroke is waiting; or the DOS call, INT 21
    function 0B, to check for a keystroke from stdin (subject to
    redirection).  See Ralf Brown's interrupt list.

Q303. How can I disable Ctrl-C/Ctrl-Break and/or Ctrl-Alt-Del?

    You can download the file PD1:<MSDOS.KEYBOARD>CADEL.ZIP from Simtel.
    It contains a TSR to disable those keys, with source code in ASM.

    To disable only Ctrl-Alt-Del (actually, to change the boot keys to
    leftShift-Alt-Del), use DEBOOT.COM.  Along with KEYKILL.COM, which
    lets you disable up to three keys of your choice, it is at Simtel in
    the file PD1:<MSDOS.KEYBOARD>KEYKILL.ARC.

    C programmers who simply want to make sure that the user can't
    Ctrl-Break out of their program can use the ANSI-standard signal( )
    function; the Borland compilers also offer ctrlbrk( ) for handling
    Ctrl-Break.  However, if your program uses normal DOS input, the
    characters ^C will appear on the screen when the user presses Ctrl-C
    or Ctrl-Break.  There are many ways to work around that, including:
    use INT 21 function 7, which allows redirection but doesn't display
    the ^C (or echo any other character, for that matter); or use INT 16
    function 0 or 10; or call _bios_keybrd( ) in MSC or bioskey( ) in
    BC++; or hook INT 9 to discard Ctrl-C and Ctrl-Break before the
    regular BIOS keyboard handler sees them; etc., etc.

    You should be aware that Ctrl-C and Ctrl-Break are processed quite
    differently internally.  Ctrl-Break, like all keystrokes, is
    processed by the BIOS code at INT 9 as soon as the user presses the
    keys, even if earlier keys are still in the keyboard buffer:  by
    default the handler at INT 1B is called.  Ctrl-C is not special to
    the BIOS, nor is it special to DOS functions 6 and 7; it _is_
    special to DOS functions 1 and 8 when at the head of the keyboard
    buffer.  You will need to make sure BREAK is OFF to prevent DOS
    polling the keyboard for Ctrl-C during non-keyboard operations.

    Some good general references are {Advanced MS-DOS} by Ray Duncan,
    ISBN 1-55615-157-8; {8088 Assembler Language Programming:  The IBM
    PC}, ISBN 0-672-22024-5, by Willen & Krantz; and {COMPUTE!'s Mapping
    the IBM PC}, ISBN 0-942386-92-2.

Q304. How can I disable the print screen function?

    There are really two print screen functions:  1) print current
    screen snapshot, triggered by PrintScreen or Shift-PrtSc or
    Shift-grey*, and 2) turn on continuous screen echo, started and
    stopped by Ctrl-P or Ctrl-PrtSc.

    1) Screen snapshot to printer
       --------------------------

    The BIOS uses INT 5 for this.  Fortunately, you don't need to mess
    with that interrupt handler.  The standard handler, in BIOSes dated
    December 1982 or later, uses a byte at 0040:0100 (alias 0000:0500)
    to determine whether a print screen is currently in progress.  If it
    is, pressing PrintScreen again is ignored.  So to disable the screen
    snapshot, all you have to do is write a 1 to that byte.  When the
    user presses PrintScreen, the BIOS will think that a print screen is
    already in progress and will ignore the user's keypress.  You can
    re-enable PrintScreen by zeroing the same byte.

    Here's some simple code:

        void prtsc_allow(int allow) /* 0=disable, nonzero=enable */ {
            unsigned char far* flag = (unsigned char far*)0x00400100UL;
            *flag = (unsigned char)!allow;
        }

    2) Continuous echo of screen to printer
       ------------------------------------

    If ANSI.SYS is loaded, you can easily disable the continuous echo of
    screen to printer (Ctrl-P or Ctrl-PrtSc).  Just redefine the keys by
    "printing" strings like these to the screen (BASIC print, C printf,
    Pascal Write statements, or ECHO command in batch files):

        <27>[0;114;"Ctrl-PrtSc disabled"p
        <27>[16;"^P"p

    Change <27> in the above to an Escape character, ASCII 27.

    If you haven't installed ANSI.SYS, I can't offer an easy way to
    disable the echo-screen-to-printer function.  Please send any tested
    solutions to brown@ncoast.org and I'll add them to this list.

    Actually, you might not need to disable Ctrl-P and Ctrl-PrtSc.  If
    your only concern is not locking up your machine, when you see the
    "Abort, Retry, Ignore, Fail" prompt just press Ctrl-P again and then
    I.  As an alternative, install one of the many print spoolers that
    intercept printer-status queries and always return "Printer ready".

Q305. How can my program turn NumLock (CapsLock, ScrollLock) on or off?

    You need to twiddle bit 5, 6, or 4 of location 0040:0017.  Here's
    some code:  lck( ) turns on a lock state, and unlck( ) turns it off.
    (The status lights on some keyboards may not reflect the change.  If
    yours is one, call INT 16 function 2, "get shift status", and that
    may update them.  It will certainly do no harm.)

        #define NUM_LOCK  (1 << 5)
        #define CAPS_LOCK (1 << 6)
        #define SCRL_LOCK (1 << 4)
        void lck(int shiftype) {
            char far* kbdstatus = (char far*)0x00400017UL;
            *kbdstatus |= (char)shiftype;
        }
        void unlck(int shiftype) {
            char far* kbdstatus = (char far*)0x00400017UL;
            *kbdstatus &= ~(char)shiftype;
        }

Q306. How can I speed up the keyboard's auto-repeat?

    The keyboard speed has two components: delay (before a key that you
    hold down starts repeating) and typematic rate (the speed once the
    key starts repeating).  Most BIOSes since 1986 let software change
    the delay and typematic rate by calling INT 16 function 3, "set
    typematic rate and delay"; see Ralf Brown's interrupt list.  If you
    have DOS 4.0 or later, you can use the MODE CON command that you'll
    find in your DOS manual.

    On 83-key keyboards (mostly XTs), the delay and typematic rate can't
    easily be changed.  According to the {PC Magazine} of 15 Jan 1991,
    page 409, to adjust the typematic rate you need "a memory-resident
    program which simply '[watches]' the keyboard to see if you're
    holding down a key ... and after a certain time [starts] stuffing
    extra copies of the held-down key into the buffer."  No source code
    is given in that issue; but I'm told that the QUICKEYS utility that
    {PC} published in 1986 does this sort of watching; you can download
    source and object code in PD1:<MSDOS.PCMAG>VOL5N05.ARC from Simtel.

Q307. What is the SysRq key for?

    There is no standard use for the key.  The BIOS keyboard routines in
    INT 16 simply ignore it; therefore so do the DOS input routines in
    INT 21 as well as the keyboard routines in libraries supplied with
    high-level languages.

    When you press or release a key, the keyboard triggers hardware line
    IRQ1, and the CPU calls INT 9.  INT 9 reads the scan code from the
    keyboard and the shift states from the BIOS data area.

    What happens next depends on whether your PC's BIOS supports an
    enhanced keyboard (101 or 102 keys).  If so, INT 9 calls INT 15
    function 4F to translate the scan code.  If the translated scan code
    is 54 hex (for the SysRq key) then INT 9 calls INT 15 function 85
    and doesn't put the keystroke into the keyboard buffer.  The default
    handler of that function does nothing and simply returns.  (If your
    PC has an older BIOS that doesn't support the extended keyboards,
    INT 15 function 4F is not called.  Early ATs have 84-key keyboards,
    so their BIOS calls INT 15 function 85 but nor 4F.)

    Thus your program is free to use SysRq for its own purposes, but at
    the cost of some programming.  You could hook INT 9, but it's
    probably easier to hook INT 15 function 85, which is called when
    SysRq is pressed or released.

Q308. How can my program tell what kind of keyboard is on the system?

    Ralf Brown's Interrupt List includes MEMORY.LST, a detailed
    breakdown by Robin Walker of the contents of the BIOS system block
    that starts at 0040:0000.  Bit 4 of byte 0040:0096 is "1=enhanced
    keyboard installed".  C code to test the keyboard type:
        char far *kbd_stat_byte3 = (char far *)0x00400096UL;
        if (0x10 & *kbd_stat_byte3)
            /* 101- or 102-key keyboard is installed */

    {PC Magazine}'s 15 Jan 1991 issue suggests on page 412 that "for
    some clones [the above test] is not foolproof".  If you use this
    method in your program you should provide the user some way to
    override this test, or at least some way to tell your program to
    assume a non-enhanced keyboard.  The {PC Magazine} article suggests
    a different approach to determining the type of keyboard.

Q309. How can I tell if input, output, or stderr has been redirected?

    Normally, input and output are associated with the console (i.e.,
    with the keyboard and the screen, respectively).  If either is not,
    you know that it has been redirected.  Some source code to check
    this is available at the usual archive sites.

    If you program in Turbo Pascal, download the /pc/ts/tspa*.zip
    collection of Turbo Pascal units from garbo; or from Simtel,
    PD1:<MSDOS.TURBOPAS>TSPA*.ZIP.  (Choose TSPA3060.ZIP, TSPA3055.ZIP,
    TSPA3050.ZIP, or TSPA3040.ZIP for Turbo Pascal 6.0, 5.5, 5.0, or 4.0
    respectively.)  Source code is not included.  Also see the
    information in garbo.uwasa.fi:/pc/ts/tsfaq*.zip Frequently Asked
    Questions, the Turbo Pascal section.

    If you program in C, use isatty( ) if your implementation has it.
    Otherwise, you can download PD1:<MSDOS.SYSUTL>IS_CON10.ZIP from
    Simtel; it includes source code.

    Good references for the principles are {PC Magazine} 16 Apr 1991
    (vol 10 nr 7) pg 374; Ray Duncan's {Advanced MS-DOS}, ISBN
    1-55615-157-8, or Ralf Brown's interrupt list for INT 21 function
    4400; and Terry Dettman and Jim Kyle's {DOS Programmer's Reference:
    2d edition}, ISBN 0-88022-458-4, pp 602-603.


If the posting date is more than six weeks in the past, see instructions
in part 4 of this list for how to get an updated copy.

            Copyright (C) 1992  Stan Brown, Oak Road Systems


section 4.  Disks and files
===========================

Q401. What drive was the PC booted from?

    Under DOS 4.0 or later, load 3305 hex into AX; do an INT 21.  DL is
    returned with an integer indicating the boot drive (1=A:, etc.).

Q402. How can I boot from drive b:?

    Download PD1:<MSDOS.DSKUTL>BOOT_B.ZIP (shareware) from Simtel.  The
    included documentation says it works by writing a new boot sector on
    a disk in your a: drive that redirects the boot to your b: drive.

Q403. Which real and virtual disk drives are valid?

    Use INT 21 function 29 (parse filename).  Point DS:SI at a null-
    terminated ASCII string that contains the drive letter and a colon,
    point ES:DI at a 37-byte dummy FCB buffer, set AX to 2900h, and do
    an INT 21.  On return, AL is FF if the drive is invalid, something
    else if the drive is valid.  RAM disks and SUBSTed drives are
    considered valid.

    Unfortunately, the b: drive is considered valid even on a single-
    diskette system.  You can check that special case by interrogating
    the BIOS equipment byte at 0040:0010.  Bits 7-6 contain the one less
    than the number of diskette drives, so if those bits are zero you
    know that b: is an invalid drive even though function 29 says it's
    valid.

    Following is some code originally posted by Doug Dougherty, with my
    fix for the b: special case, tested only in Borland C++ 2.0 (in
    the small model):

        #include <dos.h>
        void drvlist(void)  {
            char *s = "A:", fcb_buff[37];
            int valid;
            for (   ;  *s<='Z';  (*s)++) {
                _SI = (unsigned) s;
                _DI = (unsigned) fcb_buff;
                _ES = _DS;
                _AX = 0x2900;
                geninterrupt(0x21);
                valid = _AL != 0xFF;
                if (*s == 'B'  &&  valid) {
                    char far *equipbyte = (char far *)0x00400010UL;
                    valid = (*equipbyte & (3 << 6)) != 0;
                }
                printf("Drive '%s' is %sa valid drive.\n",
                        s, valid ? "" : "not ");
            }
        }

Q404. How can I make my single floppy drive both a: and b:?

    Under any DOS since DOS 2.0, you can put the command

        assign b=a

    into your AUTOEXEC.BAT file.  Then, when you type "DIR B:" you'll no
    longer get the annoying prompt to insert diskette B (and the even
    more annoying prompt to insert A the next time you type "DIR A:").

    You may be wondering why anybody would want to do this.  Suppose you
    use two different machines, maybe one at home and one at work.  One
    of them has only a 3.5" diskette drive; the other machine has two
    drives, and b: is the 3.5" one.  You're bound to type "dir b:" on
    the first one, and get the nuisance message

        Insert diskette for drive B: and press any key when ready.

    But if you assign drive b: to point to a:, you avoid this problem.

    Caution:  there are a few commands, such as DISKCOPY, that will not
    work right on ASSIGNed or SUBSTed drives.  See the DOS manual for
    the full list.  Before typing one of those commands, be sure to turn
    off the mapping by typing "assign" without arguments.

    The DOS 5.0 manual says that ASSIGN is obsolete, and recommends the
    equivalent form of SUBST: "subst b: a:\".  Unfortunately, if this
    command is executed when a: doesn't hold a diskette, the command
    fails.  ASSIGN doesn't have this problem, so I must advise you to
    disregard that particular bit of advice in the DOS manual.

Q405. Why won't my C program open a file with a path?

    You've probably got something like the following code:

        char *filename = "c:\foo\bar\mumble.dat";
        . . .  fopen(filename, "r");

    The problem is that \f is a form feed, \b is a backspace, and \m is
    m.  Whenever you want a backslash in a string constant in C, you
    must use two backslashes:

        char *filename = "c:\\foo\\bar\\mumble.dat";

    This is a feature of every C compiler, because Dennis Ritchie
    designed C this way.  It's a problem only on MS-DOS systems, because
    only DOS (and Atari ST/TT running TOS, I'm told) uses the backslash
    in directory paths.  But even in DOS this backslash convention
    applies _only_ to string constants in your source code.  For file
    and keyboard input at run time, \ is just a normal character, so
    users of your program would type in file specs at run time the same
    way as in DOS commands, with single backslashes.

    Another possibility is to code all paths in source programs with /
    rather than \ characters:

        char *filename = "c:/foo/bar/mumble.dat";

    Ralf Brown writes that "All versions of the DOS kernel accept either
    forward or backslashes as directory separators.  I tend to use this
    form more frequently than backslashes since it is easier to type and
    read."  This applies to DOS function calls (and therefore to calls
    to the file library of every programming language), but not to DOS
    commands.

Q406. How can I redirect printer output to a file?

    My personal favorite utility for this purpose is PRN2FILE from {PC
    Magazine}, available from Simtel as PD1:<MSDOS.PRINTER>PRN2FILE.ARC,
    or from garbo as prn2file.zip in /pc/printer.  ({PC Magazine} has
    given copies away as part of its utilities disks, so you may already
    have a copy.)

    Check the PD1:<MSDOS.PRINTER> directory at Simtel, or /pc/printer
    at garbo, for lots of other printer-redirection utilities.

Q407. How can my program open more files than DOS's limit of 20?

    (This is a summary of an article Ralf Brown posted on 8 August 1992.)

    There are separate limits on files and file handles.  For example,
    DOS opens three files but five file handles:  CON (stdin, stdout,
    and stderr), AUX (stdaux), and PRN (stdprn).

    The limit in FILES= in CONFIG.SYS is a system-wide limit on files
    opened by all programs (including the three that DOS opens and any
    opened by TSRs); each process has a limit of 20 handles (including
    the five that DOS opens).  Example:  CONFIG.SYS has FILES=40.  Then
    program #1 will be able to open 15 file handles.  Assuming that the
    program actually does open 15 handles pointing to 15 different
    files, other programs could still open a total of 22 files (40-3-15
    = 22), though no one program could open more than 15 file handles.

    If you're running DOS 3.3 or later, you can increase the per-process
    limit of 20 file handles by a call to INT 21 function 67, Set Handle
    Count.  Your program is still limited by the system-wide limit on
    open files, so you may also need to increase the FILES= value in
    your CONFIG.SYS file (and reboot).  The run-time library that you're
    using may have a fixed-size table of file handles, so you may also
    need to get source code for the module that contains the table,
    increase the table size, and recompile it.

Q408. How can I read, create, change, or delete the volume label?

    In DOS 5.0 (and, I believe, in 4.0 as well), there are actually two
    volume labels: one, the traditional one, is an entry in the root
    directory of the disk; and the other is in the boot record along
    with the serial number (see next Q).  The DIR and VOL commands
    report the traditional label; the LABEL command reports the
    traditional one but changes both of them.

    In DOS 4.0 and later, use INT 21 function 69 to access the boot
    record's serial number and volume label together; see the next Q.

    Assume that by "volume label" you mean the traditional one, the one
    that DIR and VOL display.  Though it's a directory entry in the root
    directory, you can't change it using the newer DOS file-access
    functions (3C, 41, 43); instead, use the old FCB-oriented directory
    functions.  Specifically, you need to allocate a 64-byte buffer and
    a 41- byte extended FCB (file control block).  Call INT 21 AH=1A to
    find out whether there is a volume label.  If there is, AL returns 0
    and you can change the label using DOS function 17 or delete it
    using DOS function 13.  If there's no volume label, function 1A will
    return FF and you can create a label via function 16.  Important
    points to notice are that ? wildcards are allowed but * are not; the
    volume label must be space filled not null terminated.

    The following MSC 7.0 code worked for me in DOS 5.0; the functions
    it uses have been around since DOS 2.0.  The function parameter is 0
    for the current disk, 1 for a:, 2 for b:, etc.  It doesn't matter
    what your current directory is; these functions always search the
    root directory for volume labels.  (I didn't try to change the
    volume label of any networked drives.)

    // Requires DOS.H, STDIO.H, STRING.H
    void vollabel(unsigned char drivenum) {
        static unsigned char extfcb[41], dta[64], status, *newlabel;
        int chars_got = 0;
        #define DOS(buff,func) __asm { __asm mov dx,offset buff \
            __asm mov ax,seg buff  __asm push ds  __asm mov ds,ax \
            __asm mov ah,func  __asm int 21h  __asm pop ds \
            __asm mov status,al }
        #define getlabel(buff,prompt) newlabel = buff;  \
            memset(newlabel,' ',11);  printf(prompt);   \
            scanf("%11[^\n]%n", newlabel, &chars_got);  \
            if (chars_got < 11) newlabel[chars_got] = ' ';

        // Set up the 64-byte transfer area used by function 1A.
        DOS(dta, 1Ah)
        // Set up an extended FCB and search for the volume label.
        memset(extfcb, 0, sizeof extfcb);
        extfcb[0] = 0xFF;             // denotes extended FCB
        extfcb[6] = 8;                // volume-label attribute bit
        extfcb[7] = drivenum;         // 1=A, 2=B, etc.; 0=current drive
        memset(&extfcb[8], '?', 11);  // wildcard *.*
        DOS(extfcb,11h)
        if (status == 0) {            // DTA contains volume label's FCB
            printf("volume label is %11.11s\n", &dta[8]);
            getlabel(&dta[0x18], "new label (\"delete\" to delete): ");
            if (chars_got == 0)
                printf("label not changed\n");
            else if (strncmp(newlabel,"delete     ",11) == 0) {
                DOS(dta,13h)
                printf(status ? "label failed\n" : "label deleted\n");
            }
            else {                    // user wants to change label
                DOS(dta,17h)
                printf(status ? "label failed\n" : "label changed\n");
            }
        }
        else {                        // no volume label was found
            printf("disk has no volume label.\n");
            getlabel(&extfcb[8], "new label (<Enter> for none): ");
            if (chars_got > 0) {
                DOS(extfcb,16h)
                printf(status ? "label failed\n" : "label created\n");
            }
        }
    }   // end function vollabel

Q409. How can I get the disk serial number?

    Use INT 21.  AX=6900 gets the serial number; AX=6901 sets it.  See
    Ralf Brown's interrupt list, or page 496 of the July 1992 {PC
    Magazine}, for details.

    This function also gets and sets the volume label, but it's the
    volume label in the boot record, not the volume label that a DIR
    command displays.  See the preceding Q.

Q410. What's the format of .OBJ, .EXE., .COM files?

    Please see section 2, "Compile and link".


section 5. Serial ports (COM ports)
===================================

Q501. How do I set my machine up to use COM3 and COM4?

    Unless your machine is fairly old, it's probably already set up.
    After installing the board that contains the extra COM port(s),
    check the I/O addresses in word 0040:0004 or 0040:0006.  (In DEBUG,
    type "D 40:4 L4" and remember that every word is displayed low
    byte first, so if you see "03 56" the word is 5603.)  If those
    addresses are nonzero, your PC is ready to use the ports and you
    don't need the rest of this answer.

    If the I/O address words in the 0040 segment are zero after you've
    installed the I/O board, you need some code to store these values
    into the BIOS data segment:

        0040:0004  word  I/O address of COM3
        0040:0006  word  I/O address of COM4
        0040:0011  byte (bits 3-1): number of serial ports installed

    The documentation with your I/O board should tell you the port
    addresses.  When you know the proper port addresses, you can add
    code to your program to store them and the number of serial ports
    into the BIOS data area before you open communications.  Or you can
    use DEBUG to create a little program to include in your AUTOEXEC.BAT
    file, using this script:

            n SET_ADDR.COM      <--- or a different name ending in .COM
            a 100
            mov  AX,0040
            mov  DS,AX
            mov  wo [0004],aaaa <--- replace aaaa with COM3 address or 0
            mov  wo [0006],ffff <--- replace ffff with COM4 address or 0
            and  by [0011],f1
            or   by [0011],8    <--- use number of serial ports times 2
            mov  AH,0
            int  21
                                <--- this line must be blank
            rCX
            1f
            rBX
            0
            w
            q

Q502. How do I find the I/O address of a COM port?

    Look in the four words beginning at 0040:0000 for COM1 through COM4.
    (The DEBUG command "D 40:0 L8" will do this.  Remember that words
    are stored and displayed low byte first, so a word value of 03F8
    will be displayed as F8 03.)  If the value is zero, that COM port is
    not installed (or you've got an old BIOS; see the preceding Q).  If
    the value is nonzero, it is the I/O address of the transmit/receive
    register for the COM port.  Each COM port occupies eight consecutive
    I/O addresses (though only seven are used by many chips).

    Here's some C code to find the I/O address:

        unsigned ptSel(unsigned comport) {
            unsigned io_addr;
            if (comport >= 1  &&  comport <= 4) {
                unsigned far *com_addr = (unsigned far *)0x00400000UL;
                io_addr = com_addr[comport-1];
            }
            else
                io_addr = 0;
            return io_addr;
        }

Q503. But aren't the COM ports always at I/O addresses 3F8, 2F8, 3E8,
      and 2E8?

    The first two are usually right (though not always); the last two
    are different on many machines.

Q504. How do I configure a COM port and use it to transmit data?

    After hearing several recommendations, I looked at Joe Campbell's {C
    Programmer's Guide to Serial Communications}, ISBN 0-672-22584-0,
    and agree that it is excellent.  He gives complete details on how
    serial ports work, along with complete programs for doing polled or
    interrupt-driver I/O.  The book is quite thick, and none of it looks
    like filler.

    If Campbell's book is overkill for you, you'll find a good short
    description of serial I/O in {DOS 5: A Developer's Guide}, ISBN
    1-55851-177-6, by Al Williams.

    You may also want to look at an extended example in Borland's
    TechFax TI445, part of PD1:<MSDOS.TURBO-C> at Simtel.  Though
    written by Borland, much of it is applicable to other forms of C,
    and it should give you ideas for other programming languages.

section 6. Other hardware questions and problems
================================================

Q601. Which 80x86 CPU is running my program?

    According to an article posted by Michael Davidson, Intel's approved
    code for distinguishing among 8086, 80286, 80386, and 80486 and for
    detecting the presence of an 80287 or 80387 is published in the
    Intel's 486SX processor manual (order number 240950-001).  You can
    download David Kirschbaum's improved version of this from Simtel as
    PD1:<MSDOS.SYSUTL>CPUID593.ZIP.

    According to an article posted by its author, WCPU041.ZIP knows the
    differences between DX and SX varieties of 386 and 486 chips, and
    can also detect a math coprocessor.  It's in PD1:<MSDOS.SYSUTL> at
    Simtel.

Q602. How can a C program send control codes to my printer?

    If you just fprintf(stdprn, ...), C will translate some of your
    control codes.  The way around this is to reopen the printer in
    binary mode:

        prn = fopen("PRN", "wb");

    You must use a different file handle because stdprn isn't an lvalue.
    By the way, PRN or LPT1 must not be followed by a colon in DOS 5.0.

    There's one special case, Ctrl-Z (ASCII 26), the DOS end-of-file
    character.  If you try to send an ASCII 26 to your printer, DOS
    simply ignores it.  To get around this, you need to reset the
    printer from "cooked" to "raw" mode.  Microsoft C users must use int
    21 function 44, "get/set device information".  Turbo C and Borland
    C++ users can use ioctl to accomplish the same thing:

        ioctl(fileno(prn), 1, ioctl(fileno(prn),0) & 0xFF | 0x20, 0);

    An alternative approach is simply to write the printer output into a
    disk file, then copy the file to the printer with the /B switch.

    A third approach is to bypass DOS functions entirely and use the
    BIOS printer functions at INT 17.  If you also fprintf(stdprn,...)
    in the same program, you'll need to use fflush( ) to synchronize
    fprintf( )'s buffered output with the BIOS's unbuffered.

    By the way, if you've opened the printer in binary mode from a C
    program, remember that outgoing \n won't be translated to carriage
    return/line feed.  Depending on your printer, you may need to send
    explicit \n\r sequences.

Q603. How can I redirect printer output to a file?

    Please see section 4, "Disks and files", for the answer.

Q604. Which video adapter is installed?

    The technique below should work if your BIOS is not too old.  It
    uses three functions from INT 10, the BIOS video interrupt.  (If
    you're using a Borland language, you may not have to do this the
    hard way.  Look for a function called DetectGraph or something
    similar.)

    Set AH=12h, AL=0, BL=32h; INT 10h.  If AL is 12h, you have a VGA.
    If not, set AH=12h, BL=10h; INT 10h.  If BL is 0,1,2,3, you have an
    EGA with 64,128,192,256K memory.  If not, set AH=0Fh; INT 10h.  If
    AL is 7, you have an MDA (original monochrome adapter) or Hercules;
    if not, you have a CGA.

    I've tested this for my VGA and got the right answer; but I can't
    test it for the other equipment types.  Please let me know by email
    at brown@ncoast.org if your results vary.

Q605. How do I switch to 43- or 50-line mode?

    Download PD1:<MSDOS.SCREEN>VIDMODE.ZIP from Simtel or one of the
    mirror sites.  It contains .COM utilities and .ASM source code.

Q606. How can I find the Microsoft mouse position and button status?

    Use INT 33 function 3, described in Ralf Brown's interrupt list.

    The Windows manual says that the Logitech mouse is compatible with
    the Microsoft one, so I assume the interrupt will work the same.

    Also, see the directory PD1:<MSDOS.MOUSE> at Simtel.

Q607. How can I access a specific address in the PC's memory?

    First check the library that came with your compiler.  Many vendors
    have some variant of peek and poke functions; in Turbo Pascal use
    the pseudo-arrays Mem, MemW, and MemL.  As an alternative, you can
    construct a far pointer:  use Ptr in Turbo Pascal, MK_FP in the
    Turbo C family, and FP_OFF and FP_SEG in Microsoft C.

    Caution:  Turbo C and Turbo C++ also have FP_OFF and FP_SEG macros,
    but they can't be used to construct a pointer.  In Borland C++ those
    macros work the same as in Microsoft C, but MK_FP is easier to use.

    By the way, it's not useful to talk about "portable" ways to do
    this.  Any operation that is tied to a specific memory address is
    not likely to work on another kind of machine.

Q608. How can I read or write my PC's CMOS memory?

    There are a great many public-domain utilities that do this.  These
    were available for download from Simtel as of 31 March 1992:

    PD1:<MSDOS.AT>
    CMOS14.ZIP     5965  920817  Saves/restores CMOS to/from file
    CMOSER11.ZIP  28323  910721  386/286 enhanced CMOS setup program
    CMOSRAM.ZIP   76096  920214  Save AT/386/486 CMOS data to file and restore
    ROM2.ARC      20497  900131  Save AT and 386 CMOS data to file and restore
    SETUP21.ARC   24888  880613  Setup program which modifies CMOS RAM
    VIEWCMOS.ARC  15374  900225  Display contents of AT CMOS RAM, w/C source

    At garbo, /pc/ts/tsutle17.zip contains a CMOS program to check and
    display CMOS memory, but not to write to it.

    I have heard good reports of CMOS299.ZIP, available in the pc.dir
    directory of cantva.canterbury.ac.nz [132.181.30.3].

    Of the above, my only experience is with CMOSRAM, which seems to
    work fine.  It contains an excellent (and witty) .DOC file that
    explains the hardware involved and gives specific recommendations
    for preventing disaster or recovering from it.  It's $5 shareware.

    Robert Jourdain's {Programmer's Problem Solver for the IBM PC, XT,
    and AT} has code for accessing the CMOS RAM, according to an article
    posted in this newsgroup.

Q609. How can I access memory beyond 640K?

    I'm outside my expertise on this one, but in late 1992 Jamshid
    Afshar (jamshid@emx.utexas.edu) kindly supplied the following, which
    incorporates some corrections agreed with Duncan Murdoch (dmurdoch@
    mast.queensu.ca).  If you have any corrections or comments, please
    send them to both the above addresses.

    ...........................(begin quote)............................
    1. Use XMS or EMS memory.  XMS is preferable in most cases, but
    some machines won't provide it.  There are some libraries available
    at Simtel to access XMS or EMS.  The disadvantage is that you
    don't allocate the memory as you would with malloc() (or `new' in
    C++).  I believe it also requires that you lock this memory when in
    use.  This means your code is not easily ported to other (and
    future) operating systems and that your code is more convoluted than
    it would be under a "real" os.  The advantage is that the library
    works with compilers since Turbo C 2.0 (I think) and that your
    program will easily run on even 286s.

    2.  Program under MS Windows.  MS Windows functions as a 16-bit DOS
    Extender (see #3).  Borland/Turbo C++ 3.x includes EasyWin [and
    Microsoft C/C++ 7.0 has QuickWin --ed.] which is a library that
    automatically lets you compile your current code using C/C++
    standard input or <conio.h> into a MS Windows program so your code
    can immediately allocate many MBs of memory (Windows enhanced mode
    even does virtual memory).  The disadvantage is that like any 16-bit
    Extender a single malloc() is restricted to 64K (unless you want to
    mess with huge pointers in Windows).  Also, EasyWin's screen output
    is significantly slower than a DOS character-mode program's and you
    must of course run the program from Windows.

    3.  Use a 16-bit or 32-bit DOS Extender.  This is definitely the
    best solution from the programmer's standpoint.  You just allocate
    as much memory as you need using malloc() or 'new'.  A 16-bit
    Extender still has 16-bit ints and restricts arrays to 64K, but a
    32-bit Extender has 32-bits ints (which makes porting a lot of UNIX
    code easier) so there are no 64K limits.  A 32-bit Extender requires
    a 32-bit compiler and the program will not run on 286s.  Some
    Extenders also do virtual memory.  Using an Extender doesn't require
    source code changes and unlike option #1 your code is portable and
    not obsolete in a few months.  Your options for this solution are:

    - Buy PharLap's 16-bit Extender that works with BC++ 3.0+ and MSC
      (just requires a relink).  Note, the BC++ 3.1 upgrade came with
      PharLap "lite".  Pharlap's 32-bit Extender works with 32-bit
      compilers like [?]

    - Get the GNU (free,copylefted) gcc 2.x compiler which DJ Delorie
      ported from UNIX and which uses his 32-bit Extender.  It supports
      C and C++, but the Extender is VCPI which means neither the
      compiler nor programs it produces will run in a DOS session under
      Windows.  FTP to barnacle.erc.clarkson.edu and get
      pub/msdos/djgpp/readme.

    - Get a 32-bit compiler or one that comes with a DOS Extender.
      Zortech comes with 16-bit and a 32-bit Extenders (no debugger for
      32-bit programs, but Flashtek sells one).  Watcom also makes a C
      [and C++?] 32-bit compiler.  [If anyone else has products or plans
      to announce, please let me know.]

    - Buy Borland Pascal 7.0.  It includes a 16 bit royalty-free DOS
      extender using the same interface as MS Windows.  It functions
      under a DPMI server like Windows or QDPMI from Quarterdeck, and
      also provides its own server which you can distribute with your
      programs.

    4.  This option doesn't really count since it's not a solution in
    DOS, but you could switch to a full 32-bit operating system like
    OS/2 2.0 or UNIX (or NT when it comes out).  I believe Win32 will
    allow you to write 32-bit Windows programs.  [can someone fill me in
    on what exactly Win32 is?]
    ............................(end quote).............................


section 7. Other software questions and problems
================================================

Q701. How can a program reboot my PC?

    You can generate a "cold" boot or a "warm" boot.  A cold boot is
    the same as turning the power off and on; a warm boot is the same as
    Ctrl-Alt-Del and skips the power-on self test.

    For a warm boot, store the hex value 1234 in the word at 0040:0072.
    For a cold boot, store 0 in that word.  Then, if you want to live
    dangerously, jump to address FFFF:0000.  Here's C code to do it:

        /* WARNING:  data loss possible */
        void bootme(int want_warm)  /* arg 0 = cold boot, 1 = warm */ {
            void (far* boot)(void) = (void (far*)(void))0xFFFF0000UL;
            unsigned far* type = (unsigned far*)0x00400072UL;
            *type = (want_warm ? 0x1234 : 0);
            (*boot)( );
        }

    What's wrong with that method?  It will boot right away, without
    closing files, flushing disk caches, etc.  If you boot without
    flushing a write-behind disk cache (if one is running), you could
    lose data or even trash your hard drive.

    There are two methods of signaling the cache to flush its buffers:
    (1) simulate a keyboard Ctrl-Alt-Del in the keystroke translation
    function of the BIOS (INT 15 function 4F), and (2) issue a disk
    reset (DOS function 0D).  Most disk-cache programs hook one or both
    of those interrupts, so if you use both methods you'll probably be
    safe.

    When user code simulates a Ctrl-Alt-Del, one or more of the programs
    that have hooked INT 15 function 4F can ask that the key be ignored by
    clearing the carry flag.  For example, HyperDisk does this when it
    has started but not finished a cache flush.  So if the carry flag
    comes back cleared, the boot code has to wait a couple of cluck
    ticks and then try again.  (None of this matters on older machines
    whose BIOS can't support 101- or 102-key keyboards; see "What is the
    SysRq key for?" in section 3, "Keyboard".)

    Here's C code that tries to signal the disk cache (if any) to flush:

        #include <dos.h>
        void bootme(int want_warm)  /* arg 0 = cold boot, 1 = warm */ {
            union REGS reg;
            void    (far* boot)(void) = (void (far*)(void))0xFFFF0000UL;
            unsigned far* boottype    =     (unsigned far*)0x00400072UL;
            char     far* shiftstate  =         (char far*)0x00400017UL;
            unsigned      ticks;
            int           time_to_waste;
            /* Simulate reception of Ctrl-Alt-Del: */
            for (;;) {
                *shiftstate |= 0x0C;    /* turn on Ctrl & Alt */
                reg.x.ax = 0x4F53;      /* 0x53 = Del's scan code */
                reg.x.cflag = 1;        /* sentinel for ignoring key */
                int86(0x15, &reg, &reg);
                /* If carry flag is still set, we've finished. */
                if (reg.x.cflag)
                    break;
                /* Else waste some time before trying again: */
                reg.h.ah = 0;
                int86(0x1A, &reg, &reg);/* system time into CX:DX */
                ticks = reg.x.dx;
                for (time_to_waste = 3;  time_to_waste > 0;  ) {
                    reg.h.ah = 0;
                    int86(0x1A, &reg, &reg);
                    if (ticks != reg.x.dx)
                        ticks = reg.x.dx , --time_to_waste;
                }
            }
            /* Issue a DOS disk reset request: */
            reg.h.ah = 0x0D;
            int86(0x21, &reg, &reg);
            /* Set boot type and boot: */
            *boottype = (want_warm ? 0x1234 : 0);
            (*boot)( );
        }

Q702. How can I time events with finer resolution than the system
      clock's 55 ms (about 18 ticks a second)?

    The following files, among others, can be downloaded from Simtel:

    PD1:<MSDOS.AT>
    ATIM.ARC       5946  881126  Precision program timing for AT

    PD1:<MSDOS.C>
    MILLISEC.ZIP  37734  911205  MSC/asm src for millisecond res timing
    MSCHRT3.ZIP   53708  910605  High-res timer toolbox for MSC 5.1
    MSEC_12.ZIP    8484  920320  High-def millisec timer v1.2 (C,ASM)
    ZTIMER11.ZIP  77625  920428  Microsecond timer for C, C++, ASM

    PD1:<MSDOS.TURBO-C>
    TCHRT3.ZIP    53436  910606  High-res timer toolbox for Turbo C 2.0
    TCTIMER.ARC   20087  891030  High-res timing of events for Turbo C

    PD1:<MSDOS.TURBOPAS>
    BONUS507.ARC 150435  900205  [Turbo Pascal source: high-res timing]

    Pascal users can download source code in /pc/turbopas/bonus507.zip
    at garbo.

Q703. How can I find the error level of the previous program?

    First, which previou