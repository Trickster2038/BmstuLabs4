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
reqHello DB '=== Input 21 num for 7x3 matrix [0..6, 0..2] ===',13,10,0 
reqEcho DB '=== Echo of your input [0..6, 0..2] ===',13,10,0 
reqResult DB '=== Result [0..6, 0..2] ===',13,10,0 
MsgLn DB 0AH,0DH,0
MsgSpace DB "    ",0
RowLg WORD 3
two WORD 2
X SDWORD 4

         .DATA
Matr SDWORD 25 DUP (7)
         .DATA?
Cnt byte ?
MsgResult DB 10 DUP (?)
inbuf    DB    100 DUP (?)
buffer DB 10 DUP (?)
outstr DB 10 DUP (?)
A SWORD ?
B SWORD ?



         .CODE
Start:
; 
;    Add you statements
;
         XOR    EAX,EAX
         
         Invoke StdOut,ADDR reqHello
         
         ; input cycle
         
         mov EBX, 0
         in_cycle:
            Invoke StdOut,ADDR reqMatr
            Invoke StdIn,ADDR buffer,LengthOf buffer
            Invoke StripLF,ADDR buffer
            Invoke atol,ADDR buffer ;result in EAX
            mov Matr[EBX*4], EAX
            inc EBX
            cmp EBX,21
            jne in_cycle
            
         ; echo cycle
            
         Invoke StdOut,ADDR MsgLn   
         Invoke StdOut,ADDR reqEcho
         Invoke StdOut,ADDR MsgLn
         
         mov EBX, 0
         out1_cycle:
            Invoke dwtoa,Matr[EBX*4],ADDR outstr
            Invoke StdOut,ADDR outstr
            Invoke StdOut,ADDR MsgSpace
            
            inc EBX
            
            mov dword ptr A, EBX
            mov AX, A
            cwd ;DX:AX = AX
            idiv RowLg;AX:=(DX:AX):3
            cmp DX,0
            jne in1_row
                Invoke StdOut,ADDR MsgLn
            
;            in1_row:
;            cmp EBX,21
;            jne out1_cycle
;            
;         mov EBX, 1
;         out11_cycle:
;            mov ECX, 3
;            out12_cycle:
;                mov EAX,3
;                imul EBX               
;                imul X
;                sub EAX, ECX
;                Invoke dwtoa,Matr[EAX],ADDR outstr
;                Invoke StdOut,ADDR outstr
;                Invoke StdOut,ADDR MsgSpace
;                loop out12_cycle
;            cmp EBX,8
;            jne out11_cycle
            
         ; delete cycle
         
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
            cmp EBX,21
            jne delete_cycle
            
            
         ; result cycle
            
         Invoke StdOut,ADDR MsgLn   
         Invoke StdOut,ADDR reqResult
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
            cmp EBX,21
            jne out_cycle
            
          
         Invoke StdOut,ADDR MsgLn            
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

