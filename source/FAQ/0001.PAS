        ANSWERS TO FREQUENTLY ASKED PASCAL QUESTIONS
        ============================================

1...
                                                                              
  Q. How do I pass an error level code when my program finishes?              
                                                                              
  A. The halt procedure takes an optional parameter of type word. Thus -      
                                                                              
         halt(1);                                                             
                                                                              
     terminates the program with an errorlevel of 1.  If halt is used without 
     a parameter it is the same as -                                          
                                                                              
         halt(0);                                                             
                                                                              
     Note:  When a program is terminated using the halt procedure any exit    
            procedure that has previously been set up is executed.            


2...
                                                                          
  Q. How do I empty the keyboard buffer?                                      
                                                                              
  A. There are several ways that this can be achieved.  However the safest    
     is -                                                                     
                                                                              
        while Keypressed do ch := ReadKey;                                    
                                                                              
     This requires that a variable ch of type char is declared and the crt    
     unit be used.  To do it without using a variable -                       
                                                                              
       while Keypressed do while ReadKey = #0 do;                             
                                                                              
     or if using TP6 with extended syntax enabled -                           
                                                                              
        while KeyPressed do ReadKey;                                          
                                                                              
     If you do not wish to incur the substantial overhead involved with the   
     use of the CRT unit and there is no requirement for the program to run   
     under a multi-tasker -                                                   
                                                                              
        var                                                                   
          head : byte absolute $40:$1c;                                       
          tail : byte absolute $40:$1e;                                       
                                                                              
        tail := head;                                                         

3...

  Q. When I redirect the screen output of my programs to a file the file is   
     empty and the output still appears on the screen. What am I doing        
     wrong?                                                                   
                                                                              
  A. You are probably using the CRT unit and its default method of writing    
     to stdout is by direct screen writes.  In order to enable output to be   
     redirected all writes must be done by DOS.  Setting the variable         
     DirectVideo to false has no effect on redirection as all it does is use  
     the BIOS for screen writes - not DOS.                                    
                                                                              
     To enable redirection you must not use the CRT unit                      
                                                                              
     OR                                                                       
                                                                              
     assign(output,'');                                                       
     rewrite(output);                                                         
                                                                              
     This will make all output go through DOS and thus can be redirected if   
     desired.  To restore the default situation -                             
                                                                              
     AssignCRT(output); rewrite(output);                                      


4...

   Q. How do I make a string that is lower or mixed case all uppercase?
                                                                              
   A. There are several ways to convert lower case characters to upper case.  
      Here are some of them.                                                  
                                                                              
      As a procedure (excluding asm code this is the fastest way)             
                                                                              
        procedure StrUpper(var st: string);                                   
          var x : byte;                                                       
          begin                                                               
            for x := 1 to length(st) do                                       
              st[x] := UpCase(st[x]);                                         
          end;                                                                
                                                                              
      As a function (slower but sometimes more convenient) -                  
                                                                              
        function StrUpper(st: string): string;                                
          var x : byte;                                                       
          begin                                                               
            StrUpper[0] := st[0];                                             
            for x := 1 to length(st) do                                       
              StrUpper[x] := UpCase(st[x]);                                   
          end;                                                                
                                                                              
      Both the above are suitable for the English language .  However from    
      version 4.0 onwards, DOS has had the facility to do this in a way that  
      is country (language) specific.  I am indebted to Norbert Igl for the   
      basic routine.  I have modified his code slightly.  For the anti-goto   
      purists this is a good example of a goto that is convenient, efficient, 
      self-documenting and structured.  The dos calls would make this method  
      the slowest of all.                                                     
                                                                              
     function StrUpper(s: string): string;                                    
       { Country specific string-to-uppercase conversion. Requires DOS unit } 
       label                                                                  
         fail;                                                                
       var                                                                    
         regs : registers;                                                    
         x    : byte;                                                         
       begin                                                                  
         if lo(DosVersion) >= 4 then begin                                    
           with regs do begin                                                 
             ax := $6521;                                                     
             ds := seg(s);                                                    
             dx := ofs(s[1]);                                                 
             cx := length(s);                                                 
             msdos(regs);                                                     
             if odd(flags) then { the attempted conversion failed so }        
               goto fail;                                                     
           end; { with }                                                      
         end { if DOS >= 4.0 } else                                           
       fail:                                                                  
           for x := 1 to length(s) do                                         
             s[x] := UpCase(s[x]);                                            
         StrUpper := s;                                                       
       end; { StrUpper }                                                      



