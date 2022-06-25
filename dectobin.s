.section .data

binarynumber:
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
    addi t1, zero, 20

    lui s0, %hi(binarynumber)
    addi s0, s0, %lo(binarynumber)

    call convertprabin
    
    addi s0, s0, -1

    call printnumbin

convertprabin:
    andi t2, t1, 1
    addi t3, t3, 1

    sb t2, 0(s0)   
    addi s0, s0, 1

    srli t1, t1, 1

    bne t1, zero, convertprabin

    ret 

printnumbin:
    lb a0, 0(s0)

    beq a0, zero, changetozero
    bne a0, zero, changetoone

    print:
		addi t0, zero, 2
		ecall

		addi s0, s0, -1

		addi t3, t3, -1

		bne t3, zero, printnumbin

    ret 

changetozero:
    addi a0, zero, 0x30
    j print

changetoone:
    addi a0, zero, 0x31
    j print

