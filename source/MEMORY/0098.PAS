
PLEASE NOTE :
       This is a LARGE project of the type not normally included in SWAG
       However, we feel that this work is very important and relevant, and
       with Harry's permission, we include it here.  To get the ZIP file
       FLATMEM.ZIP, cut out the XX3402 code at the end of this document,
       and use XX3402 to decode it.

       Swag Support Team.


Documentation on: FlatMem, BASM32 and XMS30.
============================================

Most of the units do have internal documentation. I will here only give
the quick and dirty info - i.e. the least you need to know in order to use
them. If you get confused by detail, skip directly to "Conclusion"...

Limitation:
----------

No Windows(TM), no EMM386, no QEMM. ONLY Himem.SYS must be loaded as memory
manegement. Any of the Borland 7.0 compilers can be used. ONLY Turbo.EXE
and TD.EXE can be used to run/debug this code.

FlatMem & XMS30:
---------------

FlatMem is a unit with which to access all memory, up to 4G, with pascal.
The result is however not entirely seamless. This unit creates and assigns
the GS segment register, a 32-bit segment, with base address 00000h.
This means that any 16-bit seg:ofs pair can be accessed as an offset equal
to seg*16+ofs, using GS as segment register. If this sounds too complicated,
there are routines to read or write bytes, words, integers, longint, real,
extended and strings, to and from an absolute address.

An absolute address (also linear-,physical-address) is a longint. To get
this value for any DOS-pointer, use the function AbsAddr(pointer).

Although FlatMem can function without XMS30, and XMS30 without FlatMem,
you will want to use the two in concert. To allocate/free memory from the
XMS-heap, you can use GetMemXMS and FreeMemXMS.

To read or write to memory allocated with XMS30, you can do it in one of two
possible ways. If you only use XMS30, you will have to shuttle the area
which you want to access, to and from DOS memory. For this you can use
DOS2XMS, and XMS2DDOS. The data can then be accessed in DOS memory, in the
conventional pascal way.

To read or write directly to XMS-memory, you will have to use FlatMem.
Since accessing this memory directly implies that you know exactly where
the data resides, you will have to "lock" it. Incedently, LockXMS returns
the absolute address for us to be used directly in these routines:
putbyte, getbyte, putword, getword...ect.
The last thing to remember about locking memory, is that it must be unlocked
before it can be freed.


BASM32:
------

I you REALLY want to access XMS directly from within an ASM...END block,
this is it.

The Build in Assembler for BP can only handle '286 code at the most. It does
however allow us to include operation codes as data, right inside the code,
with which we can construct 32-bit codes. The least of the 32-bit code you
would want to use is indexed read and writes:
mov EAX, GS:[ESI]    ....1
mov GS:[ESI],EAX     ....2
Since I set up GS to the 32-bit segment, we will always want to override the
default segment with GS.

Most of the 32-bit instructions are only extentions of their 16-bit versions.
You can in most cases extend an instruction to cover 32-bits of data, by
merely preceding it with a $66(USE32). This constant (and others) are
defined in BASM32. To overrige the default segment with GS, use GSEG.
To make the indexing register also 32-bit, use INDEX32.

Example 1 can now be encoded in the following way:

   db USE32, GSEG, INDEX32, _read, _AX+_iSI

Notice the sequence of the constants. This order of use is NOT open to
negotiation. You MUST use them in this order.

A very complex statment could be:

   add GS:[EBX+ESI+0200h],ECX

which becomes:

   db USE32, GSEG, INDEX32, _add2mem, _iBX_iSI + _CX + _DWORD; dd 00000200

There are only made provision for the following types of instructions,
reading from memory into a register: _read
writing from a register to memory:  _write
adding a value in memory to a register: _add2reg
adding a value in a register to memory: _add2mem
substracting a value in memory with one in register: _sub2mem
substracting a value in a register with one in memory: _sub2reg.

!!!!IMPORTANT WARNING!!!!:

ALWAY CHECK THE CODE WITH AN UNASSEMBLER TO SEE IF YOU DID SAY WHAT
YOU WANTED TO.
There are NO checking done on code entered this way - NONE. I got a runtime
error once, when I didn't:
"The memory manager stoped this process since it wanted to write to an area
used by DoubleSpace. Continueing may result in the loss of ALL information
on your hard disk."
I was lucky - once. now I always check. Turbo debug is excelent to do
this with.

--------------
In Conclusion:
--------------

You can access XMS very easy, if you follow this few simple steps:

Include FLATMEM, XMS30 in the "uses"-clause of your program.

Define the neccesary variables:
   var
      my_XMS_var:word;
      my_XMS_var_addr:longint;

   const
      a_longint_amount:longint=1024;

To Allocate XMS, use:
   my_XMS_var:=GETMEMXMS(a_longint_amount);
   my_XMS_var_addr:=LOCKXMS(my_XMS_var);

To access it as a string:

   PUTSTR('Hallo World',my_XMS_var_addr);
   WRITELN(GETSTR(my_XMS_var_addr));

To free it:
   UNLOCK(my_XMS_var);
   FREEMEMXMS(my_XMS_var);

...and that's it.

One last remark. Suppose you want to access my_XMS_var as an
array[1..4]:string, and you want to read/write the n'th string, use:
   my_XMS_var_addr+(n-1)*length(string)
as arguement for PUTSTR and GETSTR.


DISCLAIMER:
----------
I nor anybody else can take ANY responsibility for ANY damage done,
resulting from, or linked to, the use of this code.
(enough CYA-ness for me :-)

If you do find a bug that bytes you, do tell me. I'll try to fix it.


BYE
---

You can reach me at:

marxh@alpha.unisa.ac.za
or on the pascal discussion list: PASCAL-L@vm.ege.edu.tr

Harry Marx.
Dept. Computer Services (Library System Development)
UNISA
0003
South Africa

{ ----------------------   XX3402 code for FLATMEM.ZIP ------------- }
{  cut this to a file : FLATMEM.XX and use XX3402 to decode it       }

