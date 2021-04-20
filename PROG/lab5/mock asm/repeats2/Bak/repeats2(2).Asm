; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0
MsgLn  DB    0AH,0DH,0
MsgOutc DB    "(out)",0
MsgInc DB    "(in)",0
test_str  DB    "abc abc abcd 12345678",0

         .DATA
s_length DWORD 0
s_pos DWORD 0
         .DATA?
inbuf    DB    100 DUP (?)
test_out    DB    100 DUP (?)
pattern    DB    100 DUP (?)

         .CODE
Start:
; 
;    Add you statements
;   
;    max - 10
         XOR    EAX,EAX
         
         mov s_length, 14
         
         ;lea ESI, test_str
         mov ECX, 15
         cycle_1:
            push ECX
            
            mov s_pos, 0
            mov ECX, 15
            sub ECX, s_length
            cycle_2:
                push ECX
            
                lea ESI, test_str
                lea EDI, pattern
                add ESI, s_pos
                ;code
                mov ECX, s_length
                rep movsb
                
                mov AL, 0
                stosb
                
                push esi
                push edi
                Invoke StdOut,ADDR pattern
                Invoke StdOut,ADDR MsgLn
                ;Invoke StdOut,ADDR MsgInc
                ;Invoke StdOut,ADDR MsgLn
                pop esi
                pop edi
            
                pop ECX
                inc s_pos
            loop cycle_2 
            
            dec s_length
            ;Invoke StdOut,ADDR MsgOutc
            ;Invoke StdOut,ADDR MsgLn
            pop ECX
            dec ECX
            cmp ECX,0
         jne cycle_1
         
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

