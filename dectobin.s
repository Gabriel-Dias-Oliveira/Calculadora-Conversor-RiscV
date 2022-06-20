.section .data

negativo:
    .word 0x2d


test:
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
	.word 0x00000000
      

.section .text


main:
    addi t1, zero, 257

    lui s0, %hi(test)
    addi s0, s0, %lo(test)

    call convertprabin
    call printnumbin


convertprabin:
    andi t2, t1, 1
    addi t3, t3, 4

    sw t2, 0(s0)   
    addi s0, s0, 4

    srli t1, t1, 1

    bne t1, zero, convertprabin

    ret 

printnumbin:
    sub s0, s0, t3 

    lui a0, %hi(test)
    addi a0, s0, %lo(test)

    addi t0, zero, 3
    addi a1,zero, 36
    ecall   

    lw a0, 0(s0)
    addi t0, zero, 3
    ecall

    addi s0, s0, 4

    addi t3, t3, -4

    bne t3, zero, printnumbin

    ret 



