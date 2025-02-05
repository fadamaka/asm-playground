# https://retrocoding.net/windows-hello-world-in-x8664
.code64
.section .rodata
msg: .ascii "Hello, World!\n"
.set msglen, (. - msg)

.extern GetStdHandle 
.extern WriteFile
.extern ExitProcess 

.set STD_OUTPUT_HANDLE, -11 

.section .data 

stdout: .long 0 
bytes_written: .long 0 

.section .text
.global _start 
_start:
    sub $40, %rsp
    mov $STD_OUTPUT_HANDLE, %rcx
    call GetStdHandle
    mov %rax, stdout(%rip) 


    mov stdout(%rip), %rcx
    lea msg(%rip), %rdx
    mov $msglen, %r8
    lea bytes_written(%rip), %r9 
    push $0
    call WriteFile 

    xor %rcx, %rcx 
    call ExitProcess 
    add $40, %rsp
    ret $0

