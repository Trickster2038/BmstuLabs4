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
MsgLn  DB    0AH,0DH,0
MsgLog  DB    "~",0
MsgOutc DB    "(out)",0
MsgInc DB    "(in)",0
MsgResult DB    "Result",0AH,0DH,0
test_str  DB    "abc abc abcd 12345678",0

         .DATA
res_lg SDWORD 0
i_reps SDWORD 0
s_length DWORD 0
s_pos DWORD 0
result  DB  100 DUP (0)
         .DATA?
inbuf    DB    100 DUP (?)
test_out    DB    100 DUP (?)
outstr  DB    100 DUP (?)
pattern    DB    100 DUP (?)

         .CODE
Start:
; 
;    Add you statements
;   
;    20 -> 255
         XOR    EAX,EAX
        
         
         mov s_length, 19
         mov res_lg, 0
         
         ;lea ESI, test_str
         mov ECX, 20
         cycle_1:
            push ECX
            
            mov s_pos, 0
            mov ECX, 20
            sub ECX, s_length
            cycle_2:
                push ECX
            
                lea ESI, test_str
                lea EDI, pattern
                add ESI, s_pos
                ;code
                mov ECX, s_length
                rep movsb
                
                mov AL, 0
                stosb
                
                push esi
                push edi
                ;Invoke StdOut,ADDR pattern
                ;Invoke StdOut,ADDR MsgLn
                ;Invoke StdOut,ADDR MsgInc
                ;Invoke StdOut,ADDR MsgLn
                pop esi
                pop edi
                
                mov i_reps, 0 
                mov s_pos, 0
                mov ECX, 20
                sub ECX, s_length
                cycle_3:
                    push ECX
                    lea ESI, test_str
                    lea EDI, pattern
                    add ESI, s_pos
                    
                    mov ECX, s_length
                    repe cmpsb
                    jne skip
                        inc i_reps
                        ;mov EAX, i_reps
                        ;Invoke StdOut,ADDR MsgLog
                        ;Invoke dwtoa,i_reps,ADDR outstr
                        ;Invoke StdOut,ADDR outstr
                        ;Invoke StdOut,ADDR MsgLn
                        
                        cmp i_reps, 2
                        jne skip_2
                            mov EAX, res_lg
                            mov EBX, s_length
                            cmp EBX, EAX
                            jl skip_3              ; here we can change first or last
                                mov ECX, s_length
                                lea ESI, pattern
                                lea EDI, result
                                rep movsb
                                mov AL,0
                                stosb
                                mov EAX, s_length
                                mov res_lg, EAX
                            skip_3:
                        skip_2:
                        ;mov ECX, s_length
                        ;lea ESI, pattern
                        ;lea EDI, result
                        ;rep movsb
                        ;jmp final
                    skip:
                    
                    pop ECX
                    inc s_pos
                    dec ECX
                    cmp ECX, 0
                    jne cycle_3
            
                pop ECX
                inc s_pos
                dec ECX
                cmp ECX, 0
            jne cycle_2 
            
            dec s_length
            ;Invoke StdOut,ADDR MsgOutc
            ;Invoke StdOut,ADDR MsgLn
            pop ECX
            dec ECX
            cmp ECX,0
         jne cycle_1
         
         
         final:
         Invoke StdOut,ADDR MsgResult
         Invoke StdOut,ADDR result
         Invoke StdOut,ADDR MsgLn
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

