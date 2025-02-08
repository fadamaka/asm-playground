section .data
    hello db 'Hello, World!', 0  
    helloLen equ $ - hello        
    filename db "f.txt", 0

section .bss
buffer resb 255,


section .text
    global main
    extern ExitProcess, WriteConsoleA, GetStdHandle, CreateFileA, ReadFile

main:
    sub rsp, 48h

    mov rcx, filename   
    mov dword [rsp+40], 40000000h | 2 
    xor r9d, r9d       
    xor r8d, r8d      
    mov dword [rsp+32], 2 
    mov edx, 2
    call CreateFileA

afteropen:
    mov r9, 0
    mov r8, 10
    mov rdx, buffer
    mov rcx, rax
    call ReadFile
    
    mov rax, rbx

    mov rcx, -11                
    call GetStdHandle

    mov r9, 0                
    mov r8, 100          
    mov rdx, rbx            
    mov rcx, rax               
    call WriteConsoleA        
    
    mov rcx, 0                 
    call ExitProcess    

;https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-readfile
;resources.md
