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
A SWORD ?
B SWORD ?
K SWORD ?

dbgOut SWORD ?
ab SWORD ?
K2add2 SWORD ?
B3 SWORD ?
fraction SWORD ?
result SWORD ?

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
         mov dword ptr A, EAX
         
         Invoke StdOut,ADDR reqB
         Invoke StdIn,ADDR buffer,LengthOf buffer
         Invoke StripLF,ADDR buffer
         Invoke atol,ADDR buffer ;result in EAX
         mov dword ptr B, EAX
         
         Invoke StdOut,ADDR reqK
         Invoke StdIn,ADDR buffer,LengthOf buffer
         Invoke StripLF,ADDR buffer
         Invoke atol,ADDR buffer ;result in EAX
         mov dword ptr K, EAX
         
         mov AX, A
         imul B     ;DX:AX:=AX*B=A*B
         mov ab, AX
         
         mov AX, K
         imul K    ;DX:AX:=AX*K=K*K
         add AX, 2
         mov K2add2, AX
         
         Invoke dwtoa,K2add2,ADDR outstr
         Invoke StdOut,ADDR outstr
         Invoke StdOut,ADDR MsgLn
         
         mov AX, B
         imul B    ;DX:AX:=AX*B=B
         imul B    ;DX:AX:=AX*B=B*B
         mov B3, AX
         
         mov AX, B3
         cwd ;DX:AX = AX
         idiv  K2add2 ;AX:=(DX:AX):K2add2
         mov fraction, AX
         
         mov AX, ab
         add AX, fraction
         mov result, AX
         
         Invoke dwtoa,A,ADDR outstr
         Invoke StdOut,ADDR outstr
         Invoke StdOut,ADDR MsgLn
         
         Invoke dwtoa,B,ADDR outstr
         Invoke StdOut,ADDR outstr
         Invoke StdOut,ADDR MsgLn
         
         Invoke dwtoa,K,ADDR outstr
         Invoke StdOut,ADDR outstr
         Invoke StdOut,ADDR MsgLn
         
         Invoke dwtoa,result,ADDR outstr
         Invoke StdOut,ADDR outstr
         Invoke StdOut,ADDR MsgLn
         
         
         
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

