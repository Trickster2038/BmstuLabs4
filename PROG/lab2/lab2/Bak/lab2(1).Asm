; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0
MsgInp   DB    "Enter number",0AH,0DH,0
MsgLn DB 0AH,0DH,0

         .DATA
reqA DB 'Input A: ',13,10,0 ; запрос
reqB DB 'Input B: ',13,10,0 
reqK DB 'Input K: ',13,10,0 
buffer DB 10 dup ('0') ; буфер ввода

         .DATA?
inbuf    DB    100 DUP (?)
outstr DB 10 DUP (?)
A SDWORD ?
B SDWORD ?
K SDWORD ?

         .CODE
Start:
; 
;    Add you statements
;
         ;Invoke StdOut,ADDR MsgInp
         XOR    EAX,EAX
         Invoke StdOut,ADDR reqA
         Invoke StdIn,ADDR buffer,LengthOf buffer
         Invoke StripLF,ADDR buffer
         Invoke atol,ADDR buffer ;result in EAX
         mov A, EAX
         
         Invoke StdOut,ADDR reqB
         Invoke StdIn,ADDR buffer,LengthOf buffer
         Invoke StripLF,ADDR buffer
         Invoke atol,ADDR buffer ;result in EAX
         mov B, EAX
         
         Invoke StdOut,ADDR reqK
         Invoke StdIn,ADDR buffer,LengthOf buffer
         Invoke StripLF,ADDR buffer
         Invoke atol,ADDR buffer ;result in EAX
         mov K, EAX
         
         
         
         Invoke dwtoa,A,ADDR outstr
         Invoke StdOut,ADDR outstr
         Invoke StdOut,ADDR MsgLn
         
         Invoke dwtoa,B,ADDR outstr
         Invoke StdOut,ADDR outstr
         Invoke StdOut,ADDR MsgLn
         
         Invoke dwtoa,K,ADDR outstr
         Invoke StdOut,ADDR outstr
         Invoke StdOut,ADDR MsgLn
         
         
         
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