*XX3402-023714-280896--72--85-33713-----FLATMEM.ZIP--1-OF--6
I2g1--E++++6+6du7+1I8nFIZ+2++Bg-+++9++++FYl-J2p3HGtDEYdJYAxf2o2IlvynqKuX
KRaGV3dIQ0XFxdF0TlowRH3f11Eaa3405Yc94NeGB7-BOGYSJ-+K9Fe1-0oxpDV5a4CIDEE0
UbXlu2rfLm+8PhyEEib+TBvXytrrtgowjc06f8kqeeJeoWtYLMw1i08quagpPfhiePdK8RIt
jpyeiyLO7dx9nfvnMZUuqhtBb0aQwY8Y9fQpM3qZvxyoMn-j9RgWuqFLV3AIygpQmbbuRVGr
bo+9gJPPlAV8mVOqfj-N4RDEFxXDRVV48borRmzzMZy52KUDaqA+CpRkF9cUQjDd-o0l4GId
YfaH2GRroBUHbcuZ1bhxy+kAg5VDTiqvFfDN-ENvruLpgGQzzR+ZAmNVgL4CjPuw3UG+IXyQ
dx+TutXkfZiUouRCRCX2mPa69gDUfwlHQtBNYvrT4kWXCs4LjoV7z3T86tfYXmny4rkvK6+j
-TBrO3yCAwrb0XA8Wkcr3168SEJ-uCw8RhGlEBycomDc4Gdp1VDEkUXIGDgMldO8N9RSsGe4
uwi-+TwGRGYzdu94AJ-9+kEI++++0+0rGUkV3M5g9tM7+++A7+++0k+++2NAEJFBFIoiI23H
rJdhPxd83jtSeTzVT2-eefV+62oXcdJ0UgZZ3R7gGPSgeWcOv+5aljNsDICHr0XzTQyNgQ2q
VflgDpEL7N9lbBTbCKQwba2F0ErxUCYV1szSjbZsykOitY6-zX46aT7M+09GD7YmXsCKk7HW
sGHU0LXGtnU4zTDipR+RpfiXcEAgwh220tH2wIUn2GZEAiFKajExXmg3sy46R-Yc2QNYvNPR
Utun0B-A5IoABAG7z0ZwbVeMAeLT0HJTKYcswwYTr0N0stotHsq-nnF12zcyFaLmWI9HF6PY
ZKlrMQMXbUUD2fbE6i6CT4joVj6bLa1WeJzIYEa2S-rBX2aMQ5r9SIFa82aoqjgwegAroglA
YE7urHjsA-2OERGMclMV7vz4FGe+g9RPJH94IG0x4lDulAfv206yS72292Ml3Dm0uJBYdTkE
SsFG9QA+n85R+b7IlwEJeW-0YrjBoMP5cYVeQe6H3eYdHx1HfR-nn+Ixrd-xUsMGAX7ku9Z+
CtQ9TM6KM0cGdR2CIO2A+vQmwGYViYPe2-4aIRSl73YNQYtVYmqXY7IB1YMtBcohZ0DKs67n
Dv-o8bPjaA2D9-0n0CvZ6f22MMFctfw9sRqY-KdAko7lVBXMGlWOHamdAFC8VLD2xIUbFjcg
jOEWFdoPkp-4JglBHT+uL446oeSsxmWehX4ae8cF5X8+qTYmEgxNCGlFJfM8ZIsAUm6K5Ui0
SxBp+L9DB12i2kseBbp5oO6yte5U+zLU6iG+pApFbodlEcENDDYRCf3eRKcWj2IIqm6WOWop
W7PBSmWJ-XaZiqdNl-V4Mi9aombr-6woTIab+s6cj6SPGBs4r7xloyy-j8KE1OwVin22VVX+
3CMswVB-EtOcrV+GuWDB2kTWU1BoefVVDvGg7pkh+ir++93T-1sJ7ufTkkmNsxB3M-ax3Mcb
aA2X7H4si58zx9ibvhgr-e4HvaXMPVqNz6+8qCDy+VB0Xgx4KiuT5Na--zli8p9lKIV77bka
36M4NmD5B-PJg7S6KAj2U4ToM27FAxxDO0NX4dfoaNisnYIcRCCQFnB2yVykTqMpiU5pp4li
CJd3V3y6SMECjp6hW2VckE9lZqoPeoq4eKftZ2cWsWWShaqen4NAF+tJG4vugfcWAVaitb1e
sZheh9AF447ar-GaabCzzdVWBZp25UI+B2dpjTBteXe-X4Ncu5q5vZUAwHCsC-xQi91nJT3q
ep5vu1NUkyQVZX4scw3XdddxnYNwpVV2Dfx10xQoanGiiyDROn2Oj1wWlJ1y-5Pbk2lpjbAZ
TXmiQFgjpi6wadV+rux3Kjhsi154NNnRwJeMjnX1bgrE41ANygIAWlNeVxp4nHrMvBdUB5RM
w6FnAw2Kw1KeaKC5rJJK+QqSlGeUCvxT3NHXD7eME5z18bUZ2NVHYETevFZDTXweGd2W2qac
TkwmY+j8f2V4Zij9mRUOf3LTEYgX1NWLK8a2exZjp9fvXRcdLiwp1OC38BEwwA5hXFqrCrPq
1Wf79OSCv4MUP2lyCwRNyeyWyGbwFisOTYxFnegtXrJGd1mKtibuGgdT45GNx3x6ynC79yKD
j8Q+zAptFyG16j3otxKgjr9u9JehacSTBbJWHSpSoz8coKmhmaWmAfLPSdulLh5MziftY3jC
vCtLDm58a-tB18WjfuEhhJHvq5qOYgl+vzKpy5xJMqB3OuYSbz5kee+WPkZ7Q5lPqUypEPzb
xi5owijVdoRo80BuzNm07wBM-DMhcLzt3FvLqc1TZNMTS6BX62wg-HRWIXjsq8URT4fISWSB
KgiZa42Oy40Kwl-fSVbfT2TB5p-NEeJsXWP9U0dK4MTccrRO6j+-oh7LAOm5pnt6EyjbpAcV
8YFsQjSXEjo+pQY2STu2KHOd08p5nAalWfhsyoSegFqURZNx465GwEOImawCvIPhR-xxivYt
zs5SM43ouHFRIbaciFSxEPxmlOZogXCGWwHX8xPhrgLuCnMmMgEnUFtLCfwk83Zb2oIjoXjX
tIBYGOEBQewBrfoLQ3KjplzLy0FoBws71o+pFrA-RDOfaGYw2TQ9--QSVOoaR3fJ7Uvr4XIL
pThBzCxPYwqa6NbSqso7jB5gsqSnZRN5exqrqhN0GdClofJKX7aBJddhYocJ32GqgM9lE4Tj
4L1Y3kUZCDMCP+UZvaxdZmah36S6RwttJ3cJfeHxduHTjVYA9wzRcLhlpPoOT9uk2xTtQgDt
wwYzowagjpiOdq+E0NpiOrQaIUOQFITiyAfxQh2xdrrir0Nr6bsmue3J4bDVnI5Fth+WBfgb
tt6qjbefjO+fBUbsCU0f1OOwfpfzUl3xBZ19DLM94JBVldMzgQyE6nC-X+OCqRCYxfT4eiJu
CHbmJWppCZt7MHXfEW9mI+USOCxR9aVPBOPjy1LW924vh7wIDOsfSa3AgTM4qR0T+FnHVfKK
wPeoaWQImpsqQhnht6cJtSXNtuHDDgSgEVmsvcv-DDmqWNf5d5AhSUCIvMu9ceZrAmYCbBP4
kJtiQ1IGG-ZXdAg2ASBXiupdQoWn9KJGx5auCO9Slh2mKiHg7Cya89qMZ9BP4wwbK+EGAWFV
0yfJwWjcBm7j6HlNEcPkqHnkseXMDoxA5Pxdzl0F8BHSpY5vjudxKVjPlwUt9q-ogws94adz
KqrjzrsBZKy-dlgebppJEqoMTkY9nmHWxSqJLyFjKT3hPWsubjC3QqlDQ8ePF6Yh9LQqQgwk
esiSCmu0IQ00n5W-ks9gldpAk7gvrXmvEEwevyvd-bWChvIAiCdwxwq4M2u2GUdHrpnYeXV6
NS5RfKvxCQheTLqmqvuWTgpQZtz1Ih74SLGvMmTBQUgthiH+jb-qlz+Eq2AjSW3tT1tLuIP-
WWveDsFaqLxzzUL5R4tylQHGmb3DxftVBeeuzOhnq2dy8NgGhOICrXmtqGP9cZi4awLT+P+f
Hzepkm8WtF8Yg3ZmZHq7+zAuHaT5uqXSCTsG8rcpk-jhD3Not7n1WQvd0n-h+yT3e4lS7dJK
4Kb-hz63bkOL0nPWlGbdMJ+s1YIU7bkav8BJHAoVO4uVPrwzg79+XoYUW5PSiIYWYovqGlTk
nB2muGwDL5bxrKf1M8aLjGRACDAKRCl9fkCbZpzB+Pbt+Qiz1kwEIry1iXGzDQVCTKQ70lqM
GDFfXi6zLtnz-yMWt43RrGibmU7F52a0J-+29+0IZgYxV0lWAtscq545kzPVUEDzkUg5jcb6
ZvTeTQvM5ml61mEgg5WFDkf5ayOr+Dw1I2g1--E++++6+04i7+-+rD0rA+I++3c9+++A++++
J2JHJ2NBFIoiI23HXJNhPxgq2DsS6DzVaWyG2IKpbGNcZKZfWepqVVcfs-FBA+k-9Noh9V7d
Y3EG6QVzrt4IPAjBVUYkM79rliSSiyBL7JS8JL0Bqhlx9datClrT9PWtaq2ZJLArYnZS5-sw
zptf+pdK0268XG71mCU6X+F1ea+8-BpcUpIQlmy5-sQ5hIMBpW7NWatawxBVxCZmDXgRLxXH
Nr+KZp7teoQ3Da3y-6y84mtKs8ogOt2N9ULEOLWJZ38gi101F-h3EaE6+-sMaSXh970Yr1zu
R764kIKrSWlsWL1powx1m4JTY9uAOHc27b6MbM3QvVnFBsnX1sara-IerAURUpFt4+m1kS-M
LzFpFeEoCYjyHSQm4A17O9WbVm9TLJsZuFLYz+34ttjhLF507YbpQJ0opzFb-D2I3EOOL+6y
gKdB3tR9MC0V+fbs4nCPC4N+cSMtdMg9c2n3Q0p7GWcYSokodf1majMeJdOh2C350Y6OeBUx
EZJb-KUI-C077EBdCab9XIIdgriUVQmMkFmsVbT1wkykO+ne44tZ1IkV0N09YZTQmVV7YN7Z
5NAZ0bgoTUw3UIQ46QllmSfGU-FZ+uRXkh-4Rsys-istJH8pEfd1jJn4w57sM7cpCb0SzCpH
TzgCkabmGDbM6Dc3FK81qqmgZQkkfmb68w5B8xhTOlCmiHDRIb4kYReE40NcSYHhaTWg25QH
q1hgkstvvjTdCopGwX11Wh6HXgzC-nzGtIS9zlLtjUC9GpeWK7aWolYQXrOtmYIKYZF2Dozp
kStd9jLseR9VFyMxzHbw8tdOqJQWrO9KFTc8SfPq3SeuzC3YDrFmCmPrsHHuu-KgvttbwDZ7
zT5zUKuPgJQQqgAq3RCS2wfGQ5ThE-riyKif3lvFZoNaOZOK1OmY9IIXcRNcen-mXPThgZ17
50C5SwuJdnT9AhHOObVd0OmGhjd7HqbEf2bUO6dZ8S4vJ4IS5voQ5V0g9dltoZvp+i+NjjhM
BW4s1U4mJZp5sPNDoxO9Ivu7Pfi4vRGNUAi3ZaJhwCquO1HDK+YgntKBnzQIftUZKQ4I-qGq
AS4KcejHksAhrfAYdQhTDX-SYUojOAQ6ZW6ADZYlSCGaU00mIqEqW+9f8qWHAhydeMrKtR8U
uXcKZm9dZ9Ry-cBxbOuzPMFDLV4Tis69RV0Dc70D1hZ4pfz23-QwLlRQ+xCOfsFiolD5wN33
jEKdQnirNK3Jr1VpivM5bfU2KQDQ-BeGN7iL7DoWgrh9n5YwhOeTQ4YnOJHHNhOndql+6QjT
SeAhUpsubXtHh3-NduuvQlA-ZVcR5zyM2y7Z0NJwg-hoZrM283a9b0t4sZh17Px5vKbPK1Ph
C5JKJV7gjq-Bv5JiYzFa5rj5QVixbImJSvc+ApoaPXPcctbAXLkrcJjPVMP7rBtgkHGaEzgJ
3y+PLDdioU9qT9IG1dyW8oFsM4LhdiZYviSL0pEXSfW5kx5v6UOLFLhtn3WhgPJ45fYRb40N
PJZ4Seg8VNr08usBeUUKhO5xcpxFNsejXJFknFPqsG7mT1duwyNB4td6oZ4LSmvwywIydzn2
hVBO-+MSdPeDU+lLL109Oc20F1cyCzRKpfKlomuwCFt3vZZG--pU0hT6BaAmwuyM3PPmUqpX
QuY6gyq4bEEvrRIiPxdZ9Ekj6QnG6+s4E7Q9LH1xUidbS67aPZFsqrbw7jMs11C9kHTFYd2k
RtmCsvW3OivPxOPhDfin7SqtpaJUtyiLKD0Pm5gRN8Seyvr2AhR3XW8Dzk3EGkA23+++++U+
52IA6QWpSlDi+k++akk+++g+++-4H23IHIJB9Y3HHOpKPKzPBV1yPg1zsTed9S7cwYiw9AO+
CT29UgOlMOLNU42M86ampB8WE37lr3wz5YL7PuaHfWMAGGPj5hsxxo9q5i72kUoD8SWrnsUW
eK7f08Z6baU6YS19erehRrv0cS5UlH5dSpvmC6GFBUDaZ1-Mca40tmd7eTmiLXIyD36V2tt0
or4jDvsiPsOzTZrkDjbf3qjR8w9LiJ7IF4mx7LxOziepSgrdL5NbSfQSu6wWT1m0UCR0IgRl
***** END OF BLOCK 1 *****



