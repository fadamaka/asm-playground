          global    _start
          extern    GetStdHandle
          extern    WriteFile
          extern    ExitProcess

          section   .data
msg:  db        "Hello, WorldAadsadsa123456789", 10
msglen:   equ       $ - msg

          section   .bss
stdout:   resq      1
written:  resq      1

          section   .text
_start:
          ; Get stdout handle
          mov       rcx, -11                ; STD_OUTPUT_HANDLE
          call      GetStdHandle
          mov       [rel stdout], rax       ; Save handle
          
	  ; Calculate lenght
	  mov     rbx, msg        ; move the address of our message string into EBX
          mov     rax, rbx        ; move the address in EBX into EAX as well (Both now point to the same segment in memory)
 
nextchar:
          cmp     byte [rax], 0   ; compare the byte pointed to by EAX at this address against zero (Zero is an end of string delimiter)
          jz      finished        ; jump (if the zero flagged has been set) to the point in the code labeled 'finished'
          inc     rax             ; increment the address in EAX by one byte (if the zero flagged has NOT been set)
          jmp     nextchar        ; jump to the point in the code labeled 'nextchar'
          
finished:
          sub     rax, rbx
	  ;sub     rax, 2

	  call print
	  mov rax, 10
	  call print
          ; Exit program
          xor       rcx, rcx                ; uExitCode
          call      ExitProcess
print:
	  ; Write to console
          mov       rcx, [rel stdout]       ; hFile
          lea       rdx, [rel msg]      ; lpBuffer
          mov       r8, rax                   ; nNumberOfBytesToWrite
          lea       r9, [rel written]       ; lpNumberOfBytesWritten
          mov       qword [rsp + 32], 0     ; lpOverlapped (NULL)
          call      WriteFile
	  ret

