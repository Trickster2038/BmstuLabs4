         .586
         .MODEL flat
         .DATA
example_str db "str from asm"
         .CODE

public _STR_REPEATS@0
externdef ?PRINT@@YGXPAD@Z:near
_STR_REPEATS@0 proc
    
    XOR    EAX,EAX
    lea eax, example_str
    push eax
    call ?PRINT@@YGXPAD@Z
    ret
    
_STR_REPEATS@0 endp
end

