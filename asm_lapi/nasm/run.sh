nasm -fwin64 -g $1.asm
ld $1.obj -o $1.exe -lkernel32
./$1
