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
MsgSeparator  DB    0AH,0DH,"=================",0AH,0DH,0
ReqStr DB 'Input string: ',13,10,0
MsgGlas DB 'glasnay found',13,10,0
MsgSogl DB 'soglasnay found',13,10,0

MsgExcep0 DB 'excep0',13,10,0
MsgExcep1 DB 'excep1',13,10,0
MsgExcep2 DB 'excep2',13,10,0

Space DB ' '
Endl db 0,0,0
MsgLn db 13,10,0
         .DATA
glasStr DB 'AEYUIOJaeyuioj'
spaceStr DB ' '
fl_glas byte 0
fl_space byte 0
fl_inword byte 0
fl_transfer byte 0
fl_loop byte 0
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
str3 DB 100 DUP (' ')
letter DB ' '
         .CODE
Start:
; 
;    Add you statements
;    code 20 - space
         XOR    EAX,EAX
         
         Invoke StdOut,ADDR ReqStr
         Invoke StdIn,ADDR str1,LengthOf str1
         
         mov fl_transfer, 0
         mov i1, 0
         mov i2, 0
         cld   
         
      glas_cycle:
         lea EDI, glasStr
         mov EBX, i1
         mov AL, str1[EBX]
         mov ECX, LengthOf glasStr
         
         
         repne scasb
            jne sogl
                ; glas branch
                Invoke StdOut,ADDR MsgGlas
                cmp fl_space, 1
                    ; turn on transfer
                    mov fl_transfer, 1
                jmp merge1
            sogl:
                Invoke StdOut,ADDR MsgSogl
                mov fl_transfer, 0
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
                    mov fl_loop, 1
                    mov AL, str1[EBX]
                    
                        cmp AL, 0
                        jne no_endl_1
                            mov fl_loop, 0   
                        no_endl_1:
                        
                        cmp AL, Space
                        jne no_space_1
                            mov fl_loop, 0    
                        no_space_1:
                        
                    cmp fl_loop, 1
                je copy_cycle
                jmp transfer_merge
                
            no_copy:
                skip_cycle:
                    inc i1
                    mov EBX, i1
                    mov AL, str1[EBX]
                        
                        cmp AL, 0
                        jne no_endl_2
                            mov fl_loop, 0   
                        no_endl_2:
                        
                        cmp AL, Space
                        jne no_space_2
                            mov fl_loop, 0    
                        no_space_2:
                        
                    cmp fl_loop, 1
                je skip_cycle
            transfer_merge:
            
          
          mov EBX, i2
          lea ESI, Space
          lea EDI, str2[EBX]
          movsb
          inc i2
          

          spaces_cycle:
            inc i1
            mov EBX, i1
            mov AL, str1[EBX]
            mov fl_loop, 1
               cmp AL, 0
               jne no_endl_3
                    mov fl_loop, 0   
               no_endl_3:
                        
               cmp AL, Space
               je space_branch_1
                    mov fl_loop, 0    
               space_branch_1:
            cmp fl_loop, 1
          je spaces_cycle
          
          ;inc i1
          mov EBX, i1
          mov AL, str1[EBX]
          cmp AL,0        
          
        jne glas_cycle
        
        
        
        
        Invoke StdOut,ADDR MsgSeparator
        Invoke StdOut,ADDR str2
          
;        Invoke StdOut,ADDR MsgSeparator
;        lea EBX, str1
;        add EBX, i1
;        Invoke StdOut,EBX
        
;        std
;        lea ESI, str2
;        add ESI, i2
;        sub ESI, 1
;        lea EDI, str3
;        mov EAX, LengthOf str3
;        add EDI, EAX
;        sub EDI, 1
        
        mov ECX, i2
        sub ECX, 1
        lea edi, str3
        reverse:
            mov AL, str2[ECX] ;55
            stosb
        loop reverse
        mov AL, str2[0] ;55
        stosb
        
        
        Invoke StdOut,ADDR MsgSeparator
        Invoke StdOut,ADDR str3
        Invoke StdOut,ADDR MsgSeparator
        
        
;        excep0:
;        Invoke StdOut,ADDR MsgExcep0
;        excep1:
;        Invoke StdOut,ADDR MsgExcep1
;        excep2:
;        Invoke StdOut,ADDR MsgExcep2
             
              	
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

