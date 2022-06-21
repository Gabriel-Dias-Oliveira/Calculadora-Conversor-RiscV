.section .data

negativo:
    .word 0x2d

.section .text

main:   
    addi t6, zero, 33
    addi t5, zero, 0

    addi t5, zero, 1  

    addi t4, zero, 0 

    addi t0, zero, 178 # 12 R: 35
    addi t1, zero, 5 # 2 R: 3

    addi s3, zero, 0 
    addi s4, zero, 0 

    addi t3, t0, 0 

    call checksignal

    addi t0, t3, 0

    addi t3, t1, 0

    call checksignal

    addi t1, t3, 0

    call divide

checksignal: 
    blt t3, zero, inverte
    ret

inverte:
    sub t3, zero, t3
    addi t4, t4, 1
    ret 

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

printnumsinal:
    lui a0, %hi(negativo)
    addi a0, a0, %lo(negativo)

    addi t0, zero, 3
    addi a1,zero,4
    ecall

    printnum:
        addi a0, s2, 0

        addi t0, zero, 1
        ecall