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
MsgGlas DB 'glasnay found',13,10,0
MsgSogl DB 'soglasnay found',13,10,0
Space DB ' '
         .DATA
glasStr DB 'AEYUIOJaeyuioj'
spaceStr DB ' '
fl_glas byte 0
fl_space byte 0
fl_inword byte 0
fl_transfer byte 0
         .DATA?
ESIarch dword 0
EDIarch dword 0
i1 dword 0
i2 dword 0
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
         mov fl_space, 1 ;test
         
         mov i1, 0
         mov i2, 0
         lea EDI, glasStr
         mov EBX, i1
         mov AL, str1[EBX]
         mov ECX, LengthOf glasStr
         repne scasb
            jne sogl
                ; glas branch
                Invoke StdOut,ADDR MsgGlas
                cmp fl_space, 1
                jne skip1
                    ; turn on transfer
                    mov fl_transfer, 1
                skip1:
                jmp merge1
            sogl:
                Invoke StdOut,ADDR MsgSogl
            merge1:
            
            mov fl_space, 0
            
            cmp fl_transfer,1
            jne no_copy
                copy_cycle:
                    mov EBX, i1
                    lea ESI, str1[EBX]
                    mov EBX, i2
                    lea EDI, str2[EBX]
                    movsb 
                    inc i1
                    inc i2
                    mov EBX, i1
                    mov AL, str1[EBX]
                    cmp AL, Space
                jne copy_cycle
                jmp transfer_merge
            no_copy:
                skip_cycle:
                    inc i1
                    mov EBX, i1
                    mov AL, str1[EBX]
                    cmp AL, Space
                jne skip_cycle
            transfer_merge:
            
          
          mov EBX, i2
          lea EDI, Space
          lea EDI, str2[EBX]
          movsb
          inc i2
          
          Invoke StdOut,ADDR str2
          
          spaces_cycle:
            inc i1
            mov EBX, i1
            mov AL, str1[EBX]
            cmp AL, Space
          je spaces_cycle
            
          
            
;         mov glasN, LengthOf glasStr ;8
;         mov Cnt, 0
;         cycle:
;            mov EBX, Cnt
;            mov AL, glasStr[EBX]
;            mov ESIarch, ESI;push
;            mov EDIarch, EDI
;            mov EDI, ESI
;            repne scasb ; equals if symb found
;            mov ESI, EDI
;            mov EDI, EDIarch
;                jne skip
;                    ; if glas - copy till space; else -skip
;                    ;pop ESI;pop 
;                    mov AL, spaceStr
;                    cycle2: 
;                        movsb
;                        mov AL, spaceStr
;                        push EDI
;                        scasb
;                        pop EDI
;                        jne cycle2 ; equals if space, else - loop
;            skip:    
;            mov EBX, Cnt
;            cmp EBX, glasN
;            jne cycle      
              	
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