*XX3402-023714-280896--72--85-30079-----FLATMEM.ZIP--2-OF--6
XAVYCVXSkKRjqCn0LLwy5dfNETyVXlx4SI-Z677AQG4-d036ZIQFt-61nkJ6eXHl0wUn4Aob
FaR7ZyrKjyD-UrIrL-Lj1cFtxg5xO85FcaMLlLu5GnCnDod3RuF5r5-RTDvKRprwpYyXB008
Z11BvUzUh+tlqeo0dxJt4ksWZ1WLck756qF8+0AyNF0hi+WDMj2coVFOfTDaiToz8HZwWr6Z
r++LExPr7KStcY-0EOJ2Q2JwFcwvNI7zAlqM59VB2sIZde3VBdzSk8UzfxRabuzjPaxUOz4I
OMhJMpeB9KPA9Ma7FO+nHVP2LqiLK97A36FJIg6eIH5sF88ru0us7WtCVONz8JSEQGYHHE6Y
8HlSRYrPA28rK-H9HDAZI5Nf4JFA6G-0fDIiX63jH+8SUe+e3qb13AGOtkV1V3tJ88MFtVDb
hAmM20rtYrZHwhk6V4j8wmOakJRHWOLJJZXceJ8sOPtuRiJ94dXrxBC6WrP9k4UGIatx7Mmx
ZrfJqRdKUvWPbCY-NNdkyel1EGF2FDwfhuIeehQgxBKSsFcZZ-P-ooneq49-cTLMQnGvWmJB
pIPfqvDpU1nPGFanmeqmGbLUPGdn2E7KLmWjWccuOnJcdQgKcQ7rR0VbSx8CeM2gwRCkqfBv
QR4yC479ePyxFJKTTpQxvunpnwObbJ-pxs-ApVw-uaUUxcAujqeRy0KLkxCvLDLbbrJt+zFq
ZnQuVmvXnXh7ixjpVjS14QttJ6oxlHjXkntM9TpofKA1wP1PXHpE5+WoKy+TvrBZcnj-rcO1
U0J3MRtnG37J7Y8KmlVA0O4BptEg6NRcsknj1izSjRmOv8kBAV-KIJo8Oe44VGpepvT520Il
v6sSX6W+9zYmezMhXhRGRTQo55enfHNM9ZP7LnXm7rojn33EiK5Jfimp-xhH2EkwSksfdPci
v0ohN4CP99kOwJkRduYgBYqH4x5szn4pmx9Qb3y47SRvBApTcCaDwU8UnGT-JqE61o4-3yoJ
3mkoHAorH45W-1NhnD5F+Dd2lJf3uDe8dUeabwdQsVZgif3IWHZtIWK9jLXevBLXdjNc4aMs
AvkTSCO7Tyepzk-EGkA23+++++U+GoIA6Nk7qrL4BE++-Rw+++Y+++-MHJAnA0tEEJDhTKhr
4Yams5TCsHzYujGidH4aoQBiKPuOKGGElJUUft1RbdrliOS+F3Gve48e0XqaizSrPwMX5zI0
t5NDqzRQNYtP37aFYN4FYN5leaLcdy71TvXTSZKjzGlyXDpIVa9o6AuxC5sETGyyPsfRZmyT
ByipSerX7yD+wyQmDefLSW9pDYYFFW8KmG682rzY-rvu68NF9B8N3CAcXiIs1KKGW4We5ja7
SXOF6cffBKUkWQP9iElH9zKXg0Y4jZFDMynjVExWsgqx4ubuSOaMSkwkn176lQE5eA21Uj31
zPIVoYXAj5VmtwIkV2WWOEdzBwEoXiO6oH8F4IlkIcD9uuuOnh+Dlp8Qj-IzB3jEA+4mBAEW
XatWPtucFrtsEpqFO4Aj18BIX8G6Zu5kpTEbIi4HBa-g5B2HmIk4UIUKrZoc7zHEHtiWVvqV
unWO9zl+zLPbdnDsfJtvdr0w7WkIcChZD6d2FsuKBw8TWcRc8SuwA6KtHj0VSV9PiPkZP9CI
3Jss2T9Samw08ONF22FrWT-G6RLXO8dbqDkJ+DE4pxqfgzNd3vuY1kgp7G4+2fpk4ZqfvwTP
3x5soqao1BD4GO1yj71VHHfPSEIReCbPB1uCtHW87s6zDsjSJ7kfB+7tr36TK6lEL2ubWIm3
ft+FErZnR1ZBl8w6-1vIzCVCULb3EAH0wqClWDkklPK6FCRm8CNm5gIDkjZM64AjYI6pZnQm
JbApnxKbRPHRbgF5EFHSe+O+jzphxqVP6RA+d4-wzZ442tnZnzxb8RK+vPqKq1tPVaCYQSi5
qMsORuezkwx5cmU8d-RGfshcv+KWsmTS871trWykxm8Clb8mX8JidZdFtrto8wL2GnrW6aTS
OEEo3qcm2lxVeEQ4WxN75ivZQ2wprlsS6FZZz8d179tk8K4kvMNZm1vD+OJK-hQfaGvX21RQ
i7mDYD9W97OGpnFluEHDyT5qCJ5vODGEGUoeY902vlM9-ONDAoOqQz1NrQrV+n-JqrTxYyqV
j-YgtqMJ3IV2d5iTmb+W7pIUKypmY2+uVn2NtCgU4ZIjvI2CpCjwqb9rQZfjtrgLWDrDdInG
BFFetNXnhImNE9RS91GTjlfuzy87oLQQcFocO3uu+R3SZcs0B1glrCI+JXwXuvuLQE9h-wEg
1g+Gh3I5pTscGKAzj02sdnCdwD0pV+4-Qig3zeEdrc2Mhy0ugkkoOjsSaZfKQrRg0K+ETb71
mBGq51HwhduUdvbtEuww0qf8ie8dZAQRi6Qti5rjjbrfyM40zIL+mLYti0jdOKNOnOxvCMVL
Aj5z7Sq4PUki0bm86b6hGTA02LeVE4loXiXg8cV09MHCzNiNVhiCdSS0rQi-tHvE-OWVKaSr
umdMSL54TIdUSFhjnPA0H0+cwd8nxPDnTVQ44r3d7kTvLKXsp7KGiGAARbvq-AwQMSu8NO0f
TbieozOEwCuMUmmzP0-SijoHjLZ-UMbbd-+tm5RnbAOeXWP9XnAjDL9I5sTVp-1DrAwUGhIU
sq+7hD71QFdBt9D0tpSfDsFfRxPVsKn5e1FK22DD3NpSuYvI1SaUKuwZm43LxTuJthTfjvrc
xfi1uzNpvr6+Hy0oyB+TziRd38Nl3-XOkqyCDV15IPnRdLCwnv8OZOWFjD31fKjtIn5zXnwz
SI9us-pQDfPvJVJ1vOqPpRiyOvKCg42EiYrVZtSvtdQbpnAdnjhhJ0u1K5eH-pWGNG8TtDfg
qHuR1x+wUCh8CjB6UTZS+Sbr-gRWsQLSL8ettU5gZks8JkCxCmTt9UTN9b1W-ru6toiGyY2U
77vlyLthCzAbPKWZ3tLr1wupTAWqElfcuc3sFbIX1qF4idW+GpEdlRczN92bzFw4xoAwRjDh
1vDhtm+4NdsO6RExV5cI-xsWrvCRvHZ0kQD21T-knTIsQJMHSfnfbsV2rg-BG8iWJLX8673N
tenakLKQm9wTCig3q-UVkpDksI64iCLbcTivWmPSRrf1Bq6WPzolQgd2db7QqRIVF1h21dCk
8IIo5WzXeYtRRvkP4QfM0wEYxaxZj2brgwmMml1iU8cfghb4I3vaW+PvOF77cdWwxtCoh3gv
hz6ncv4JffPiZRiwkqUNXyLtNbpnitXuqXjhmfvDgrovQ9ljBie9MgwBlrndfiv0Ww3Igrsx
TgCKQXOK+T2iz-F4Rm2Dv6RYSncGHlfRT3yuPfhDnfoUnSlNdsLtKxzGnKsfiHGcNb0GeKSB
PVmnXS3xtjSA8D0GiHDgjQ8wzO5Fzi+w4rh-6Dvi56oTbFzboGqCZSY-1xLUXQu5kVHcN3Ez
5fCZV+vIJiD7+0zvnrUrZMU+ujQTTxtpCw6kHtl4vsyCbnklrytaTW+-jzzsQohAcc6EJ8r5
grVvKvJ+Gx7rNnhDcrWmzOHpN4TbuLhrEM16lx+iaQLWc9Uqkfr05PzD9hUOVNTLn8nLiZI0
yfPD4xypRbADClwOrtqdnqBK1nENgIVly2PvMgKjHrQP7lQJ8ld2g-EvqJKRyTXE9Z+NDIci
2txBXvpjNy6NMwRbHrXz4tdklXPoqHAyy5Naz2JKyDarAxwjgw+jjjM7axArOkPzv+bzwCyT
AAwBHgJJAlNYuXzSpUHOfG73iJaAGO7yP1mS96SD6IizqrSoXRyB4isoXraSqyfVXYVaURVh
JJ4bp+PtvuJCEI5v5OXXHDAFp3ZZGZyzeIuCXfRDbiuqxjNrI1LHkpGHvaJFOE9MG6iHlt1J
xZfBSvyrM-8CCy9cy8F8D3TvSHtPR9K9d0HELvgAJxD3vlojxMv6cOhVYR2biozJNnXIBbHx
dBD7D0YGT7rxbQayWivcCkQYmqsjXCblVLhDILUS1xo50grXHiZxdK7FrHo+1sSxFYHLQ2HY
twvkOBUXJrK0NavpxBSjTQ2TOqEjLli64V-jfyFM-k32ouGFO-SXlT+rfq4HRqVq8RJnwCgT
hv9fOlfbbqBX9MUvCpyC0PuqpSMpDJeVaqsI5D0pf5da6TKeusIQNel7nj7rmdOzxJxrpLZB
0uhiB6gpDiLwgGTO7wDzP2xgtAna-y5d5rUEtfIFDMj4GJsd8HFtiZRhcxhMxq+e5lpfe3Jv
gAltyhaeFuS2shzAnL3HHqm-Es4+1J1YR01FVhHezX5IshwFulBrE5U8omWqDTw056aC9G-e
pfRZcjgofMyCsN2fBNqkDxjcT+B9z8e+azNkqCqTL5Gje8ynFALpmGxClQdIX3wFZjAv681v
LiVp9K-I4TpKl2PwzCDgUS7DHTREmUZ2Ht6LpTewFj6V0g4Zqv0lY5MKEjkwKeP0Hx4lxXwm
9Fsresh8UzKOu79p2Upv54z1Dsyui9daTLVssZlQ+RWr9-2rXhcfWAHVQ0AuDxz7SKv8WPnP
8Z6lFxjTKJUCVwK14n0cZcj4DBTOEGyK7jTlRsTemFdNaSiDfM5wlmpmPy9Tkq5Coj0iTu8S
8enEh5CkliFE2eruiSTyPcb9Wo-zAumyBi-jDKpIXyDhkQLaLCoulZVo1D9HzbRGYbwTL1mS
ew4nzjTj1ZiBvovqDetZPoDgcyD-FFan6Zr3nvokxPr+zlT3X42e-yFeE1f2fqK57h9ujb4k
rqfBlAxXX8O31iSxTfQD8FCd3kE6n7l-TdXWjrhbArAAnFQ28KUQhgnHbmHxyvwzx6QRR6Tf
LlP9N2MXNksm6MU0ye5hS3G8wuv0KTlw6pB4Rolf4s+LT187NN8gEZe1AaSDkluBoToanNvi
BKHW9+BAk54KeMSMwf5x7p5qmQQ51VRmv2zxAN9PsP1gtrXJ-oO12713AZt2HWOBHXM-nEDn
IeMEn+PFQqiEq3OnrF4r5DuxrqmpY1rukqSRmq2HMn2lcioikH-FYseX-ZaaTU0GpSCEIGyc
pnW0PFchEkn+v6Kd17sYsf0pRzU0hwRVOpzxBT6GW5TnlXC37wGi0+xKBz2HVKrOI61c7zL9
F0tU+W2Y66KVX-JGDs9B6cba2j8FohV5SNIo0BY7e4D-D2dGwS9UHPqaA+Iuj1VcjM2sWz2g
Cl56+j94MsUsp4ZAOcEC1UcN9d0vcmDpuXKRr2FXEIOI+bHfHuGEhn6IOj9GGEdl-n8oH06w
SO-HXeNcWj32YbfVF6qX+8Kn0DC1YXG0g-U8rTJ12n4c0MtQS-pFCVCaEQKEv9EAUUQQRPzN
kXmbkDT0h+29WVgmIM14Qd28BIsWVNQYoRW5oAJu1L5-E8DZMV53eNUj2wmoQW9aahV+blQ7
d1Uo6-A2prZrPkM-XDJOh01aE9vGm2+9mWQnSGcaz-K1SCoc58Q2cetFflqqNdE4pnrf1LcE
2ngwehTQu3vsBQToeUJnjlyiMoJW2EV0dGVCsMoUKV6krCqTp4ggSAE6KBlXoVR1mQzvvNoX
qehHDmNSV7LAlLcqVQ+6irlzmb1vtl9W6QTSAd5p4gdunZaHxr8wH0b4qIwtT2XxfPc4MUuN
O+mrrpO1Hjqlvk2f78YLdsaOEmcUyiM6t0gadcIHn2P1Vz0TaNVvbs1VT2HwqSs9D07lckNs
uwFd3lA62f5xfbyGkBHtitcnPkUPw-e3h5gDKzRJ0k0lfvk0QDOZRp84g3iS79GH+ryiQ+DY
SKJ2MK46--EUpl-kj1PIp3IDV+iQVh7H7VnK0WYf0govTm81-n2l2a0tW6V1kPuOs3LRt1Vu
2qyFmZWApMB25uSo9h017xIgsIZ1fqu-LjZss06bkfcGbM+VcZ1VCw9ImUbggbcBtEE61Sy4
-cTcoki30PDYrauG4c7Vr9AOZZPXxCovY3Jsn34qdFARnGQ-mIgXKVIqCAW5TZz-PsS3AuTj
VEcFYBlhZ5UQEQgVR9nXx6v5dAwaEeAEO5oI75lm0PUt6mPNsmUdFZ817idd+Ax8nV9Qj8-P
***** END OF BLOCK 2 *****



