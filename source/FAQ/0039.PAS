                          SECTION 16 - OWL/BWCC
                                    
                                    
GENERAL INFORMATION

This document contains information that is most often provided to
user of Section 16 - OWL/BWCC.  There is a listing of common
Technical Information Documents that can be downloaded from the
libraries.  There is also a description of the five questions
most frequently asked in Section 16 - OWL/BWCC and their answers.


TECHNICAL INFORMATION DOCUMENTS

TI1203   Using Validators in OWL Applications
TI1262   Installation notes regarding Turbo Debugger for Windows
TI1171   Borland problem report form
TI607    Description and illustration of printing in Windows
TI992    Demonstration of collections and listboxes in Windows



FREQUENTLY ASKED QUESTIONS

Q:   "Why do I get 'Application Error -1' when my dialog tries to
     execute?"
A:   This is basically a "Failure to create window" error.
     Most often it is caused by one of two things:
     1.  Failure to include "BWCC" in your USES clause.  If you
         designed a dialog in Resource Workshop using the Borland
         "look and feel", you need to include "BWCC" in your USES
         clause.
     2.  Incorrect dialog identifier passed to dialog's Init
         method.  Make sure the identifier you are passing to the
         dialog's Init method is the same one you are using in
         Resource Workshop.

Q:   "How can I obtain the latest copy of BWCC.DLL?"
A:   Download BWCC.ZIP from library 2.

Q:   "What causes the 'Data Segment too large' compiler error?
     How do I get rid of it?"
A:   This error occurs when your application has more than 64K of
     information that it is trying to put into your its data
     segment.  Note that you only have one 64K data segment to
     work with, so you should manage this memory judiciously. 
     The following data is kept in an Object Windows 
     application's data segment:
          * All global variables
          * All typed constants
          * Stack
          * Local Heap (used internally by Windows)
          * Virtual Method Table

     To avoid this error, you should take the following steps:
          * Avoid large global variables.  Try instead declaring
            larger variables on the heap using New() or GetMem(),
            and keeping a pointer to that variable globally.
          * Avoid frequent use of string literals and variables
            in your application.  Instead, keep your strings in a
            resource and use the LoadString API function to load
            them into memory.
          * Keep your stack down to a reasonable size.  8K is
            usually a good amount for most applications.
          * Avoid making functions in your objects Virtual unless
            they have to be; this will reduce the size of the
            Virtual Method Table.


Q:   "How can I enable or disable a particular control in a
     dialog box?
A:   Use the EnableWindow(Wnd: Hwnd, Enable: Bool) API function. 
     It takes two parameters, the handle to the window (remember
     a control is a window) to be enabled/disabled and a boolean
     value - True for enable and False for disable.

Q:   "How do I obtain the handle or ID of a control?" 
A:   If you have a pointer to a control object, OWL will give you
     the window handle automatically through the HWindow field;  
     PointerToMyControl^.HWindow is the window handle.

     If you know the handle of a control, you can obtain the ID
     by calling the GetDlgCtrlID() API function:
        ControlID := GetDlgCtrlID(ControlHandle);

     If you don't have a pointer to your control, but know the ID
     of a control, you can obtain the handle by calling the
     GetDlgItem() API function:

        ControlHandle := GetDlgItem(DialogHandle, ControlID);
   
Q:   "How can I put Object Windows objects in a DLL?"
A:   OWL was not designed to be used in a DLL.  Some users have
     managed to get this to work in some cases, but it is not a
     practice that Borland recommends.  For info on launching 
     windows and dialogs from a DLL without OWL, download
     APIDLL.PAS from library 2.

Q:   "Can a TFileWindow object edit files larger than 64K?"
A:   No.  A TFileWindow is really just a multi-line edit control
     that takes up the whole client area.  An edit control's
     buffer is allocated from the local heap, and therefore is 
     usually much smaller than 32K.  If you would like to have 
     more buffer space, download GLBEDT.ZIP from library 8 - this 
     file provides you with a greater buffer for the TEdit and
     TFileWindow objects.

Q:   "How do I apply to become a beta tester for a future Borland
     Pascal product?"
A:   Download SURVEY.ZIP from library 2.
    
