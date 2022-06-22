
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
 
binaryblock:
	.word 0x0

.section .text

main:
    addi s6, zero, 4

    lui s0, %hi(binarynumber)
    addi s0, s0, %lo(binarynumber)

    lui s3, %hi(binaryblock)
    addi s3, s3, %lo(binaryblock)

    addi a0, s0, 0

    addi a1, zero, 32
    addi t0, zero, 6
    ecall

    call createblock
    addi s3, s3, -4

    call generatedecimal

generatedecimal:
    addi t2, t2, 1

    lbu s1, 0(s3)
    addi s3, s3, 1

    addi s2, zero, 0x30

    beq s1, s2, converttozero

    addi s2, zero, 0x31

    beq s1, s2, converttoone

    ret 

createblock:
    lbu s1, 0(s0)

    sw s1, 0(s3)
    addi s0, s0, 1
    addi s3, s3, 1

    addi s6, s6, -1
    bne s6, zero,createblock 

    ret


converttozero:
    slli s6, s6, 1
    j generatedecimal    

converttoone:
    slli s6, s6, 1
    ori s6, s6, 1
    j generatedecimal