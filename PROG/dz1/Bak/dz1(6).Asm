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
MsgEmpty  DB    0AH,0DH,"Result is empty",0AH,0DH,0
MsgSeparator  DB    0AH,0DH,"==================",0AH,0DH,0
MsgSeparator1  DB    0AH,0DH,"===1==============",0AH,0DH,0
MsgSeparator2  DB    0AH,0DH,"===2==============",0AH,0DH,0
MsgSeparator3  DB    0AH,0DH,"===3==============",0AH,0DH,0
MsgSeparator4 DB    0AH,0DH,"===4==============",0AH,0DH,0
MsgSeparator5 DB    0AH,0DH,"===5==============",0AH,0DH,0
MsgTraceSg DB    0AH,0DH,"==sogl============",0AH,0DH,0
MsgTick DB    0AH,0DH,">>>>",0AH,0DH,0
MsgSep DB    '|',0
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
log DB ' '
glasStr DB 'AEYUIOJaeyuioj'
soglStr DB 'QWRTPSDFGHKLZXCVBNMqwrtpsdfgklzxcvbnm'
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
i3 dword 0
i4 dword 0
i5 dword 0
i6 dword 0
Cnt dword 10
glasN dword 10
inbuf    DB    100 DUP (?)
str1 DB 100 DUP (?)
str2 DB 100 DUP (?)
str3 DB 100 DUP (?)
str4 DB 100 DUP (?)
str5 DB 100 DUP (?)
str6 DB 100 DUP (?)
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
                ;Invoke StdOut,ADDR MsgGlas
                cmp fl_space, 1
                    ; turn on transfer
                    mov fl_transfer, 1
                jmp merge1
            sogl:
                ;Invoke StdOut,ADDR MsgSogl
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
                    mov fl_loop, 1 ; skip fl
                        
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
          
          mov EBX, i1
          mov AL, str1[EBX]
          cmp AL,0             
        jne glas_cycle
        
        ; empty check
         lea EDI, str2
         mov AL, Space
         mov ECX, i2
         repe scasb
         
     je empty_str2
        
        Invoke StdOut,ADDR MsgSeparator1
        Invoke StdOut,ADDR str2 
        
        ; reverse    
        mov ECX, i2
        sub ECX, 1
        lea edi, str3
        reverse:
            mov AL, str2[ECX] 
            stosb
        loop reverse
        mov AL, str2[0] 
        stosb
        
        Invoke StdIn,ADDR inbuf,LengthOf inbuf 
        Invoke StdOut,ADDR MsgSeparator2
        Invoke StdOut,ADDR str3
        
        
;sogl on endl handler cycle

mov i3, 0
mov i4, 0
mov fl_transfer, 0

