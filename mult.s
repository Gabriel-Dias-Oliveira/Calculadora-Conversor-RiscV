.section .data

negativo:
    .word 0x2d

.section .text

main:   
    addi t5, zero, 1 # Comparador do valor 1

    addi t4, zero, 0 # Contador de sinal

    addi t0, zero, 25 # Numero 1 - Trocar por s
    addi t1, zero, -5 # Numero 2 - Trocar por s

    addi t3, t0, 0 # t3 - Temporario para inverter se precisar

    call checksignal

    addi t0, t3, 0

    addi t3, t1, 0

    call checksignal

    addi t1, t3, 0

    call mult

checksignal: 
    blt t3, zero, inverte
    ret

inverte:
    sub t3, zero, t3
    addi t4, t4, 1
    ret 

mult:
    andi s1, t1, 1 
    beq s1, t5, soma 

    continuamultiplicacao: 
        slli t0, t0, 1
        srli t1, t1, 1

        bne t1, zero, mult

    beq t4, t5, printnumsinal
    
    call printnum

    jr ra

soma: 
    add s2, s2, t0 
    j continuamultiplicacao

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