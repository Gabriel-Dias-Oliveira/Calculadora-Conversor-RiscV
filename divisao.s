.section .data

negativo:
    .word 0x2d

.section .text

main:
    addi t0, zero, 4
    addi t1, zero, 2

    call divisao

divisao:
    andi t2, t0, 10000000000000000000000000000000 

    sub t2, t0, t1
    blt t2, zero, inverte
    

    call printnum

inverte:
    sub t2, zero, t2
    addi a0,zero,0

    call printnumsinal

printnumsinal:
    lui a0, %hi(negativo)
    addi a0, a0, %lo(negativo)

    addi t0, zero, 3
    addi a1,zero,4
    ecall

    printnum:
        addi a0, t2, 0

        addi t0, zero, 1
        ecall


