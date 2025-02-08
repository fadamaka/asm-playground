section .data
    filename db "f.txt", 0

section .bss
    buffer resb 255             ; Buffer to hold file contents
    bytesRead resq 1            ; Variable to store the number of bytes read

section .text
    global main
    extern ExitProcess, WriteConsoleA, GetStdHandle, CreateFileA, ReadFile, CloseHandle

main:
    sub rsp, 40h                ; Allocate 40h bytes for shadow space and alignment

    ; Open the file
    mov rcx, filename           ; lpFileName
    mov rdx, 80000000h          ; dwDesiredAccess (GENERIC_READ)
    xor r8, r8                  ; dwShareMode (0)
    xor r9, r9                  ; lpSecurityAttributes (NULL)
    mov qword [rsp+20h], 3      ; dwCreationDisposition (OPEN_EXISTING)
    mov qword [rsp+28h], 80h    ; dwFlagsAndAttributes (FILE_ATTRIBUTE_NORMAL)
    mov qword [rsp+30h], 0      ; hTemplateFile (NULL)
    call CreateFileA

    cmp rax, -1                 ; Check if file handle is invalid
    je .exit                    ; If invalid, exit

    ; Save the file handle
    mov rbx, rax                ; Save the file handle in rbx

    ; Read the file
    mov rcx, rbx                ; hFile
    lea rdx, [rel buffer]       ; lpBuffer (64-bit addressing)
    mov r8, 255                 ; nNumberOfBytesToRead
    lea r9, [rel bytesRead]     ; lpNumberOfBytesRead (64-bit addressing)
    mov qword [rsp+20h], 0      ; lpOverlapped (NULL)
    call ReadFile

    ; Close the file handle
    mov rcx, rbx                ; hFile
    call CloseHandle

    ; Get the standard output handle
    mov rcx, -11                ; STD_OUTPUT_HANDLE
    call GetStdHandle

    ; Write the buffer to the console
    mov rcx, rax                ; hConsoleOutput
    lea rdx, [rel buffer]       ; lpBuffer (64-bit addressing)
    mov r8, [rel bytesRead]     ; nNumberOfCharsToWrite (64-bit addressing)
    xor r9, r9                  ; lpNumberOfCharsWritten (NULL)
    mov qword [rsp+20h], 0      ; lpReserved (NULL)
    call WriteConsoleA

.exit:
    ; Restore the stack
    add rsp, 40h                ; Clean up the stack

    ; Exit the program
    mov rcx, 0                ; uExitCode
    
    call ExitProcess
