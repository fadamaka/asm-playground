          global    _start
          extern    GetStdHandle
          extern    WriteFile
          extern    ExitProcess

          section   .data
message:  db        "Hello, World", 10
msglen:   equ       $ - message

          section   .bss
stdout:   resq      1
written:  resq      1

          section   .text
_start:
          ; Get stdout handle
          mov       rcx, -11                ; STD_OUTPUT_HANDLE
          call      GetStdHandle
          mov       [rel stdout], rax       ; Save handle

          ; Write to console
          mov       rcx, [rel stdout]       ; hFile
          lea       rdx, [rel message]      ; lpBuffer
          mov       r8, msglen              ; nNumberOfBytesToWrite
          lea       r9, [rel written]       ; lpNumberOfBytesWritten
          mov       qword [rsp + 32], 0     ; lpOverlapped (NULL)
          call      WriteFile

          ; Exit program
          xor       rcx, rcx                ; uExitCode
          call      ExitProcess
