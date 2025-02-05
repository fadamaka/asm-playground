; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using Windows API calls. Runs on 64-bit Windows.
; To assemble and link:
;
;     nasm -fwin64 hello.asm && x86_64-w64-mingw32-ld hello.obj -o hello.exe -lkernel32
; ----------------------------------------------------------------------------------------

          global    _start
          extern    GetStdHandle            ; Import Windows API functions
          extern    WriteFile
          extern    ExitProcess

          section   .data
message:  db        "Hello, World", 10      ; Message to write, with newline (10)
msglen:   equ       $ - message             ; Length of the message

          section   .bss
stdout:   resq      1                       ; Reserve space for stdout handle
written:  resq      1                       ; Reserve space for bytes written

          section   .text
_start:
          ; Get the handle for stdout
          mov       rcx, -11                ; STD_OUTPUT_HANDLE = -11
          sub       rsp, 32                 ; Allocate shadow space for Windows API calls
          call      GetStdHandle            ; Call GetStdHandle
          add       rsp, 32                 ; Clean up shadow space
          mov       [rel stdout], rax       ; Save the handle in stdout (use RIP-relative addressing)

          ; Write the message to stdout
          mov       rcx, [rel stdout]       ; hFile (stdout handle)
          lea       rdx, [rel message]      ; lpBuffer (address of message)
          mov       r8, msglen              ; nNumberOfBytesToWrite (length of message)
          lea       r9, [rel written]       ; lpNumberOfBytesWritten (address of written)
          sub       rsp, 32                 ; Allocate shadow space
          call      WriteFile               ; Call WriteFile
          add       rsp, 32                 ; Clean up shadow space

          ; Exit the program
          xor       rcx, rcx                ; uExitCode (0)
          sub       rsp, 32                 ; Allocate shadow space
          call      ExitProcess             ; Call ExitProcess
          add       rsp, 32                 ; Clean up shadow space
