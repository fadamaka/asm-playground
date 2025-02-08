section .data
    hello db 'Hello, World!', 0  
    helloLen equ $ - hello        

section .text
    global main
    extern ExitProcess, WriteConsoleA, GetStdHandle

main:
    sub rsp, 28h               
    mov rcx, -11                
    call GetStdHandle

    ; Escribir el mensaje en la consola
    mov r9, 0                
    mov r8, helloLen          
    mov rdx, hello            
    mov rcx, rax               
    call WriteConsoleA        

    ; Terminar el programa
    mov rcx, 0                 
    call ExitProcess    

;https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-readfile
;resources.md
