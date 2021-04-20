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
    pop ebx
    mov eax, ebx
    push eax
    call ?PRINT@@YGXPAD@Z
    ret
    
_STR_REPEATS@4 endp
end

