         .586
         .MODEL flat

         .CODE

public _STR_REPEATS@0
externdef ?PRINT@@YGXXZ:near
_STR_REPEATS@0 proc
    
    XOR    EAX,EAX
    call ?PRINT@@YGXXZ
    ret
    
_STR_REPEATS@0 endp
end

