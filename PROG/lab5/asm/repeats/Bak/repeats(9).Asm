         .586
         .MODEL flat

         .CODE

public _STR_REPEATS@0
externdef print:near
_STR_REPEATS@0 proc
    
    XOR    EAX,EAX
    call print
    ret
    
_STR_REPEATS@0 endp
end

