
TP / TPMAC - PC / MACINTOSH PORTABILITY
Q. How portable is the PC version of Turbo Pascal to the 
   Macintosh?
A. Any Portion of the program that is Standard Pascal will port 
   over nicely.  However, the PC and the Macintosh are two
   completely different machines and any PC or Macintosh
   specific code will have to be rewritten.  PC programmers will
   generally want to rewrite the user interface so that is
   similar to what Macintosh users expect to see on a serious
   Macintosh application.


TPMAC 1.0 1.1 - PASPRINTER PRINT WITHIN PROGRAM
Q. How do I print from within a program?
A. Uses PasPrinter and Writeln(Printer, data);

TPMAC 1.0 1.1 READLN WRITELN - THE MISSING SUPPORT UNIT ERROR
Q. I get a runtime error message saying that the support unit
   is missing when I try to use a Readln or Writeln.
A. Take out the {$U-} directive.  It causes the PasConsole and
   PasInOut units to not link in with the program and units.

