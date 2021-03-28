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
reqHello DB '=== Input 21 num for 7x3 matrix ===',13,10,0 
reqEcho DB '=== Echo of your input ===',13,10,0 
reqResult DB '=== Result ===',13,10,0 
MsgLn DB 0AH,0DH,0
MsgSpace DB "    ",0
RowLg WORD 3
two WORD 2

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
         
         Invoke StdOut,ADDR reqHello
         
         mov EBX, 0
         in_cycle:
            Invoke StdOut,ADDR reqMatr
            Invoke StdIn,ADDR buffer,LengthOf buffer
            Invoke StripLF,ADDR buffer
            Invoke atol,ADDR buffer ;result in EAX
            mov Matr[EBX*4], EAX
            inc EBX
            cmp EBX,6
            jne in_cycle
            
         Invoke StdOut,ADDR MsgLn   
         Invoke StdOut,ADDR reqEcho
         Invoke StdOut,ADDR MsgLn
         
         mov EBX, 0
         delete_cycle:  
            mov dword ptr A, EBX
            mov AX, A
            cwd ;DX:AX = AX
            idiv RowLg;AX:=(DX:AX):3  DX = remain
            
            add AX, DX
            cwd ;DX:AX = AX
            idiv two;AX:=(DX:AX):2   DX = remain
            
            cmp DX,0
            jne odd
                mov Matr[EBX*4], 0
            
            odd: ; x%2 = 1
            inc EBX
            cmp EBX,6
            jne delete_cycle
            
            
         Invoke StdOut,ADDR MsgLn   
         Invoke StdOut,ADDR reqEcho
         Invoke StdOut,ADDR MsgLn
            
         mov EBX, 0
         out_cycle:
            Invoke dwtoa,Matr[EBX*4],ADDR outstr
            Invoke StdOut,ADDR outstr
            Invoke StdOut,ADDR MsgSpace
            
            inc EBX
            
            mov dword ptr A, EBX
            mov AX, A
            cwd ;DX:AX = AX
            idiv RowLg;AX:=(DX:AX):3
            cmp DX,0
            jne in_row
                Invoke StdOut,ADDR MsgLn
            
            in_row:
            cmp EBX,6
            jne out_cycle
            
          
         Invoke StdOut,ADDR MsgLn            
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

