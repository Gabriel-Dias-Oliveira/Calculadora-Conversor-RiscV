
.section .data

binarynumber:
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
 
.section .text

main:
    addi t1, zero, 2147483648

    lui s0, %hi(binarynumber)
    addi s0, s0, %lo(binarynumber)

    addi a0, s0, 0

    addi a1, zero, 32
    addi t0, zero, 6
    ecall

    call generatedecimal

generatedecimal:
    addi t2, t2, 1

    lbu s1, 0(s0)
    addi s0, s0, 1

    addi s3, zero, 0x30

    beq s1, s3, converttozero

    addi s3, zero, 0x31

    beq s1, s3, converttoone

    ret 

converttozero:
    slli s6, s6, 1
    j generatedecimal    

converttoone:
    slli s6, s6, 1
    ori s6, s6, 1
    j generatedecimal