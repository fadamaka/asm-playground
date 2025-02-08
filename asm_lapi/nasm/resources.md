
I found this tutorial very helpful: https://sonictk.github.io/asm_tutorial/

and used the following links for reference:

- x86 and amd64 instruction reference: https://www.felixcloutier.com/x86/index.html

- x64 calling convention: https://docs.microsoft.com/en-us/cpp/build/x64-calling-convention

- x64 stack usage: https://docs.microsoft.com/en-us/cpp/build/stack-usage
- https://docs.microsoft.com/en-us/cpp/build/x64-software-conventions
- https://docs.microsoft.com/en-us/windows/win32/debug/pe-format

func1(int a, int b, int c, int d, int e, int f);
// a in RCX, b in RDX, c in R8, d in R9, f then e pushed on stack
