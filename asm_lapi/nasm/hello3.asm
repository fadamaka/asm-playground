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
          mov       rcx, -11
          sub       rsp, 32
          call      GetStdHandle
          add       rsp, 32
          mov       [rel stdout], rax

          mov       rcx, [rel stdout]
          lea       rdx, [rel message]
          mov       r8, msglen
          lea       r9, [rel written]
          sub       rsp, 32
          call      WriteFile
          add       rsp, 32

          xor       rcx, rcx
          sub       rsp, 32
          call      ExitProcess
          add       rsp, 32