*XX3402-023714-280896--72--85-20380-----FLATMEM.ZIP--3-OF--6
B6Rz4n7l8f+LsqIQeut6OlH4Ddkx6xm56xLA5wQF79kq8L7T+NP-Mfe2d1EDg1m0NvzYHbjs
TVohUDsoL2aHZMyyzoTyoTSzzD8DT8hTTWZo95aoqMUZXxt4GS91nWtDJDYWMqkoVLzwwgjr
yJPzyDsnFvn2J4XMbq6Q9MA7lHvnBhlh5Fuy2RivzNCb9kvSvDkqGY8y8w-v961GgyCrMv65
NpJAtxpLlLe4nodGpztk1W7qSNRb3rpssP43aZ5zt54n3mITUDM3BhJd3Bv8Y-Ko82Pdr5SG
iPz2lZrxu4bi2Lm5eRJfbOjSyyuJu+q4pyq90wlzmeZufge5EK1cgR1bWiwSm0As10+l10Gr
7nfRxvrHvX3cF8aYWlCSqCPWwGEFdtS1gxtfC-X2p+x+dSctOf0-j6Vx89MEMPq205WULeA1
9g5e+QAffRD+0EKp-k-DclKPd0PVHS4zK7E-7z+YeRR0xNjMHdMrBn8-QkOzPyaAe0okAYnU
9WQHoXTwo7wjtw8PUzg+Pks91r7JEefq+5e1doxBp-oIHUeVhyM8MV1Bta-dk5Ry20WgeCX0
6Z0kXOs1Kc+EEubkSkgYwJDzLo-g4DBRshr69RI51aqs-w-30Gd5aDErp+oGCEOPSEZhWWEM
jCiThkSRWyvkS4ibLaDBF42ScnN+mg61Oq5rW9nBVAzf0OnzsSm--J0RAcZQc-f1sePyb9Ed
B4p-mEdYhpXyQyb5T7b14nEIns-1UXK-uzCiS5hpyTeerSzr-ex3yqpj-GC1H+SkedKt2t2W
F4eLkiTKxr-WZha-LQZYMTco0NHKwYXL9PHGOInlr+wNQaxk1KOIdV-bQ5Bd0+wjfAUmmEkZ
ayY--X0jQhQd2+Btfm1s8TSgpq8NlftYDHO5LDJQV0vMUKMos2wjT8XLi7yxKE+WtY98Bs-d
VcUH5qvSk9L+7F8Gcs7uvGOCZcjYG0wi3e-c0f7BNP6ovMdghqMvhjJS2laRR2II82v9rRan
DPTlTVBJuj94yvBbDvWB1tcJ4aaysy5gqNbPwLYnSolKsBOODMDe1QGebStpxufT4k0Pxgt2
Ss+IpN7se6JlhpD-kCITHJNM1EVBaQxdCbTS+mmxtWOwQ8vW7v7ipKgEuB2yDnvMdyhfyy8s
lHRNN+yy5HiAr0h0fRQApnH2cScCcUp9mO-7UiFOyw9gxmsJPnb85gSjF0z7UxPMzWLPB4yB
nTtOMfxQNLdZ+ql63hV-t3VUsLybvMg9K28ED0V5rUpCmqkZlKJuuxf3QcEY+pKKw4-0G0AF
XJ8Dnk5SoqNnaYrBpZin5rZvOVbU7lbGRsR57lyk0OmJavQt7Zu+2tTgRa1Csg5myvyb-EyO
lf+XqvPOtk9MW8ykxaX+yyvPbbLkldE7VR9gCjQXk3819y-08d6ZcIDpZOOWpKfhni+gU56v
AqGb1wG9eNi7WhoY4jCqqlyCgRRCkv4e0iSM35kq9Hkw02MSNCC4siE1fYT5kbR6BjKkj-21
Pm5ko94eONUixIwi30GA2eXLPAh2n1mGr5sgNb1j463YZmZOH4xZ20rUy4K8Tt7m+P1aDatA
9urLoCfX97J9mkHlMBL0gH80uUMfH5mIs2F71K5X6QljGObGNBVAN97qqo74zecH8Ayg8zPm
vgNviS-e+6yJRZUpFjQKDTiQOXBpTfmwQWC7pU-vijQF5FRJgwsc1hfsHriUMe8nFY3YONSC
CkYvH94eH3NnAc84iKICVQkGK2QgBePy1kZreRVvfaqDO+Q5VYSRpgI3G4FIU74QUVISg6A1
dQ-af7GtMZ3oigDHexvPnIGYDgacX3Td48GiONFQhO63VG4eu8Ap1qVHJOL2hBeXJiJpIImf
TFkjLxr6z5nUzCnIHX8zDsTTwrKcn8wjv8xZbLy+boqV9jDso1sievpVqa2BXRKJXonPBfGh
9WhZqdp+irtZZFfHvdFbJZ3ulPHfE9hJFJdAmutSy49d1xDaX7NoRIYNrLertP77oG-Wqiqu
X98WrNsnycdqVwvuSFLpIonPv-du7IJHgf+BZIeedNV49db8MB64vptRLJu7owhCJzE4bSu5
gbqB3JOaEdyAsUvIFwwxyy42GMmTkNltoJGQL40l2+bSGY9htC6M32YzRw+LGorMfP09nPr8
mV8qtRuARSBQ6Mb2BiYmgCem2IvXAkpjLN26qySZbJml76FhhNhdJOXyMVjGZ1MfyK7vvST-
Nyewq5M5dZpZQFQfDaVarde89fPxfabza16ihjySEOtE7QAqgXCh86dValvYaVPeIRWanorH
od6Lhi49HAAJ25wk1Ei3O4mXExBcLZpxlXNzmPlQ977VyP5RBX-9uh9MNWT3NjYadxYaHuU3
q55-X8OEas7tmPPjaDPM1ZFEyyg7QtB6tVs4es0PrBJFP2jWcn+Wgr34Ov0B99CgfDlFfrKx
wGkXRmMm4QTy07FcA9qVufBFmPyBfzT4x5fpSbU2ztu9Mq3IlOjiBHrxc7v0c8honFBcpB4L
u3H4QDS7tOpTqODn+ERfNGICWeCYkRQihAXSyLfnROyi28B-32efn9Y-jJfaomrlUt1zL0cw
s9MdRZww+y3zQhfFp6zZ6dO7l48cN46p0DCB+cm08qBkqCNePlzpaiA9rNPBamMSI5jvnqTW
XbFZWL9GGtpSaGiHEyduPOytzrmbWTGZ+whC8LDZeO8ta5gyS7X7gkkJPqx+uSIE79VZUkXD
q83l0GEIwsrgianX8NVOmkiK8eOUCNy47z3dVgj2dxZ6ail3sXcHzoGFHoYqccaFG3mm6tEB
Gk2ykhVJjVxqQpQbhU4AGHnU1SxuS+KqUclfj75hNJVyW2Px28o4XjYRPgciq7+iHii41cKr
K+GO4tb8JIBXR2X7tWvgEc0Q7DtBG8MOCyOOXLZmcO+xIcoWwM2RBpOcP7zBp-ebzOM8XhDZ
QOdCaJXmoZHC3tH70W6bNVCu2tt1ueaChU2qbicmroFuOrpWl4p6kn82u744gotD2cmNQNkk
M6W1816jhahOF3xkh6lXGdbDASk46a4gTSfK0tPKY7LZr2HQ8DH75EM-9b3KN93vWzQnFUUx
NAQoqB0Aq6ObPKo7qlK3WQB1e0GEA8l3VhMIgGUulwlFUv3JF22oXGr6wzK+CUCE5i9eeBwY
+ev80GxkZu3cYakseDGR+EKr8ezt323gEW5nfXPLVAW0PuBuefxNwCph8WjMS2cVWn3VBzbq
FILqgb9b3KsftFc6HXylJotrHkAXg9QHuS64ERJflgSQQyYOas94-FrND-9stxVgdaM0iYmn
LjgFvg8uBOXf6sVWg2g13qxyZM+kwKMa7522PVvdu8O+BdjuqAOfrNaYZOsdk9o77tOnsDtO
3bHjVrknzCcsPxLxTxplELD8H1LX4b5X-p4ItWESGXNh29Q8bTO5OCdNFkjt2Q+1B2KDgZi6
LKkLnMovajhgP69N+nmiQGQZ1saOKIuALc7X75kkEOEBBSqPaq9w6adO0fGLyfQEt7Y2oNp9
PD-TK03di98uejl4+f8Q9kwSlNQHEi5PMgmWDBn689CCbtYKzoO4phG5ICEpX0fy01vBKyVn
PsfMU2j9STHtTwjCrmUvsN94WGLOLEpE0pY+lEUgo-tRf5V+x9et9moFqkIDX74bl7lcazXX
q9C+LiuZ8txzh9xMmttt9zgugx-zKTYtxg8l1-6IL+ehO2Zl3BYmzwwBAt2ckPm-bIdy3lim
SvpKliwC3YY-1FpaGKWXzL886MC4czx+SJjpve3JX3nCk1wwGfsiNUy7DwNAbYS6qZM7ByjR
IAODjmDnZn6ad8FGm8OIawoO4P7SkxgLmYVA5nEtCQIo1q-I-NrXmvPsBbILSsghrajCiavk
ddLD0bv9fjlVqQdXcXfnQy132D+edc-COPkeHDjBgl6H5lfefeDI0tl+s36sSEVzb-XQq+Cr
maGDQe02VdIyibfBI97GVZmHYQrpBjfC8oP6jAGFIqHHkZFEBFYzFNCNbGbplNVf123tn3iR
5gJnpLnrAaS7FZtd4msdA-di4VA0Jq0MOg3ZL4pavGe2JEMHxf0kIpGPyokUxgU40rkJf3fh
z0pp4ngkDhS-j2tTBLMSXpS+hw8B1ol7aqCNwhBuPF5F0Jca5HVipZZ74n09f8rho4e0tbqH
NA-34pLNMbed-ORr1JyvNVnYMKxRe4BkJ3ym50L+VK3O6-Be26Fg4Ca5Rpt0GE5ASdZhObri
sH66Qjixiq6JYf2LXn5f59rgWOisuk-rix6dNM5P7Ib2JBv-DkiRlwGN-F2YuoBqUF-cRjAU
jB3FDq+NX4qvm-NYX0iLw-Y-h+nB4i8gBrsFrlQswRdZYiRwpINbbR6m-Alkgf5UmNWIgShL
dzlj3+TWB1wdOOt14QcY+wkuQIJ-bXq6ka0LphS0sA5NBzn4JTQU2hifXuoRNozIOnbXQrts
LZfYL6cenWPYO8pTKuLpxUW9-xJmCWLD2OyobyeRcWraO8KipofAp0MANMqFiXdkADRuimyk
LIvmqkKfqFu9hpEKZ-9CWdYVUC2kXNTX3DlLqu-HcmhcNxqqkOWQn8vthez8XsWSQXdh5YTZ
RBcocgfdgaZgZRBZYmUfdzbXseqQXWgXfrFEzIeiuo+A-WMji75Do2ipVvPI37sZw3QK0ttR
tXCN0D2L10rTroCRkiNfI4ks500l3mPHT6VENioph1gBXNx1N1aqQlLA9+FScWdwiDcg7NJV
VxnihMkVJe2lISrwY06lGb-la8KOBWsi8y0J9EQI+ZajMqd8ikS9TOYYu18akUMMTvkE7EWN
YR1dvgyxq+wSPAUDyOZjsOkNaH6M078ndx3yOHCJhHwILueRCEUOMVPRGMm5AazspbIlS+Wy
x342Zkx3hAcVwwxtfHWf9TOa-T50OIIcD-gJgWGJwG8KCH25KxFKzy2sjmBSHbnjBVqbgNlm
ZegiBEFuRJPHAqxcdkAAZIoCYg0mRoYGlOlsZkmIGuukFmPKQu7g3-1mbdD5ZI-SfaeQlYie
GKNtDXB7m3AmPBnAteVYG8ZPwZS8by+Ad6W6+5yEzaAix-MMfL7i-7Miqfs6JrJ6DEvGKPGw
aS26bAwvOEWMtXAjc0+a28AN2XBrEMkHFdJV3AXIGnU4-WhEOQAX-AYVoJlc7Q1ER4-VI6IW
+mEv3EvZMQY3p0fgxYE9yUMNPeRFT6SJdT7nqTOPgUbVvv3oUMskC0+TgdENFfLMcI7D3hfB
ocixA7II7bELlNy+uFM8YsTQ5D7NE-VAILGtt7BuoZaKqrAdVNXJPt9tL3iWjf5aoAX8CUUz
mgl+pzU04v4LF6GTCM6makJqRflQdC9C1mQEcn3NMiIi89le-4SWzG6JGGCiBbbuFPH7ov99
JzuaGw9QLhThSP5-PMiqsJcPnl34yT77dIqvyGkwrh7TVvLbYJSoFoOGCnr9Mwf91aDOqaKr
6Ck7cY0PFC2O-5jI3Wv1IuNW+NeIx7E1G8M4imKc++EQDp1XU9OQ-gWr2sIh0VnGBeYyKEav
B4YLu9JCb9jyAaEiIDUa2KUUpamGCsDP1BO2MyYnMaFNWSF5zXdvAVDPzNkYffXJNUL4pcJN
p4G9epGdaLhMF+2CDuUOF1LGJWG5iTiwwqUHPzZCvrnCHWRWPvnLxRdwwzOIBEYYNLiDtUtv
W3afR+xWYNQ5rVJUNgJhYN-GPgRPNLv+6kBwJuH+ahkBal0L8InVg39rWlkNrQQmoYPgUrY4
3aiU9BHfKrBib+-4puImhKFN-yNmW6MZ67WqaKMQDKJSArQAjaNzDHumZRmxmX3KIIn+4s2j
c5WCO9RM7aszvlO9l+pbYqi0cPP67oY1suFRBEN10ukURCRLZ9HfYa-RRXzv1CRM3RDbAzNF
Klb6Cz8QO0z5NvVXrsKfl6IXWaAnwsr3gSrm3IfYDx7NxULhvMLAkTIt4hPj2pdhdbHtcH+4
Ly7ht1GK7N3r26qWwlmE0qoGFuXt2evcZ4c6EKBwGsi0WRaNKDnIqA+37sshAQRPEgKhOPM9
***** END OF BLOCK 3 *****



