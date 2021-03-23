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

         .DATA
a word 2
b word 7
cc word 9
         .DATA?
inbuf    DB    100 DUP (?)
x sdword ?

         .CODE
Start:
; 
;    Add you statements
;
         XOR    EAX,EAX
         mov x, 77h
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

