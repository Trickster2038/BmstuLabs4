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
ReqStr DB 'Input string: ',13,10,0
glasStr DB 'EYUIOAJ'
spaceStr DB ' '

         .DATA
fl_glas byte 0
fl_space byte 0
fl_inword byte 0
         .DATA?
Cnt dword 10
glasN dword 10
inbuf    DB    100 DUP (?)
str1 DB 100 DUP (?)
str2 DB 100 DUP (?)
letter DB ' '
         .CODE
Start:
; 
;    Add you statements
;    code 20 - space
         XOR    EAX,EAX
         
         Invoke StdOut,ADDR ReqStr
         Invoke StdIn,ADDR str1,LengthOf str1
         
         lea ESI, str1
         lea EDI, str2
         
         mov glasN, LengthOf glasStr ;8
         mov Cnt, 0
         cycle:
            mov EBX, Cnt
            mov AL, glasStr[EBX]
            push ESI;push
            repne scasb ; equals if symb found
            pop ESI
                jne skip
                    ;pop ESI;pop 
                    mov AL, spaceStr
                    cycle2: 
                        movsb
                        mov AL, spaceStr
                        scasb 
                        jne cycle2 ; equals if space, else - loop
            skip:    
            mov EBX, Cnt
            cmp EBX, glasN
            jne cycle      
              	
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

