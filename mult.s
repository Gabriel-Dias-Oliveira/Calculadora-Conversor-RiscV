
.section .text

main:   
    #addi sp, sp, -20
    addi t3, zero, 2
    addi t4, zero, 0
    addi t5, zero, 1


    addi t2, zero, -8

    addi t3, zero, -7
    # add t3, t3, t3


    sub t3, zero, t3

    add t4, t3, t2

    sub t4, zero, t4

    addi t3, zero, -7


    addi t2, zero, -7
    add t1, t3, t3


    call askfornumber1
    call askfornumber2

    call mult

    # addi s0, s0, 4


        #lw a0, a0, 4
    #addi t0, zero, 1
    # addi a1, zero, 20
    #ecall


askfornumber1:
    addi t0, zero, 4
    ecall

   addi s0, a0, 0 # Multiplicando (o que vai EM CIMA) desloca pra ESQUERDA
    
    jr ra

askfornumber2:
    addi t0, zero, 4
    ecall

   addi s1, a0, 0 # Multiplicador (o que vai embaixo) desloca para a DIREITA
    
    jr ra


mult:
    andi t1, s1, 1 

    beq t1, t5, soma 

    glub: 
    slli s0, s0, 1
    srli s1, s1, 1

    bne s1, zero, mult

    jr ra


soma: 
    add s2, s2, s0 

    j glub 