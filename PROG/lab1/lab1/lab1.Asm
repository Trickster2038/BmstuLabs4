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

         .DATA
         
A0 WORD 5, -5
         
A DWORD -30
B DWORD 21

A1 SWORD 25
A2 DWORD -35
B1 BYTE "Sergey"
B2 BYTE "Сергей"

;X1 WORD 25h
;X2 BYTE 25h,00
;X3 SWORD 100101B
;
;X4 WORD 2500h
;X5 SWORD 9472

F1 SWORD 65535
F2 SDWORD 65535

;val1 BYTE 255
;chart WORD 256
;lue3 SWORD -128
;v5 BYTE 10h
;v BYTE 100101B
;beta BYTE 23,23h,0ch
;sdk BYTE "Hello",0
;min SWORD -32767
;ar DWORD 12345678h
;valar BYTE 5 DUP (1, 2, 8)
 
         .DATA?
inbuf    DB    100 DUP (?)
X DWORD ?
alu BYTE ?

         .CODE
Start:
; 
;    Add you statements
;
mov alu, 7
        ;mov AX, 5
        ;mov Ax, -5
        mov EAX, A
        add EAX, 5
        sub EAX, B
        mov X, EAX;
        
        ;add F1, 1
        ;add F2, 1
        
        
;         XOR    EAX,EAX
;         Invoke StdOut,ADDR MsgExit
;         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
;	
;         Invoke ExitProcess,0
         End    Start

