.code64
.section .rodata
msg: .ascii "Hello, World!\n"
.set msglen, (. - msg)

.section .text
.global _start
_start:
  sub $40, %rsp 

  add $40, %rsp
  ret $0
