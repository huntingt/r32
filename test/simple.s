.align 6
.globl _start

_start:
    li t0, 0x0020000
    li t1, -1
    sw t0, 0(t1)
