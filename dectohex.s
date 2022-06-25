.section .data

binarynumber:
	.word 0x30303030
	.word 0x30303030
	.word 0x30303030
	.word 0x30303030
	.word 0x30303030
	.word 0x30303030
	.word 0x30303030
	.word 0x30303030

binaryblock:
	.word 0x00000000

zerox:
    .word 0x00007830

.section .text


main:
    call asknumbers

    addi t0, zero, 4  
    ecall

    addi s3, zero, a0 # operation
    

asknumbers:
    addi t0, zero, 4 
    ecall

    addi s1, zero, a0

    addi t0, zero, 4 
    ecall

    addi s2, zero, a0

    ret 
