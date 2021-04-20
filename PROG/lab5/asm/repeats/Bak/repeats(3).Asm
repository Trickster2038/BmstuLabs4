         .586
         .MODEL flat
         .DATA
example_str db "str from asm"
pattern    DB    255 DUP (0)
res_lg SDWORD 0
i_reps SDWORD 0
s_length DWORD 0
s_pos DWORD 0
result  DB  255 DUP (0)
test_str  DB    255 DUP (0)
         .CODE

public _STR_REPEATS@4
externdef ?PRINT@@YGXPAD@Z:near
_STR_REPEATS@4 proc
    ;mov EBP, ESP
    XOR    EAX,EAX
    
    lea eax, example_str
    mov ebx, ESP
    mov eax, [ebx+4]
    ;========================
    
    ;code there
    
    mov ecx, 255
    mov esi, eax
    lea edi, test_str
    rep movsb
    
    mov s_length, 254
         mov res_lg, 0
         
         ;lea ESI, test_str
         mov ECX, 255
         cycle_1:
            push ECX
            
            mov s_pos, 0
            mov ECX, 255
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
                mov ECX, 255
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
    
    lea eax, result
    ;========================
    push eax
    
    call ?PRINT@@YGXPAD@Z
    ;mov ESP, EBP
    ret 4
    
_STR_REPEATS@4 endp
end