*XX3402-023714-280896--72--85-62601-----FLATMEM.ZIP--4-OF--6
4VC082YnKJ6ZFTTgBhlxHBNUtEMgpB9ci52FpUyRrrWEvr2HSsjNKfyoHUL-5-DENxSSDMV-
BiaGuII2n8tYGOtJmN1NRhMFDosVnQKBMQXvl2caOxm2SU8JSKAfMmAkGvI6zQj6XgpnMdoy
8vBXcPnNSWxsK976VLChZtgFLfoOZS2Ye3IkzavFbAu5r-ZtwY1tW5XqqYaM-QIQbQfulJY1
-FYmc6OjjSS2P7w+kl43FdZ+Sf9uEOr1HCYOmoo8axmRli-bC2-Pez9KYgUd+9QytYP-PSXJ
EMBk2Foo4ijmtkkAAkqfI3m4rbG8NktMBPjx6IQ-i9ZBewLJsx6uewFJDf4nwrVVgSu+-yTg
jmIVOjAwwpKiNih5RdWhC5TfmerLre40zhgGXC1iN475mbmrXYOtaX4kIhynFrn8y47jfFtN
6KorM0HciItFr0rX6JR9z7pMeCJ6P-63EcNcKET5a7Tu0RTYh4RW3ckPbt6tGYA8xEE1SRfU
H3cXT33oJ2WW9-kY5fZ98gRux4vMJ+ggMHmg8s-eLfrq01pDJ8ht49ulKgxnZ3ZKwMc8+zZX
Zh0nI9u+LUZFoKSHxtQYIcnJ-4uAjgs1C9NqzRs7q0htdFaWpV6p9InJDF0jFv0Ha4NkIb7O
guv9-QLzcFO-bw8p6B3lOFWgmEIZiJcg2EMUcObUnOW-J67r1F-q9kt2TqE8mhfanLfhP6bC
PzAS+kyn8FRoG+5rwsGoVl4fW0Cwdi2VrEPMmqsoPPK+Wvg7sYYkLFVnGLlklxnMuaCBSWrq
A1IIiEFwan32hEATeGx6E1xAAFeS0yaPF44HoSlIcT-grPGwjsN91I20COR3Zu01NFmYdxYj
YIt0E6FFyQiEDImGwuXF7U330LmftImY3x-CppO8D+otA9yW87IXt844pGBB-cvX52VsJCFy
ZDm5VsvYvxvvOIb1PWPMSwB+vp3CG-Z-pK87ukNeB8ls-utDjIwmmFNx965KDQK6DDxa-iXk
mmwQnkkaIfV5S+a6uh-n7y9QbEey1mcd6R6X1e6emempJpFpr1+MjJaIzGVTq-RWt6jvZVhx
E3bpaCAKsCOy7C-r35BBdfjZ+W+Qj1ttG24whMoZ9rX+A3krxbp4OpSjTEeXix-uRvH6oOMt
DU1dVZDdVDA+2hOJACxk6TYOat8V2ny-B-kzL0eYf5aJlthv0rD5kM8vv4HWEw0JtZ-67sdH
3+UMF8+10fm2g5JztnU49KZK7assba2yHNZ6CO6kKxJf8+JFPe7QEFe379N2SVQtBFulx8iv
h-uxY4cNd1H52rdp1t+Dr50lVBQjEIqQI9B694yUI2uAGt3nEODzn9bjab++w-9U746Pme3T
9uK9d2PuDITaC59ePkD0HjZLgwZm030tr0PLm5AvvAtQvMjMW36Tc51juEQW1KKZXGEt+Nht
89X7L0UU3a3i62FoASNKUltZM26KfU5ed34oGwc9CX9ztGBZzeMGDtxGMEJVRJu3gKEpWV8l
zB+cIyhnqFJo27HcNPZEutl7uFiGldiNY0g-TNsRiIHAUufanlK2KBiGXBdH3FrR+8K5LvN4
VZsw8skfrh4Fj6m4abiPEPpa1xMwAp46bON1Ej3sFXEtcKrOMMSWpmBletJaFq6ChRdgLb5U
tGJLUqKvaqW8IJ4YmIfC43ohj4WHTyUDuvJp+YmImWzf50qK1OrkYY8doQRvXHOL0bbruIMi
pAwG+xIipIe-UDtIic-KSJ8l0iu5nzOaKW3sIbGbTjo8s+czoIPWM6KXrimjSaqMiNMKxVOd
XbUVh18TL1Yai-Ifzi1pu+NXTiosBUMEPlWlcxFcCN32D58xlV95YI85er+7gon-124q-x7T
5ReVZ42nhKPyYLm6kcbMSzs0fuGyL8gmJMWSn0dw7SdGlhesFWgtyxpicbZTBjMc4W79ftl3
hOHQawofXCO1b6RZVAek4gLRNMxHPb6amvkoyqxhdJlPyFmFJhubojzxC7qcCdfXOx88uXJL
LbqCJUHWcZkqPOkJpKgZOh3OCPJ08ufLrZvp9exupvrzqliwdce0kzPfPfLnGpi1nm04zr66
8l8n4KAgTGsvOImUAdFHDvJ2nJQIPC0AeUccMVkyybK+sDCZydbA1ruAoUC9CC-wmCg1KPqy
2kWeQodikE1Uns4sLgXAB74rAc0cQl6Y6CxAnJl8tbQn5GbtkUxj+j+iyXMnsElZd+QWcw3p
KbLh7teDybCI48WkN6hZacXRpViM0mADJaMzFPg7SAVUKds6gAEZE2HmeKusLJvgjP4-UZGL
ub92HfI455z9k6jfBJUPGpdY+vGRcUJ1gvKF5+FivXWRLlkc10YmTYdJEa3Uk+PQFF1PCwaU
YHDXoUF14sk97dqd5uBd7Np33+Q9FZiM2xdhlp2s1TllWZa4AxdWDddSY9hkBupYZokgjZhL
J2E9IetUG8kol+KNMFB81mnnVZT4wL9gEn3FM+MprGFHc3DAjIxkMUG-M2K2-oT2q1IlFYSp
aVDkOwXw0WOr12vPmT9aVi7JEV+pKxwD9VKUfNoAmF6t-Yr6cFbANKs9U0uV+0UNlK7mdHZp
JlJKyQ8f811QAg8uOhKpJRmw8FJLRQevsgOWwgYue++riVzWFfTm3L-8g+9lhUptqn2JUPnk
EJzXk5BvDPletXMFp41dRBzrHfj5tvpyhxwQzapc7bFki0Ksd+jehd1lTbctCCixlaNH5m0U
xAnlWTMcSeY+1r6e1UvTw9M+BFYJItdNjVOafUP9h43NvIpyKi9OGFxx8GApfR7up1-9BYY0
ja9anlANH9L3oLSeoFcfcr5pBHWXNich+rqoFJBERV8W8CX1Kdza9H-mcc7EoTJsrs35jA3z
Its9l4HuHgLg81J0YAfTXU6thk2ZzbnVESKaMXrc73Av45b3mdMvHgciuEStC558daPrRwvI
BYJ9XTWDsQz+HxD+rLrko2z3bFSa0TAHHc2GQi1WMK4PIl480pAQ0MLb286uWQUhwQp5tLbj
xPbcRziLJrwHvOhiKplpVxRLjRDfriJUi1NQ-0+wUlD1WsK7y+P53TVWxHbXZCgSSm358b+J
NBKqQna2L9596GpM0BSt+DqFs5vFuFL2wQVNGO93B7NxFIN4ImZRd0Xb5HrfNCWqprP9HOk4
4dw4H89X7tx2vzh9aoaMCEiqcOubEfAVScBfgPgzOw184OzHXi3o41e4K6otubo4jjMYBcH2
nM-CF8rbU+U3mRkcCEDyp5wrjDuH1T-ox+NI2198UGqQkP86oVToWMWAloWGo5XNydwawgvk
BossTJVk4OfzxznknIu1j7KckD1-kDVY1k2y7J0i8nFWTt8FutYZElZ3I6koIJX0gSbTU5AN
Kf9eNoy8tHlrIhYpR2w-GpLBS4f4hvYwisKA3SdIo3dLQQLEEZFw6OwK52LiJYDDAgHBx2y2
IpW9AqXJd41KRv3DsdOUcH7FnAs9t1EpUKm98+L5BF7Qmo0DHIpW55j7n2mnNt9iPiIsXS82
JUKaW-gafolRgx9VgPT4tD-FRWkLdchhDSqa8nbxkaVkMBW-a+j0pT3DWQtHNgbHuvyxuDOv
Uygqm-eA5lm8gwgfpA1VFCxQxRtrfxM9cF7tp1N+b7fgJ1nDL3+s6TP41vKe-cdCtXt52th4
PC2t+j+TyjpH-cLK3KnVlTa+Ydza0zkraM2-uQAdxo5vVQ1QRF1cKvAcygFJq9Sm+A7csLsp
bpRCYOuTZacIbRXfoJWPEe5C62HtDFNoUQKEaMpVk7f1300qlExFqscKHr6-HigyfkG5N5V+
G6DL8-QUik4MVNSCNrUsBCip9AqDWCa+CRnf7EgnTfi+VytBRZ+8Qoq5WjP+Dae8e4CHU5Q9
c0L04wRFEYSKQkLaIYjtIPpMadlfa0eG22yJtnAG6tuKc9dM79CWQQISzX+HqqHDVbEySeT6
sO3ua9SwhPJErm43a01doGm6kgt+h0+o8v8rm5mSAFwYyKFXHEsRQwmei-uoxBpd-gx8F4lQ
EKj43mCkH-ICUFuwDq307sZCIcEXOi4ZDiopqj54KdCtCmEB9Hk6fkmfM8uZipf9ADI1AfaV
2Vd4sPDQSsP4dfOJXg9CWm6wsmNm6pv-ud2a9kQdnayRoHpEUO+-hFPFCyanKMwZB7P2J80k
+7QXuJBhA2mKCWn8A7wRaI0FZQF9gyygUO7SMfH2KkYAXRzjbAfu-+mIMGGMhEemwa8-iwP5
FhO+EZcY5nkCV9sDX-RBIne73whFs0QnhwV2teMCgAqKnh1DY8u8P4JftRHOVUj8DJm1XRiU
md0t1KIH46BcFmjmla0PpuvgnEeaE3QqiWptOSOJIGJrwLTxwzOUQx2R5azhZC5DMuAxk9sB
V6lTDv3h9Dgy8lDBKjbqYboRcAxQkXQvi11SgUjYaMtnNmoB6fcK1vZk3QZVALlL5LbV7lg8
Tx-ggIKLjr2+q+6AS-DO69SIUd2UrNkGeknTWIkmG9I1wod-8rapI6fZAz1XS03QEYulJdtx
5M+O5If-q+g-ONt4Yv9ZvF2Rf7KkY92THGUOmLQsf4pt1sr0zt7ld5q9pIL-yDOTeIo4W10D
UUn956HSUkYvBASVuylMe6MUyq3TrDeSJVx-RC4C8ZPolX4wo-YaQoiZklMh46ZKhC9At00X
LAjAIApIEy5P5CcQJjDDwf0KgFaB4qtk0e2hffS-Di1a3ZM+k+fEv4X05x5UEUqHbBsyNGYC
pW2pTo0NH4oMCCK5slVrPa7JP-d71uE9UyAEn+Q7kgy1XfXqic2IWcbIs1CEAqwHyJuDw2b8
-KXxow0vQQy3v9j9n84iI80Hac7P9tn0q+MYK7AkNmhsoAQ0V1JPE3IfsUJrrYD0doUa1+xa
HXXkmU8zwt37cnzHcuAupB0pYspsAe+6n-npkAGewCN3PtdQPBX7xHBK6EG+DaSrliI69AoH
XZSruMjCOAK-wCPZrIOy9XrB3WVyqpvaMcY+QEGehOrh2CILdggnShIfL7bC9mzTU8zXyfnf
L7qCu39WeYAur-dkVTo7odWpCKSPXi0K5uHyUd9I3fsQmoGPxVgQaOrRrbFjEYCbKvUmMjY1
+BvFNNpSrYDWUgGkFW2rDdvRg+tEG+Q+y3nJT+njbKUGITYUtx170BIJK2b5sOEhxO-vUZZk
1BLLj3HSU1yGeGD2aQzjibIka2ZjMelCAzOAPMKGvmRPg4rlha2AXKxFNGRFtRlWD55Kje7j
-+nyd2dK1vVgJh4oCUUDnv1lNamkXNWZsj5A-zI3XaZyCF8JjgCL56p-Qk1khCn9Q-87H+IV
RuscduYg8qZfDhG4ke6Wi1VMo6U0y7TCzL9WnPoPAZ7gqIjUJbB1H22V1qF8N9TxwpQz4Gvb
I6cS9VIKlmN5tQ8l4oNeT5wmYG40GHP4kB959O40QvLXIwI+Fra-+kGozvon54v9LC1kY1Uz
DhVrcV0ccOv9ORvuNebTpAndDfHxCROMUefNDw4CJ8BFIMUkXHFX117NV6sAkZCLBvmFFCcv
A+XPau7dSdSdPaLBDn-BVjk8zoANPHpl-oeqkj1ojBoPu0DPq7Lgl-eefPmLsmKKOsORwRTy
Ks9Yr6xoU99BTYAx+wi7BQrUPlJs-NYjyKrJFxQ4VAxTAaVSOko0sdbFCCqbA5BY5redtCLU
saxkzjOUq7QTuqculasOHW89uDn-Q0oVZADafzD3SnlJcdUD-W64os7ZVmAde-8R5M+xzdmq
dECSZW2maXBuqS+bk2nCo9YcRyl8sUrVxzVuLI3MV7MZP9s7npNAFiKo7xhXzqwsh3PAX6XX
Vjo50l1w34FQCqhTKIPAqRFAQnHkq4NVt3Ht9DiGuwaWhMYTyjgI772HNeB55WR5TmzmrITe
J7W-10Q9bKfKpC+9R03NCB2jHSFBbQ+esqcPIusXB+kMykyyK75olpXmKosR6Qx08hA5CHau
7H3rrnXMPvap0A0u0twxBuden6HkUgOVqzWbYAdw1W6pNWSyXOyXQnIQlWjZw5nBBJHQZ1J4
***** END OF BLOCK 4 *****



