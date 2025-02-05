.intel_syntax noprefix   # Use Intel syntax without register prefixes

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
    sub rsp, 40          # Allocate stack space
    mov rcx, STD_OUTPUT_HANDLE
    call GetStdHandle
    mov [stdout + rip], rax  # Save handle to stdout

    mov rcx, [stdout + rip]  # Load stdout handle
    lea rdx, [msg + rip]     # Address of message
    mov r8, msglen           # Length of message
    lea r9, [bytes_written + rip]  # Address of bytes_written
    push 0                   # lpOverlapped (NULL)
    call WriteFile 

    xor rcx, rcx             # Exit code 0
    call ExitProcess 
    add rsp, 40              # Clean up stack
    ret 0
