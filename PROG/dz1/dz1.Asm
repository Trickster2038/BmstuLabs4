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
reqStr DB 'Input string: ',13,10,0

         .DATA

         .DATA?
inbuf    DB    100 DUP (?)
str1 DB 100 DUP (?)
         .CODE
Start:
; 
;    Add you statements
;
         XOR    EAX,EAX
         
         Invoke StdOut,ADDR ReqStr
         Invoke StdIn,ADDR str1,LengthOf str1	
        
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

