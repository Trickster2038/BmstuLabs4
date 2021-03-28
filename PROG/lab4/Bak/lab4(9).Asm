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
reqMatr DB 'Input num: ',13,10,0 
MsgLn DB 0AH,0DH,0
MsgSpace DB "    ",0

         .DATA

         .DATA?
Cnt byte ?
MsgResult DB 10 DUP (?)
inbuf    DB    100 DUP (?)
buffer DB 10 DUP (?)
outstr DB 10 DUP (?)
Matr SDWORD 25 DUP (?)
A SWORD ?
B SWORD ?

         .CODE
Start:
; 
;    Add you statements
;
         XOR    EAX,EAX
         
         mov EBX, 0
         in_cycle:
            Invoke StdOut,ADDR reqMatr
            Invoke StdIn,ADDR buffer,LengthOf buffer
            Invoke StripLF,ADDR buffer
            Invoke atol,ADDR buffer ;result in EAX
            mov Matr[EBX*4], EAX
            inc EBX
            cmp EBX,3
            jne in_cycle
            
         Invoke StdOut,ADDR MsgExit
            
         mov EBX, 0
         out_cycle:
            Invoke dwtoa,Matr[EBX*4],ADDR outstr
            Invoke StdOut,ADDR outstr
            Invoke StdOut,ADDR MsgLn
            inc EBX
            cmp EBX,3
            jne in_cycle
            
          
                      
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

