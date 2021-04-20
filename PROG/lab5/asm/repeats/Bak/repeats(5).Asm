         .586
         .MODEL flat, stdcall

         .CODE

public _STR_REPEATS
externdef print:near
_STR_REPEATS proc
    
    XOR    EAX,EAX
    call print
    ret
    
_STR_REPEATS endp
end

