

TITLE: TRUBO PASCAL OVERLAY ISSUES
===========================================================

TP 5.0 5.5 - OVERLAY SUPPORT
Q. Are overlays supported in 5.0+?
A. Yes! See the example program OVRDEMO.PAS and refer to the
   Turbo Pascal manual for information on overlays.

TP 5.0 5.5 - OVERLAY UNITS LOADED INTO BUFFER
Q. Is there any way to determine what overlay units are loaded
   into the overlay buffer?
A. Using Turbo Pascal 5.0+, there is no defined method for
   determining which units are loaded into the overlay buffer
   area. 

TP 5.0 5.5 - OVERLAYS *.OVR FILES
Q. How can I transfer a large overlay file onto a floppy disk?
A. If the file does not fit on a single density disk, then
   transfer it to a double density disk.  In the latter case,
   your application will run only from the double density disk or
   a hard disk.

TP5.5 OVERLAY
Q. How do I reclaim the memory used by overlay buffer in TP5.5?

A. The following example demonstrates how to do so.

unit Marker;

interface

procedure RestoreHeap; procedure RestoreOverlay;

implementation

var OldHeapPtr,OldHeapOrg,Temp:pointer;

var OldHeapPtr,OldHeapOrg,Temp:pointer;

procedure RestoreHeap; begin
  Release(Temp);                {2. Release all dynamic variables}
  OldHeapOrg:=HeapOrg;          {3. Save Current Heap state }
  OldHeapPtr:=HeapPtr;
  HeapOrg:=ptr(OvrHeapOrg,$0);  {4. Set Heap to Origin of Overlay Buffer}
  HeapPtr:=HeapOrg;
  Mark(Temp);                   {5. Mark the origin of this heap } end;

procedure RestoreOverlay; begin
  Release(Temp);                {6. Release all dynamic variables }
  HeapOrg:=OldHeapOrg;          {7. Restore heap pointers }
  HeapPtr:=OldHeapPtr; end;

begin
  mark(temp);  {1. Mark the beginning of heap after overlay buffer} end.
end.

The unit is to be used before any unit that places items into the heap during
their initialization.  You would call RESTOREHEAP before using the dynamic
variables requiring memory used by the overlay buffer.  A call to OVRCLEARBUF
must come before any call to RESTOREHEAP to ensure that the overlay buffer 
is empty and to force a reload of overlays when you are done.  Note, that all 
dynamic variables residing on the heap, before a RESTOREHEAP call is made, are
lost. (But, you could code around this by manipulating the free list).

RESTOREOVERLAY clears the heap again and restores the heap pointers to point
above the overlay buffer.  You may then start using overlaid procedures and
functions again.

This is a simple example and may not be suitable for all purposes.




