         .586
         .MODEL flat, stdcall

         .CODE

public _STR_REPEATS@0
externdef print:near
_STR_REPEATS@0@0 proc
    
    XOR    EAX,EAX
    call print
    ret
    
_STR_REPEATS@0@0 endp
end

