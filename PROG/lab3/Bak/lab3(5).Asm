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
MsgZeroMulti  DB    "Division by zero (a*b)",0AH,0DH,0
MsgZeroSub DB    "Division by zero (a-b)",0AH,0DH,0
MsgZeroResult1 DB    "Result f=(a+b)/(a-b)",0AH,0DH,0
MsgZeroResult2 DB    "Result f= -120/(a*b)",0AH,0DH,0
MsgLn DB 0AH,0DH,0
reqA DB 'Input A: ',13,10,0 
reqB DB 'Input B: ',13,10,0 

         .DATA

         .DATA?
inbuf    DB    100 DUP (?)
outstr DB 10 DUP (?)
A SWORD ?
B SWORD ?
ab SWORD ?
sum_ab SWORD ?
sub_ab SWORD ?
f1_result SWORD ?
         .CODE
Start:
; 
;    Add you statements
;
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
         
         mov AX, A
         imul B     ;DX:AX:=AX*B=A*B
         mov ab, AX
         
         cmp ab, 0
         jng negative_ab
            cmp A, B
            jne f1_branch
                Invoke StdOut,ADDR MsgZeroSub
                jmp right_merge
            f1:
                mov AX, A
                add AX, B
                mov sum_ab, Ax
                mox AX, A
                sub AX, B
                mov sub_ab, AX
                
                mov AX, sum_ab
                cwd ;DX:AX = AX
                idiv sub_ab ;AX:=(DX:AX):sub_ab
                mov f1_result, AX
                
                Invoke dwtoa,f1_result,ADDR outstr
                Invoke StdOut,ADDR outstr
                Invoke StdOut,ADDR MsgLn
            right_merge:
                jmp main_merge
          
          negative_ab:
            cmp ab, 0
            jne f2      
          
            
               
            
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf	
         
         Invoke ExitProcess,0
         End    Start

