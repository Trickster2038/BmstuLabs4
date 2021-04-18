;extern "C" void __stdcall str_repeats();
         .586
         .MODEL  flat
         comment $
Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib$

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0

         .DATA

         .DATA?
inbuf    DB    100 DUP (?)

         .CODE
         comment $
Start:
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start $
public _str_repeats@0
_str_repeats@0 proc
    
    XOR    EAX,EAX
    ret
    
_str_repeats@0 endp
end

