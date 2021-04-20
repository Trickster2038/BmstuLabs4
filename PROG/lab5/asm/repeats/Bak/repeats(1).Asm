         .586
         .MODEL flat
         .DATA
example_str db "str from asm"
         .CODE

public _STR_REPEATS@4
externdef ?PRINT@@YGXPAD@Z:near
_STR_REPEATS@4 proc
    
    XOR    EAX,EAX
    
    lea eax, example_str
    mov ebx, ESP
    mov eax, [ebx+4]
    
    push eax
    call ?PRINT@@YGXPAD@Z
    ret 4
    
_STR_REPEATS@4 endp
end

