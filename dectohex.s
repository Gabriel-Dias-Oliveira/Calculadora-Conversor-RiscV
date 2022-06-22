.section .data

zerox:
    .word 0x00007830

decimalnumber:
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

    addi s6, zero, 16

    addi t0, zero, 4
    ecall

    # lui a0, %hi(zerox)
    # addi a0, a0, %lo(zerox)
    # addi a1, zero, 2

    # addi t0, zero, 3
    # ecall


    addi t6, zero, 33
    addi t5, zero, 0

    addi t5, zero, 1  

    addi t4, zero, 0 

    add t0, zero, a0 # 12 R: 35
    addi t1, zero, 16 # 2 R: 3

    addi s3, zero, 0 
    addi s4, zero, 0 

    call divide


divide:
    andi s5, t0, 2147483648 
    sltu s5, zero, s5  
    
    bltu s3, t1, notPossibleToSub
    
    checaNovoResto:
        bgeu s3, t1, possibleToSub

    deslocaNumerador:
        slli t0, t0, 1

    addi t5, t5, 1
    bne t5, t6, divide

    jr ra

notPossibleToSub:
    slli s3, s3, 1
    slli s4, s4, 1
    or s3, s3, s5

    j checaNovoResto

possibleToSub:
    ori s4, s4, 1

    sub s3, s3, t1

    j  deslocaNumerador 


converttozero:
    slli s6, s6, 1
    j generatedecimal    

converttoone:
    slli s6, s6, 1
    ori s6, s6, 1
    j generatedecimal