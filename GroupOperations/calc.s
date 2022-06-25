.section .data

negativo:
    .word 0x2d

askfornumber:
	.word 0x69676944
	.word 0x75206574
	.word 0x756e206d
	.word 0x6f72656d
	.word 0x0000203a

askforoperation:
	.word 0x636c6143
	.word 0x64616c75
	.word 0x2061726f
	.word 0x2031207c
	.word 0x207c202b
	.word 0x202d2032
	.word 0x2033207c
	.word 0x207c202a
	.word 0x202f2034
	.word 0x00203e2d

resultmsg:
	.word 0x6572204f
	.word 0x746c7573
	.word 0x206f6461
	.word 0x203a6865
	.word 0x00000000

restdiv:
	.word 0x6572204f
	.word 0x206f7473
	.word 0x203a6865
	.word 0x00000000

.section .text

main:
    addi sp, sp, -4
    sw ra, 0(sp)

    call asknumbers
    add s0, zero, a0 # digito 1
    
    call asknumbers
    add s1, zero, a0 # digito 1

    lui a0, %hi(askforoperation)
    addi a0, a0, %lo(askforoperation)

    addi t0, zero, 3
    addi a1, zero, 40
    ecall

    addi t0, zero, 4
    ecall

    add s2, zero, a0 # Operacao
    addi t1, zero, 1 # Comparador de operacoes

    beq s2, t1, adicao

    addi t1, zero, 2

    beq s2, t1, subtracao

    addi t1, zero, 3

    beq s2, t1, multiplicaco

    addi t1, zero, 4

    beq s2, t1, divisao

asknumbers:
    lui a0, %hi(askfornumber)
    addi a0, a0, %lo(askfornumber)

    addi t0, zero, 3
    addi a1, zero, 20
    ecall

    addi t0, zero, 4
    ecall

    ret

adicao:
    add s3, s0, s1 # resultado 
    blt s3, zero, inverte

    call printnum

subtracao:
    sub s3, s0, s1 # resultado 
    blt s3, zero, inverte

    call printnum

multiplicaco:   
    addi t2, zero, 1 # Comparador do valor 1
    addi t3, zero, 0 # Contador de sinal

    addi t4, s0, 0 # t4 - Temporario para inverter se precisar

    call checksignal

    addi s0, t4, 0
    addi t4, s1, 0

    call checksignal

    addi s1, t4, 0

    call mult

divisao:   
    addi t2, zero, 1 # Comparador do valor 1
    addi t3, zero, 0 # Contador de sinal
    addi t4, s0, 0 # t4 - Temporario para inverter se precisar
    addi t5, zero, 32 # Numero de operacoes
    addi t6, zero, 0 # Contador de operacoes

    addi s5, zero, 0 # Resto
    addi s6, zero, 0 # Quociente

    call checksignal

    addi s0, t4, 0
    addi t4, s1, 0

    call checksignal

    addi s1, t4, 0

    call divide

divide:
    andi s4, s0, 2147483648  # s4 - guarda o resultado do AND, MSB
    sltu s4, zero, s4  
    
    bltu s5, s1, notPossibleToSub
    
    checaNovoResto:
        bgeu s5, s1, possibleToSub

    deslocaNumerador:
        slli s0, s0, 1

    addi t6, t6, 1
    bne t6, t5, divide

    call printresultadodivisao

    jr ra

notPossibleToSub:
    slli s5, s5, 1
    slli s6, s6, 1
    or s5, s5, s4

    j checaNovoResto

possibleToSub:
    ori s6, s6, 1
    sub s5, s5, s1

    j  deslocaNumerador 

printresultadodivisao:
    lui a0, %hi(restdiv)
    addi a0, a0, %lo(restdiv)

    addi t0, zero, 3
    addi a1, zero, 20
    ecall

    addi t0, zero, 1
    add a0, zero, s5 # Print do resto
    ecall 

    add s3, zero, s6 # Resultado quociente

    beq t3, t2, printnumsinal # Se so tem 1 numero negativo entao Resultado negativo
    
    call printnum

    jr ra

checksignal: 
    blt t4, zero, inverteoperando
    ret

inverteoperando:
    sub t4, zero, t4
    addi t3, t3, 1
    ret 

mult:
    andi s4, s1, 1  # s4 - guarda o resultado do AND, LSB 
    beq s4, t2, soma # Se for 1 soma

    continuamultiplicacao: 
        slli s0, s0, 1 # shift operando 1  
        srli s1, s1, 1 # shift operando 2

        bne s4, zero, mult

    beq t3, t2, printnumsinal # Se so tem 1 numero negativo entao Resultado negativo
    
    call printnum

    jr ra

soma: 
    add s3, s3, s0 # s3 Resultado sendo formado com somas 
    j continuamultiplicacao

inverte:
    sub s3, zero, s3
    call printnumsinal

# chamado se resultado menor 0
printnumsinal: 
    call printresultmessage

    lui a0, %hi(negativo)
    addi a0, a0, %lo(negativo)

    addi t0, zero, 3
    addi a1, zero, 4
    ecall

# chamado se resultado maior 0 
    printnum: 
        call printresultmessage

        addi a0, s3, 0
        addi t0, zero, 1

        ecall

    lw ra, 0(sp)
    addi sp, sp, 4

    ret 

printresultmessage:
    lui a0, %hi(resultmsg)
    addi a0, a0, %lo(resultmsg)

    addi t0, zero, 3
    addi a1, zero, 20
    ecall

    ret 