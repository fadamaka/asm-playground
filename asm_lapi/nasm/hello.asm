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
          call      GetStdHandle            ; Call GetStdHandle
          mov       [stdout], rax           ; Save the handle in stdout

          ; Write the message to stdout
          mov       rcx, [stdout]           ; hFile (stdout handle)
          lea       rdx, [message]          ; lpBuffer (address of message)
          mov       r8, msglen              ; nNumberOfBytesToWrite (length of message)
          lea       r9, [written]           ; lpNumberOfBytesWritten (address of written)
          push      0                       ; lpOverlapped (NULL)
          call      WriteFile               ; Call WriteFile

          ; Exit the program
          xor       rcx, rcx                ; uExitCode (0)
          call      ExitProcess             ; Call ExitProcess