*XX3402-023714-280896--72--85-59337-----FLATMEM.ZIP--5-OF--6
IVhKaKBL6tgdb7-1RW1jIkLr55bAKIQBs0u87q8Fle7YBNziTKms-IrKxM2BwXZxDXN4xwIS
szi4uGGHcvyDvXwKeHwC4eriGOtWPBN4179Zfyx6iD6GQG5KoqWyK8MGKjlpvamC1D1q8i-b
FRWwz9nsi5rua6bwPa3sU+Qykr393WLlwpBzijglAn1L2sqa81G924FGVD-ovuA1MGVjefiD
vVi7LmJiAWn3IW71GKR4adFtNDMyBZuqLfNa3dzfioUA9hwaTrY29SoWCtI3x70MjSEASE-1
CcjtWbDJcebMzn6XOydBzAPcLZFzLcYVO3U9KwpvlfHI9Stt-CyysNJg1GxcX8jN2UO+3EDN
+PAnNqgFI4snoj5pgO4jbCkupeXgWNJX1feYlM16rGDmUkW5yg7y3-MVXa-m8m3SEz1m0WtT
7PmgI15mRV1RWRtUSBqyiB0O+mWy-S2u1bmlSefu2hsPL8B9TMm8FXGLc6nWnRl0qw-PMysV
4FQXODQZKxBZusbzIMgc2YOxyFkgLG0HmcZT6-q-SPfvgQ2pUDC5xzeyylwPMqT0GQeWkp2X
b3LcG1vMAvcX8E3godk+4LhbcXrcY1OezhOBbNrmWUO1S+TmGGKtKuRK9sgfb7QFTwzDyWCS
8oK7QCe3eNa-QuXbhaSqgzZVpWXTQPMdq9xsQtGRZBw6YyMDvZ6dJbIafC3t6wcfC4uZFxr2
b4raGxQ4D-ielfcOJCMWwkcLjKtTDxByBIW42-1NqvsqgPcBQ1mlSKHszNvurfvyLxTWlLuf
7Rs4msG14mVCspnS-H7BlJhjz+YQBSzZC6oxum5cHEYVATL1GK8gPyknoBKKmkqzIKlIMyBy
UUHmbDIw3xxZtoy-sx2b2vraLBBh8-ZjQ1zZM1XP5vNY+BNDmVJCA9tlmkYQNVRc91rl9XFc
P4b54IOOdohq+a10yoeutCBAj2--bXmMI-A2uuTij7Uiv1UPL3uvVZoB0mdic6qLP4dSYWnb
0yr0l75jNd2odB518OWTc-H15SDq6CvUYc6aVkrcNDnAK+jefFCkExPVmINomeqatJimlDNC
yadquCoXJCV8+dl7RYjqZ9VSZ8mDY-m1t7NXZopsYyQla0u3kH13OSqEWKn385NBQV8q4wpY
H8BiG4TRXH48OAYl6utYwbM1nrEAgFS69FqAiaIRX9n6J4m6kVnMDk7f7wTyL5IYBq0WrpcU
KcXZWronAZI2UpXDVcA3a3HrxueHCqkgE-EvCFtio0cbt7iUJJAF7yjcnAy5+CZUTf8nH5Jg
NGNgRLTj20TXlUGfly+WuLfuS4IDaFKE7YLW-Pyc+ujsQJkz-V4fiTlddpvvzp-9+kEI++++
0+0NGUkVdpYky363++-W2U++0U+++27-IoonAWtEEJD3JqpD4nYEzVsdzq2C6TK37I1GOri7
ya31QXGuVW60Rt2EefnNGK8lgLCqZt09yCwrsrp7c0reLI3MkZZalwwwAzNuNZ6Z5PH1EPxF
PpIf8zW6-Y5EbxInV73KpUbZ9DEUhEVCkkER0+SByat28sKpC6gGB9Je-O1bLZVEqc4PYceJ
gra0g2hEA-BL-7YGvZ8bVb-XgX7meIWG7QEO9GxTw0du1kgmWH2EjhApC7gWc9+GfEBdaEBH
CIhBd841IHc7K1OOsiW810AXZPEMMs68XL-cMKnoX3J+nta-xQPg52Rm914iEIz-a3U3t4q2
0Qdf1yORYRtqzznkMwP3g2rj3NDFMnWX47NqMyUCnvebly2bA1dpIe5p+Keb5YZ+EY5uCtKX
8kOO2j709+DEOiE1--ATEsGdI-A4ZsuKykWDEOVZdCAZX6GWm4KfdG9A07oXC6zIUsJA2V7N
dlS20pAtqtiWmTl-C-3q7-6sALdWl4kamQm7YTxUfNMPChMCanvoqgEQFoLP6oRHwduasZlk
HAXzCC054ARGGIQPGVij1PzrHUAEedU6eE8kWBsyrUUy51Orxf8xV6z0a0LoVPadjOdKPjZ3
vtW0y5hsq8pKj2KDRXvcBieEXEzPPxyqjDFco1q0hTHLHBcvvbG5iHN7rvImQz13c6V9vTTh
3g+eYPGNt4PzwtxUQ-9+14RkauYjX5FMejz4ucIlJWTBUBQIuW8CuzmjJxxjP8e5bQtLu8nC
zqPe-zTJvuDPB3eXpxiPucDnxZTcf3uWpyxkNzJBx4l-C6Fp7DTrgoVyOKx81xvbogAvicKo
QoRrjsmuL6DsiCHGHax1yeuE1XOZPoiAO3bg-AbT3CnWVHNliI3fWrAVnFfZHONBB2eX5vMP
vErdc7EmitSjetIzQCaDS9BOOHMzI9W2gYrM8gsvlW1g3jnbIOhKEfJoIzvmd68hWwghzcPo
r2ahF39vCPXJL3gN7LU+St+zpjYfj6J2KaTx7tX9sJcY8RcObDAxdd6ZHNVzhswp06vElEGP
XkKrasr5UfBCC7mVQUSwlnwBFrAQkELtr8U5Zr-lBA+7zzNIX1RSRDWtrkyDCk4QRcxU7vib
5c7vn8ocbOozdvAvqOQQkDPyzXqs7r4qwQnCPhlERy3WXY+q5c5RYwHinTD2nhzS+Nm2jRBj
knqagnHbtU5MrJJK6ykJmLyjnCdvusmxJmPXjLKWjLoOReR3UNCl0sRggyrbEnxrVaHuKEt8
IKahqLInMhpCnzwASXx4vObMZIT6gkBWZpDnHwzBffk-aNq+XEfbzw7Z6sD9CvJIKHbVQYKD
llPRXwAxdfDRjCljZVZwRlRSjudKSjqHHxpyxzUgDChxDetKtYODACNyAJzGKjp0cuDJ0kQX
YGFNrvBKqkL7nOQjM6EeyUhSYtL-pw6IrUmPWJMHeJlf-G5AdogfiFQGQKnEKX1cIgC-WdPk
GMyiVjp-w8p+O4tXNzCICxLIQi2JFXMYY9nkXd-gt+i3bKp+fDvmzKoHM8OjcRjd-H1A3qJr
d4xlKjshjzGNMysAOQ2eOwl0ro3mNuWgAya6eoPfKw66vt934sQe7ct3awaBOsHEe2TG3HLz
TJsIWsnL+NyXuPT6gEddyDQhW-R+1kTHvy0l7y2kU8B-ws7k9yw+QigK38pOYDJaUKx1Rbln
w+-axviUbaLkAxU3P+1hivhn5xDbVm1fMrPsGbsce0LVxb-bau9vEunnn9AarZuL38pp-I3k
1tUif77DCzL9sD-Vdz6A3zXYYeTWRQqKRp-QjBJn23FlpYRZ1nHvrftOyFREGkA23+++++U+
pZ2A6KGhhri20U++DlM+++c+++-GFI32HIIiJ3VIZJVvHmAt2jyzdTsCRSVok2vc-KMphq6o
oULGE9F7a8C1+8pKmCZq2chiCqiv0PZDTpJZRwUkQrSun0ARipnjyZKt-uNg4uaxwAdcADcA
9ajVlv9dkLaz45ww-O2fS-UL5synBDbmTrnG72r4lbYkQz-90OpKrY3ZM0ZS70XhdRKWlcIR
-H6MkZfJBGmZZOVBjM43Sd3dEUnyP3LtnCdImjcBgdUPC+8JmMk3p38Uh6pdEIhNUHTkfAoO
mQ1MGZdOO3rUpO0UCNAid6TGu1biJ11PE0KxI5IDr9BOYFlNSZE0XytR43rKfIAhxv6g6yh4
eZ3-vvAoCRdyO4hWs3vdmenRkLFwq+Bh6-yDDzvuWFzzWQwNr2l4Xr0h4hGaS0mUOJ5v4NdV
F6Ku0+SsMykaHFeVtI8GYn9cuorbo5BXOz94rvBXB83NeJdO-uLEl6LgWG8afNqN95z6osH6
dkBureIXwqmfTuvYf3oUOsJQH0LNldUBw9SE+xwMifKq6w81UiCAETF9K0xJiGHacWmZknoA
P90d-yq8BbutuULGZL0Ze35W3+qnofKp7qt9gtMj41dhD81t4+sAVdCWeN3T-ZBGZSKJJUcj
5KS5Q2shh+h7QpIUzM7wVqkLmbZdSuXYlxCX4Fu9Kp47aL+GF3JNIjOMDYjKG32cV5Pc4i3F
l+NCDbL5nwnQcTP8RUsBhcM+sceNntp2tTxgFMoO4Hfnowab1rUAbS0ILd08GDhSGwtEXcIn
fOtEi12QtZeJO4fJMzgg0gFzpfFSOSYsYZ7IM0mgfT6GNVho0xdbP6JTJ5I9OT4dBbeVm56Y
ft4LTDJGQxuV-tqre-VGISnkxxmOVckFAqTepayRl-bGzrsR1YHh1BGcYf-5jRJmsp1dyWVi
5sN2WGdU4+qJ6Ra1umyWPWLAoE-mxC0aC3cN-UhmZyH2bvSuN9XenpkTKFt2WgCUHyqLdZog
Cm1Xk4mDI81FKG4PSqzUhhrcs0xB0-sMXBM0sl9EUyLvhG3I8MoidEruWvcq37OTtpP8aCH-
PLUUHJ12oJ88JMwlVlEWLZSG7C2Ser477wBDBaDuDd8cECHP0Oh0qYNHCgsJ8iQNxPFYe3WP
B3YNtxGgZaX9lar-Xk4KBBZV2S0L67eGRRZuLkSf-OeH7e4aaH-u7GHwhva0MMj8Nb073b-Y
RolD2uEsFObP07kCQ6IeKY6Zj4-0ZDdhGO3FPtkdasBrAF+jV+u4yYZ+2f9nlqvQlLE8GwTg
Cxj79n2NY3CVABVF2mdO5p0-sv3ZeOUuNQE7MgUBG9s8rZpHiENIMVChR8eWsjlCx-v4xrYD
ksWFEf2J4ZSXWWBQdKmlofSq+vXjOcx8dqIYuC1xHHxqa5j1WvAoKPKSA8757FUSQ6LUUZTc
6QgmD-uliOMSWwOH0wWpu68Nh8U3pEudHHjP+2JL89zhPeoa6ZaZmImWdd9q6b7GuJEQh1E7
gwSqqx1GYDpoazR5cwRrmIS-T9CGAt+e+wp3ngU79QUb+tWFu3v24TffEsdE9qpJnTbJRksh
eh2YwiDtJpOCuqEdR3J9q1zxxFCrFl0Suu6lXi9YcH6GMx8p90fGREm2cgY-HtWJh45E6UOC
M7wmcERK9NNIgtEEn7HqIRCRBfeKf2ddhDCq9LrLkdVH87kk+ALdM4SP56SwH6gava6NiI-L
wZJKcIOc39Z680wOwk7tzu25JwLNvrYlz+DkUsvAHg7Shxl16iXqHfh04E7pjLN3nEqZvGXo
pb7ZG5dF2mNh3HDcD-jRY0OJb+iO-Pfim+ut0UWtCpl4tWcu-prgi13mt9WrVPJ+fanLkJ2M
HLHImFsXD0bB6QJbVm28TF3sTQiPx0l7oGWLyMN6naVSYnmbf8kgNILpo+p2+jvuuRD-LN3z
D1qAokj5Yokz6CwPOibiY3FbqtICe-T8UHhBwAwWdAZzQ2xcZJR3TdIl+XPWCR-ni2aXPgc+
PhH-Wb-eC-bY1mW9D7mzWaNJGnVVll0KnGF6HHZJFH0-iO327tsMlXAu-E1J1BX85WjFutXq
s6YG1Pzu1lySJ12Acv7LNJ1DmHxPGSYHcxctdljpkVmDan3v7nRHeWa8FtdciI-CwFd-kFnT
3RCiNnR-rMt54-EcydgkIwZLE2aSbJVmcQlYNsmced1htkwTwa9ssTXoy5XtFmyzS000I7on
WKmsPju5zQXgh85PpNAuTm+Lk+RsibWUzkTrBvS1ns1GSDN28F4Rsd15iRm6Gg98aVR3SQgU
xKoIz4MZCFxrOu4L7iFsqaRoX6p9OM9EPH8QVT0UHJPt9SrPzhg6QUPkl2WF7aUEYMcsi35p
-CPjKNDZyDB57rsgcjBJafVqVfO6ojxM2aQxHHish0AEHzrrsnhWRpZgtFA1dC-YyEhyViCj
BvTHzaE8xzrPmL-mFMgQwjvcjjw63xTtlKwkjQvVsaOEkzpkSUrx0RlByYKFXwx5yGpAPu16
QlVSkiDB5Em4+mXksDppTtcah58DrDA-YaKvYNzQE9aIcPRKDBO31Y7r6eGdEaOjlEOCY5OG
onJuMHkNq4ej4UmHhBNMc6apFsC6Fcd8JLfTcztvp1mW9liVlE6RsflNRMlLpb0LREnh-4N0
yr-hr6uaR1jU+P4vG+xACuhZgF8ZnC10c-euZHkQc7fR1Gx+G4oQNqlzBC79jKqsWhA2nRmM
pg7GK7dWr5CqFrD+KXWcqz8Nn0K9AcOaMRR7q3JNiDN0iBAe+j7GpX9oaAf26M10ni3xTuQR
***** END OF BLOCK 5 *****



