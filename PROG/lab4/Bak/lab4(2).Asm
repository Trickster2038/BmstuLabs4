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
two_sizes WORD 8 ;=2*4bytes
_3 WORD 3
X SDWORD 4

         .DATA
Matr SDWORD 5 DUP (1,-2,-3,4,5)
log db 20 dup (?)
         .DATA?
Cnt byte ?
MsgResult DB 10 DUP (?)
inbuf    DB    100 DUP (?)
buffer DB 10 DUP (?)
outstr DB 10 DUP (?)
A SWORD ?
B SWORD ?
i SDWORD ?
j SDWORD ?
res SDWORD ?



         .CODE
Start:
; 
;    Add you statements
;
         XOR    EAX,EAX
         
         Invoke StdOut,ADDR reqHello
         
;=================== input cycle ================
          
;          mov i,0
;          mov j,0
;          alt_out_cycle0:
;              mov j,0
;              ;Invoke StdOut,ADDR MsgLn
;              alt_in_cycle0:
;                              
;                Invoke StdOut,ADDR reqMatr
;                Invoke StdIn,ADDR buffer,LengthOf buffer
;                Invoke StripLF,ADDR buffer
;                Invoke atol,ADDR buffer ;result in EAX
;                
;                mov EBX,i
;                mov ECX,j
;                
;                mov Matr[EBX+ECX], EAX
;                ;Invoke dwtoa,Matr[EBX+ECX],ADDR outstr
;                ;Invoke StdOut,ADDR outstr
;                ;Invoke StdOut,ADDR MsgSpace
;                add j,4
;                cmp j,12
;              jl alt_in_cycle0
;            add i,12
;            cmp i,84
;            jl alt_out_cycle0
            
;=========== echo cycle =============================
            
         Invoke StdOut,ADDR MsgLn   
         Invoke StdOut,ADDR reqEcho
         Invoke StdOut,ADDR MsgLn
          
          mov i,0
          mov j,0
          alt_out_cycle:
              mov j,0
              Invoke StdOut,ADDR MsgLn
              alt_in_cycle:
                mov EBX,i
                mov ECX,j
                Invoke dwtoa,Matr[EBX+ECX],ADDR outstr
                Invoke StdOut,ADDR outstr
                Invoke StdOut,ADDR MsgSpace
                add j,4
                cmp j,12
              jl alt_in_cycle
            add i,12
            cmp i,84
            jl alt_out_cycle
            
          Invoke StdOut,ADDR MsgLn
;========== deleting cycle =========

        mov i,0
        mov j,0
          alt_out_cycle1:
              mov j,0
              ;Invoke StdOut,ADDR MsgLn
              alt_in_cycle1:
                
                mov EBX,i
                mov ECX,j
                ;mov EAX,0
                mov EAX, i
                
                
                cwd ;DX:AX = AX
                idiv _3;AX:=(DX:AX):2   DX = remain
                add EAX,j
                cwd ;DX:AX = AX
                
                ;mov res, EAX
                
                idiv two_sizes;AX:=(DX:AX):2   DX = remain
                cmp DX,0
                jne odd
                    mov Matr[EBX+ECX], 0
                odd: ; x%2 = 1
                
                ;Invoke dwtoa,res,ADDR log
                ;Invoke StdOut,ADDR MsgLn
                ;Invoke StdOut,ADDR log
                
                add j,4
                cmp j,12
              jl alt_in_cycle1
            add i,12
            cmp i,84
            jl alt_out_cycle1
            
         
;=========== output result ============

            
         Invoke StdOut,ADDR MsgLn   
         Invoke StdOut,ADDR reqResult
         Invoke StdOut,ADDR MsgLn

         mov i,0
          mov j,0
          alt_out_cycle2:
              mov j,0
              Invoke StdOut,ADDR MsgLn
              alt_in_cycle2:
                mov EBX,i
                mov ECX,j
                Invoke dwtoa,Matr[EBX+ECX],ADDR outstr
                Invoke StdOut,ADDR outstr
                Invoke StdOut,ADDR MsgSpace
                add j,4
                cmp j,12
              jl alt_in_cycle2
            add i,12
            cmp i,84
            jl alt_out_cycle2
            
          Invoke StdOut,ADDR MsgLn
            
          
         Invoke StdOut,ADDR MsgLn            
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