sogl_cycle:
         lea EDI, soglStr
         mov EBX, i3
         mov AL, str3[EBX]
         mov ECX, LengthOf soglStr
         
         
         repne scasb
            je sogl2
                ; glas branch
                ; turn off transfer
                mov fl_transfer, 0
                jmp merge2
            sogl2:
                Invoke StdOut,ADDR MsgTraceSg
                mov fl_transfer, 1
            merge2:
            
            mov fl_space, 0
            
            cmp fl_transfer,1
            jne no_copy2
                copy_cycle2:
                    mov EBX, i3
                    lea ESI, str3[EBX]
                    mov EBX, i4
                    lea EDI, str4[EBX]
                    movsb 
                    inc i3
                    inc i4
                    mov EBX, i3
                    mov fl_loop, 1
                    mov AL, str3[EBX]
                    
                        cmp AL, 0
                        jne no_endl_4
                            mov fl_loop, 0   
                        no_endl_4:
                        
                        cmp AL, Space
                        jne no_space_3
                            mov fl_loop, 0    
                        no_space_3:
                        
                    cmp fl_loop, 1
                je copy_cycle2
                jmp transfer_merge2
                
            no_copy2:
                skip_cycle2:
                    inc i1
                    mov EBX, i3
                    mov AL, str3[EBX]
                    
                        cmp AL, 0
                        jne no_endl_5
                            mov fl_loop, 0   
                        no_endl_5:                        
                        cmp AL, Space
                        jne no_space_4
                            mov fl_loop, 0    
                        no_space_4:
                        
                    cmp fl_loop, 1
                je skip_cycle2
            transfer_merge2:
            
          ;skip fl - on end to solve 1st elem problem
          mov fl_loop, 1
          
          mov EBX, i4
          lea ESI, Space
          lea EDI, str4[EBX]
          movsb
          inc i4
          

          spaces_cycle2:
            inc i3
            mov EBX, i3
            mov AL, str3[EBX]
            mov fl_loop, 1
               cmp AL, 0
               jne no_endl_6
                    mov fl_loop, 0   
               no_endl_6:
                        
               cmp AL, Space
               je space_branch_2
                    mov fl_loop, 0    
               space_branch_2:
            cmp fl_loop, 1
          je spaces_cycle2
          
          mov EBX, i3
          mov AL, str3[EBX]
          cmp AL,0        
          
        jne sogl_cycle
        
        Invoke StdIn,ADDR inbuf,LengthOf inbuf 
        Invoke StdOut,ADDR MsgSeparator3
        Invoke StdOut,ADDR str4
        
        mov ECX, i4
        sub ECX, 1
        lea edi, str5
        reverse2:
            mov AL, str4[ECX] 
            stosb
        loop reverse2
        mov AL, str4[0] 
        stosb
        
        Invoke StdIn,ADDR inbuf,LengthOf inbuf  
        Invoke StdOut,ADDR MsgSeparator4
        Invoke StdOut,ADDR str5
        
        mov EAX, i4
        mov i5, EAX 
             
       ; removing additional spaces cycle
       mov i6, 0
       mov i5, 0
       
       big_spaces_cycle:
         lea EDI, glasStr
         mov EBX, i5
         mov AL, str5[EBX]
         ;mov ECX, LengthOf glasStr
         
            mov fl_space, 0
            
                copy_cycle3:
                    mov EBX, i5
                    lea ESI, str5[EBX]
                    mov EBX, i6
                    lea EDI, str6[EBX]
                    movsb 
                    inc i5
                    inc i6
                    mov EBX, i5
                    mov fl_loop, 1 ;cycle fl
                    mov AL, str5[EBX]               
                        cmp AL, 0
                        jne no_endl_7
                            mov fl_loop, 0   
                        no_endl_7:
                        
                        cmp AL, Space
                        jne no_space_5
                            mov fl_loop, 0    
                        no_space_5:
                        
                    cmp fl_loop, 1
                je copy_cycle3
            
          
          mov EBX, i6
          lea ESI, Space
          lea EDI, str6[EBX]
          movsb
          inc i6      

          spaces_cycle3:
            inc i5
            mov EBX, i5
            mov AL, str5[EBX]
            mov fl_loop, 1
               cmp AL, 0
               jne no_endl_8
                    mov fl_loop, 0   
               no_endl_8:
                        
               cmp AL, Space
               je space_branch_3
                    mov fl_loop, 0    
               space_branch_3:
            cmp fl_loop, 1
          je spaces_cycle3
          
          mov EBX, i5
          mov AL, str5[EBX]
          cmp AL,0        
          
        jne big_spaces_cycle
       
       ;=============================
       
         ; empty check   
         lea EDI, str6
         mov AL, Space
         mov ECX, i6
         repe scasb
     je empty_str6
       
        Invoke StdIn,ADDR inbuf,LengthOf inbuf
       
        Invoke StdOut,ADDR MsgSeparator5
        Invoke StdOut,ADDR str6
        Invoke StdOut,ADDR MsgSeparator
        jmp exit_point
     empty_str6:   
     empty_str2: 
        Invoke StdOut,ADDR MsgEmpty
     exit_point:
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