*XX3402-023714-280896--72--85-53204-----FLATMEM.ZIP--6-OF--6
ObWvvrxruOIHLPjMaI+MHeFkBDa2+HiINT1WL8vFUsmbnghJk6dVb+kiFzrdC-zrsaIYCaMD
bSbqXgdO26mNST+4VaBVFQBu1vV5A94Kd6Z+3Ju2JE8RHm6+u0RzsuTND84+7pktcwbiwzTf
J5Hq93vBDYQsMlniOAJHr5oGXKapvsWzb-mTzj6tnhnxS2I-bj3Fyu18XjkjJnZNX1wDrbAw
zDmCC0XpNLFnwFjFjqoQRj7W37HbOrSwk5NczDJiKYlj1zOjOGO1SqDfOfzrXbiISLwvbCOX
mE2eFoTS2qrZwHJDyK1JrMEoSuQKfZzStbYowPr8KNNFjuTdS5wvWBvcC3xPqEXvb25FfZP4
mFxQhrOQ2psod6akJalyDwamLzss0zO5mxLiMM9rbqDBIgfgymJoh1w62VjxsI+TbFnyJ2ix
wAi1E5q6saX+KfHwKcfPID+mWknSWuDwM3VQXDf1QLvvvWrN25GstQxAhE3Nin1VSVdKydB5
+caJoIvBJ8rwVaLEQWIOgN0AUxnK02auNhKXSpuhx1CXImywRrFlbbVvfLIUBPwVi5Xg5ybi
nhF6C1gut86AlJhVa-LBTV-SWkYTrePENcxqjSELKVYAxz5-VtsrJuxRDBDYz13barQ-+qBE
9YaOw7mU4CfLtHx2jJe8fBL8WImIqPx2aX-SgkblHZgdJvOCyruhb1y1fzrWcXwu4jrXdQbY
EaOmOXBjWSapg8XC43Zb--6fHlXQf3feRMKo9ud2Ckt4OaM7A6eBwv8-ULmFhJZFFB2DRtBV
oIyHsyDXXqZGaBMjcHyreVH-hD1brp-9+E6I+-E++++6+6du7+1I8nFIZ+2++Bg-+++9++++
++++++++6+++++++++-4H23IHIJB9Yx0GZ-9+E6I+-E++++6+9R8102JUSkjZUY+++kY+++9
++++++++++2+6++++9o-++-4H23IHIJB9Z--Ip-9+E6I+-E++++6+04i7+-+rD0rA+I++3c9
+++A++++++++++2+6++++5k9++-IFJBIFYp3HGtEEJBEGk203++I++++0++QFEkVm9Jv2ys1
++0P1+++0k+++++++++-+0++++1K2+++FYl-J2p3HGt-IopEGk203++I++++0+-9FEkVb+bP
RQMp+++3rk++0E+++++++++-+0++++1h3+++K2pHAn+iI23HI2g-+VE+3+++++U+aIcA6ORN
ADVG-E++MV6+++c++++++++++E+U++++qYc++27-IoonAWtEEJBEGk203++I++++0+1KIEkV
N8qrSsE8+++z3U++0U+++++++++-+0++++-II+++IYJ-F2p39ZFMJ3-9-EM+++++-k+5+6k-
++++Kk++++++
***** END OF BLOCK 6 *****




