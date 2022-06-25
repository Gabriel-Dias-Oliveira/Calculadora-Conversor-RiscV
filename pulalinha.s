	.section .data
test:
    # 43,61,6c,63
    # 75,6c,61,64
    # 6f,72,61,3a
    # 0a,31,20,20
    # 2b,0a,32,20
    # 20,2d,0a,33
    # 20,20,2a,0a
    # 34,20,2f,20,
    # 0a,2d,3e
    .word 0x636c6143
    .word 0x64616c75
    .word 0x3a61726f
    # .word 0x3a61726f
    .word 0x2b20310a
    .word 0x20320a2b
    .word 0x330a2d20
    .word 0x0a2a2020
    .word 0x202f2034
    .word 0x003e2d0a
    # .word 0x00000062


.section .text

main:
    addi t1, zero, 20

    lui a0, %hi(test)
    addi a0, a0, %lo(test)

    addi a1, zero, 63

    addi t0, zero, 3
    ecall

    call convertprabin
    
    addi s0, s0, -1

    call converttohex