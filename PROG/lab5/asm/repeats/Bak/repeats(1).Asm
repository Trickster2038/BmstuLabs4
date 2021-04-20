         .586
         .MODEL flat, stdcall

         .CODE

public STR_REPEATS
externdef ?PRINT@@YGXXZ:near
STR_REPEATS proc
    
    XOR    EAX,EAX
    call ?PRINT@@YGXXZ
    ret
    
STR_REPEATS endp
end