5...
                                                                              
   Q. When I include ANSI codes in a string and write that string to the      
      screen the actual codes appear on the screen, rather than the results   
      they are supposed to achieve.                                           
                                                                              
   A. In order for ANSI codes to be interpreted, screen writes must be        
      directed through DOS and there must have been a suitable driver loaded  
      via the config.sys file at boot time.  All output can be directed       
      through DOS and the driver by -                                         
                                                                              
      Not using the crt unit                                                  
                                                                              
      OR -                                                                    
                                                                              
      assign(output,'');                                                      
      rewrite(output);                                                        
                                                                              
      in which case ALL screen writes are "ANSI code sensitive"               
                                                                              
      OR -                                                                    
                                                                              
      You can set up write procedures that will be "ANSI code sensitive".     
      (You will need an initialisation procedure to set this up.)             
                                                                              
      var                                                                     
        ansi : text;                                                          
                                                                              
      procedure AssignANSI(var ansifile : text);                              
        begin                                                                 
          assign(ansifile,'CON');                                             
          rewrite(ansifile);                                                  
        end; { AssignANSI }                                                   
                                                                              
      procedure WriteANSI(var st: string);                                    
        begin                                                                 
          write(ansi,st)                                                      
        end; { WriteANSI }                                                    
                                                                              
      procedure WriteLnANSI(var st: string);                                  
        begin                                                                 
          writeANSI(st);                                                      
          writeln(ansi);                                                      
        end; { WriteANSI }                                                    
                                                                              
      ObviousLy, if the ANSI.SYS driver (or an equivalent) is not installed   
      none of the above can work.                                             
                                                                              
      Setting the variable DirectVideo in the CRT unit to false will not      
      achieve the desired result as this merely turns off direct screen       
      writes and uses the BIOS for all screen output.                         


6...
                                                                              
   Q. When I try to shell to DOS nothing happens. What am I doing wrong?      
                                                                              
   A. In order to be able to execute any child process there must be          
      sufficient memory available for it to load and execute.  Unless you     
      advise differently at compile time, a Turbo Pascal program grabs all    
      available memory for itself when it is loaded.  To reserve memory for a 
      child process use the compiler memory directive -                       
                                                                              
        {$M 16384,0,0)                                                        
      the default is -                                                        
        {$M 16384,0,655360}                                                   
                                                                              
      The first figure - StackMin - is the amount of memory to be allocated   
      for the stack:                                                          
                                                                              
      Minimum is:    1024                                                     
      Default is:   16384                                                     
      Maximum is:   65520                                                     
                                                                              
      The next figure - HeapMin -is the minumum amount of memory to be        
      allocated for the heap. If there is less memory available than this     
      figure the program will not load.                                       
                                                                              
      Minimum is:          0                                                  
      Default is:          0                                                  
      Maximum is:     655360  In practice it will be the amount of free       
                              memory less the space required for the stack,   
                              less the code space of the program.  You should 
                              set this to 0 unless your program uses the      
                              heap.  In that case, set it to the lowest       
                              possible figure to prevent heap allocation      
                              errors.  In most cases it is best to leave it   
                              at zero and do error checking within the        
                              program for sufficient memory at allocation     
                              time.                                           
                                                                              
      The last figure is the crucial on as regards child processes.  It       
      should always be low enough to leave memory left over for a child       
      process and high enough not to cause problems for the program when      
      allocating heap memory.                                                 
                                                                              
      Minimum is:  HeapMin                                                    
      Default is:  655360                                                     
      Maximum is:  655360     If less than the requested amount is available  
                              no error is reorted.  Instead all available     
                              memory is allocated for heap use.               



