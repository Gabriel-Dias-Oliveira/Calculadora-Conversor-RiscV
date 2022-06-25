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
    addi sp, sp, -4
    sw ra, 0(sp)

    addi t0, zero, 4
    ecall

    add s2, zero, a0 # Operacao
    addi t1, zero, 1 # Comparador de operacoes

    beq s2, t1, convhextodec

    addi t1, zero, 2

    beq s2, t1, convdectobin

    addi t1, zero, 3

    beq s2, t1, convbintodec

convhextodec:
    call readnumber

    addi s3, s0, 0 # s3 Tem o resultado 

    call printresult

readnumber:
    addi t0, zero, 4
    ecall

    add s0, a0, zero 

    ret

printresult:
    add a0, s3, zero 
    addi t0, zero, 1
    ecall

    call end

convdectobin:
    call readnumber

    lui s1, %hi(binarynumber) # s1 responsavel por guardar o endereco do numero na memoria 
    addi s1, s1, %lo(binarynumber)

    call convertprabin
    
    addi s1, s1, -1

    call printnumbin

convertprabin:
    andi s2, s0, 1 # s2 Guarda o LSB do numero
    addi t2, t2, 1 # Contador do tamanho do binario

    sb s2, 0(s1)   
    addi s1, s1, 1

    srli s0, s0, 1

    bne s0, zero, convertprabin

    ret 

printnumbin:
    lb a0, 0(s1)

    beq a0, zero, changetozeroascii
    bne a0, zero, changetooneascii

    print:
		addi t0, zero, 2
		ecall

		addi s1, s1, -1
		addi t2, t2, -1

		bne t2, zero, printnumbin

    call end

changetozeroascii:
    addi a0, zero, 0x30
    j print

changetooneascii:
    addi a0, zero, 0x31
    j print

convbintodec:
    call readstring
    call generatedecimal
    call printresult

readstring:
    lui a0, %hi(binarynumber)
    addi a0, a0, %lo(binarynumber)

    addi a1, zero, 32
    addi t0, zero, 6
    ecall

    add s1, a0, zero # s1 guarda o endereco do numero

    ret

generatedecimal:
    lbu s2, 0(s1)
    addi s1, s1, 1

    addi t4, zero, 0x30 # Comparador do caracter 0

    beq s2, t4, converttozero

    addi t4, zero, 0x31 # Comparador do caracter 1

    beq s2, t4, converttoone

    ret 

# s3 tem o resultado numerico
converttozero:
    slli s3, s3, 1
    j generatedecimal    

converttoone:
    slli s3, s3, 1
    ori s3, s3, 1
    j generatedecimal



























end:
    lw ra, 0(sp)
    addi sp, sp, 4
    
    ret
