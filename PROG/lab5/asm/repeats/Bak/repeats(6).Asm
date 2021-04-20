         .586
         .MODEL flat, stdcall

         .CODE

public _STR_REPEATS
externdef print:near
STR_REPEATS proc
    
    XOR    EAX,EAX
    call print
    ret
    
STR_REPEATS endp
end