7...
                                                                              
   Q. How do I shell to DOS?                                                  
                                                                              
   A. SwapVectors;                                                            
      exec(GetEnv('COMSPEC','');                                              
      SwapVectors;                                                            
                                                                              
      Read previous section on memory allocation.                             
                                                                              
      I find that it is a good idea to write my own Exec function which will  
      do everything that is needed for me.  I have it return an integer value 
      that is the DosError code.                                              
                                                                              
      function Exec(p1,p2: string);                                           
        begin                                                                 
          SwapVectors;                                                        
          Dos.Exec(p1,p2);                                                    
          SwapVectors;                                                        
          Exec := DosError;                                                   
        end;                                                                  
                                                                              
      This enables me to have a statement such as -                           
                                                                              
      ReportError(Exec(GetEnv('COMPSEC'),''));                                
                                                                              
      Now you can have an empty ReportError procedure or you can make it      
      report the error - whatever is suitable for you application.            


8...
                                                                              
   Q. When I execute a child process redirection does not work. Why?          
                                                                              
   A. Redirection of a child process's output only works if it is run under   
      another copy of the command processor.  So -                            
                                                                              
      exec('YourProg.exe',' > nul');    will not work but                     
      exec(GetEnv('COMSPEC'),'/c YourProg > nul'); will work.                 


9...

   Q. How do I read an errorlevel from a child process?

   A. After executing a child process the errorlevel returned can be read
      by calling the DosExitCode function which returns a word.  The low
      byte is the errorlevel.  A full description is in the manual.

      If the command interpreter is the child process and it in turn
      executes a child process then the errorlevel of the second child
      process cannot be read without resorting to some trickery.


10...

   Q. When I read a text file that has lines exceeding 255 characters I
      lose all those characters from the 256th one on each time there is a
      line that exceeds that length.  How can I prevent this?

   A. Turbo Pascal's readln procedure reads a line up to the 255th
      character then skips to the next line.  To get around this you
      should declare a buffer at least as large as the longest possible
      line and then use the read procedure.  The best size for the buffer
      is a multiple of 2048 bytes.

      const
        BufferSize = 2048;
        LineLength = 78;
      type
        textbuffer = array[1..BufferSize] of char;
      var
        st          : string;
        f           : text;
        buffer      : textbuffer;

      function ReadTxtLn(var tf: text; var s: string; max: byte): integer;
        { Reads a string of a maximum length from a text file }
        var
          len         : byte absolute s;
        begin
          len := 0;
          {$I-}
          while (len < max) and not eoln(tf) do begin
            inc(len);
            read(tf);
          end;
          if eoln(tf) then
            readln(tf);
          ReadTxtLn := IOResult;
          {$I+}
        end; { ReadTxtLn }

      begin
        assign(f,filename);
        reset(f);
        SetTextBuf(f,buffer);
        while not eof(f) and (ReadTxtLn(f,st,LineLength) = 0) do
          writeln(st);
        close(f);
      end.


11...

   Q. How do I convert nul terminated asciiz strings to Turbo Pascal
      strings?

   A. Here is a function that will do that -

      function Asc2Str(var s; max: byte): string;
        { Converts an ASCIIZ string to a Turbo Pascal string }
        { with a maximum length of max.                      }
        var starray  : array[1..255] of char absolute s;
            len      : integer;
        begin
          len        := pos(#0,starray)-1;              { Get the length }
          if (len > max) or (len < 0) then      { length exceeds maximum }
            len      := max;                         { so set to maximum }
          Asc2Str    := starray;
          Asc2Str[0] := chr(len);                           { Set length }
        end;  { Asc2Str }


12...

   Q. How can I tell if a particular bit of a variable is set or not? How can
      I set it?  How can I turn it off? How can I make a large bit map and
      then determine if a particular bit - say bit 10000 is on/of?

   A. This question, or a variation of it, is one of the most commonly asked
      questions in the echo and there are several ways of doing what is
      wanted.  None are necessarily right or wrong.  The way I will describe
      is designed to take up as little code/data space as possible.  I do not
      attempt to explain the theory behind these functions as this can be
      obtained from any good book. Question 16 also contains valuable extra
      help on the subject of truth tables.

      The use of sets can be the best bit manipulation method if you have
      control over the data being used. Here is an example of a byte variable
      for a BBS program which sets various user access level flags.

         Bit 0 = Registered User
             1 = Twit
             2 = Normal
             3 = Extra
             4 = Privileged
             5 = Visiting Sysop
             6 = Assistant Sysop
             7 = Sysop

       type
         status_type  = (Registered,
                         Twit,
                         Normal,
                         Extra,
                         Privileged,
                         VisitingSysop,
                         AssistantSysop,
                         Sysop);
          status_level = set of status_type;

       var
         access_flags  : status_level;

      Let us assume you have someone who logs on and you wish to determine
      his user access level.  After reading access_flags from the user data
      file -

           if Sysop in access_flags then ....

      To set the sysop flag -

           access_flags := access_flags + [Sysop];

      To reset the sysop flag -

           access_flags := access_flags - [Sysop];

      However on many occasions using a set may not be a suitable method.
      You may simply need to know if bit 5 is set or not.  Here is the method
      that I consider the best -

        function BitIsSet(var V,  bit: byte): boolean;
          begin
            BitIsSet := odd(V shr bit);
          end;

      To set a bit -

         procedure SetBit(var V: byte; bit: byte);
           begin
             V := V or (1 shl bit);
           end;

      To reset a bit -

         procedure ResetBit(var V: byte; bit: byte);
           begin
             V := V and not(1 shl bit);
           end;

      To toggle (flip) a bit -

         procedure ToggleBit(var V: byte; bit: byte);
           begin
             V := V xor (1 shl bit);
           end;

      Now a bit map can be made up from an array of bytes.  If stored on the
      heap you can test any bit up to number 524159 (zero based).  Here's
      how.

      type
        map = array[0..maxsize] of byte;
        { set maxsize to number of bits div 8 -1 needed in the bit map }

      function BitSetInBitMap(var x; numb : longint): boolean;
        { Tests the numb bit in the bitmap array }
        var m: map absolute x;
        begin
          BitSetInBitMap := odd(m[numb shr 3] shr (numb and 7));
        end;

      procedure SetBitInBitMap(var x; numb: word);
        { Sets the numb bit in the bitmap array }
        var m: map absolute x;
        begin
          m[numb shr 3] := m[numb shr 3] or (1 shl (numb and 7))
        end;

      procedure ResetBitInBitMap(var x; numb : longint);
        { Resets the numb bit in the bitmap array }
        var m: map absolute x;
        begin
         m[numb shr 3] := m[numb shr 3] and not(1 shl (numb and 7));
        end;

      procedure ToggleBitInBitMap(var x; numb : longint);
        { Toggles (flips) the numb bit in the bitmap array }
        var m: map absolute x;
        begin
          m[numb shr 3] := m[numb shr 3] xor (1 shl (numb and 7));
        end;


13...

   Q. How can I find a particular string in any file - text or binary?

   A. The Boyer-Moore string search algorithm is considered to be the fastest
      method available.  However in a rare worst-case scenario it can be
      slightly slower than a linear brute-force method.  The following
      demonstration program will show how it works and could easily be
      modified to allow for command line paramters etc.


      program BMSearchDemo;

      type
        bigarray = array[0..32767] of byte;
        baptr    = ^bigarray;
        BMTable  = array[0..255] of byte;

      const
        KeyStr : string = 'Put whatever you want found here';
        fname  : string = 'f:\Filename.txt';

      var
        Btable : BMtable;
        buffer : baptr;
        f      : file;
        result,
        position : word;
        offset : longint;
        finished,
        Strfound  : boolean;

      procedure MakeBMTable(var t : BMtable; var s);
        { Makes a Boyer-Moore search table. s = the search string t = the table }
        var
          st  : BMtable absolute s;
          slen: byte absolute s;
          x   : byte;
        begin
          FillChar(t,sizeof(t),slen);
          for x := slen downto 1 do
            if (t[st[x]] = slen) then
              t[st[x]] := slen - x
        end;

      function BMSearch(var buff,st; size : word): word;
        { Not quite a standard Boyer-Moore algorithm search routine }
        { To use:  pass buff as a dereferenced pointer to the buffer}
        {          st is the string being searched for              }
        {          size is the size of the buffer                   }
        { If st is not found, returns $ffff                         }
        var
          buffer : bigarray absolute buff;
          s      : array[0..255] of byte absolute st;
          len    : byte absolute st;
          s1     : string absolute st;
          s2     : string;
          count,
          x      : word;
          found  : boolean;
        begin
          s2[0] := chr(len);       { sets the length to that of the search string }
          found := false;
          count := pred(len);
          while (not found) and (count < (size - len)) do begin
            if (buffer[count] = s[len]) then { there is a partial match } begin
              if buffer[count-pred(len)] = s[1] then { less partial! } begin
                move(buffer[count-pred(len)],s2[1],len);
                found := s1 = s2;                   { if = it is a complete match }
                BMSearch := count - pred(len);      { will stick unless not found }
              end;
              inc(count);                { bump by one char - match is irrelevant }
            end
            else
              inc(count,Btable[buffer[count]]);   { no match so increment maximum }
          end;
          if not found then
            BMSearch := $ffff;
        end;  { BMSearch }


      begin
        new(buffer);
        assign(f,fname);
        reset(f,1);
        offset := 0;
        MakeBMTable(Btable,KeyStr);
        repeat
          BlockRead(f,buffer^,sizeof(buffer^),result);
          position := BMSearch(buffer^,KeyStr,result);
          finished := (result < sizeof(buffer^)) or (position <> $ffff);
          if position = $ffff then
            inc(offset,result);
          Strfound := position <> $ffff;
        until finished;
        close(f);
        if Strfound then
          writeln('Found at offset ',offset)
        else
          writeln('Not found');
      end.

14...

   Q. How can I put a apostrophe in a string?

   A. Just put in extra apostrophes.  If you want st to be equal to the
      string -
        The word 'quoted' is in quotes
      do this -
        st := 'The word ''quoted'' is in quotes';

      if you want the following to be written to screen -
        'This is a quoted string'
      do this -
        writeln('''This is a quoted string''');


15...

   Q. What are the best books to purchase to help me learn Turbo Pascal?

   A. There are many good books for learners.  Here are a few -

      Complete Turbo Pascal - Third Edition - Jeff Duntemann
      Mastering Turbo Pascal 6 - Tom Swann
      Turbo Pascal - The Complete Reference - O'Brien.

      For advanced users there are also many good books.  Here are a few
      that I have found useful - (Those marked with an asterisk are not
      purely for Turbo Pascal)

      Turbo Pascal 6 - Techniques and Utilities - Rubenking
      Turbo Pascal Internals - Tischer
      * PC System Programming for Developers - Tischer
      * Undocumented DOS - Schulman

      Any learner would be well advised to obtain a well known library
      such as Technojock's Turbo Toolkit (TTT) which is shareware and
      study the source code.

 16.

   Q. hat are "truth tables" and how do they work?

   A. Truth tables are a set of rules that are used to determine the result of
      logical operations.  The logical operators are -

        NOT
        AND
        OR
        XOR.

      Here is a brief explanation of truth tables.  When two values are
      logically compared by using a logical operator each bit of one value is
      directly compared to the corresponding bit in the other value and the
      same bit in the returned value is set or reset according to the
      following truth table.

             NOT         AND             OR            XOR
         not 1 = 0    0 and 0 = 0    0 or 0 = 0    0 xor 0 = 0
         not 0 = 1    0 and 1 = 0    0 or 1 = 1    0 xor 1 = 1
                      1 and 0 = 0    1 or 0 = 1    1 xor 0 = 1
                      1 and 1 = 1    1 or 1 = 1    1 xor 1 = 0

      NOT reverses the bit.
      AND sets the returned bit if both compared bits are set.
      OR  sets the returned bit if either of the compared bits are set.
      XOR sets the returned bit if the compared bits are not the same.


 17.

   Q. What are pointers and how can I use them?  I have heard that they are
      variables that can be created and discarded as required thus saving
      memory.  Is this true?

   A. A pointer is a variable that contains a memory address.

      The heap is all of that memory allocated by DOS to a program for its
      use that has not been used by the program for its code, global data or
      stack.

      Dynamic variables are variables that have had space allocated for them
      on the heap.

      Dynamic variables have no identifier (are unnamed).  Because of this
      they need an associated variable that can be used to find where they
      reside in memory. Pointers are ideal for this but need some method to
      define what type of data it is that they are pointing at.  Pascal
      provides this method.

        type
          Str10Ptr = ^string[10];
          { This means Str10Ptr is a pointer that points to data of type }
          { string[10].                                                  }
        var
          S : Str10Ptr;

      In the above example S is a pointer that has been defined as pointing
      to an address in memory that will contain (or should contain) data of
      type string[10].

      However how does S get this value?  How does it know where that data's
      address is supposed to be?  Well until the programmer allocates memory
      for that data S's value is undefined, so it could be literally
      pointing anywhere. So it is *vital* that before we try to use it to
      use/assign data from/to that memory location we give S a memory
      address that is not being used for any other purpose at the moment and
      that is big enough to hold the data that we want to place into it - in
      this case at least 11 bytes.  We do this by -

        new(S);

      Pascal has now allocated at least 11 bytes of heap and has allocated S
      with the address of the FIRST byte of that allocation.

      Ok... so far so good! How do we access that data (remembering that it
      has no name).  Well we "dereference" the pointer. This is done by
      placing a carat sign immediately following the pointer's identifier.

        S^ := 'Joe Bloggs';

      This statement actually means "Place the string 'Joe Bloggs' into the
      memory address that S contains". This is referred to as "derferencing"
      the pointer S.

      To "reference" a dynamic variable we "dereference" its associated
      pointer variable.  We cannot say -

        S := 'Joe Bloggs';

      because S is a pointer and that would be trying to give a pointer a
      string type value - a compiler "type mismatch" would occur. So every
      time we wish to access that dynamic variable we dereference it.

      To delete the dynamic variable once it is of no further use is just a
      matter of -

        dispose(S);

      What this statement does is release the memory previously used by S^
      and make it available to be used for other purposes by the program.
      Depending on the version of Pascal you are using it may not erase or
      alter the contents of that memory and it may not give S a new value.
      However any attempt to dereference S is an error as the integrity of
      that memory location has been lost - it may have been allocated to
      other data.

      Pointers do not *have* to point to a memory location in the heap or
      even have their value always allocated by using the New procedure. Any
      valid memory address can be assigned to them and then they can be
      dereferenced as shown above.  As a simple example of this lets say you
      want to examine the contents of the 16 byte area at $40:$f0 (the ICA
      area). You could - (TP specific)

         type
           ICA_Ptr = ^array[0..15] of byte;
         var
           B       : byte;
           ICA     : ICA_Ptr;

          ICA := ptr($40,$f0);

      Now ICA points to the address specified and you can dereference it -

          B := ICA^[10];

      Hope that helps get you started into the complex world of memory
      management and manipulation using pointers.  There are countless
      permutations and methods that can be used.


 18.

   Q. How do I do word wrap?

   A. The demo program WRAP.PAS in this archive demonstrates both word wrap
      and the justifying of text.










