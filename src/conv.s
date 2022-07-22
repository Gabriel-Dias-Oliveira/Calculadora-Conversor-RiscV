.section .data

zerox:
    .word 0x00007830

binarynumber:
    .word 0x30303030
    .word 0x30303030
    .word 0x30303030
    .word 0x30303030
    .word 0x30303030
    .word 0x30303030
    .word 0x30303030
    .word 0x30303030

shifted:
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

menu:
	.word 0x65642031
	.word 0x3e2d2063
	.word 0x78656820
	.word 0x32207c20
	.word 0x78656820
	.word 0x203e2d20
	.word 0x20636564
	.word 0x2033207c
	.word 0x20636564
	.word 0x62203e2d
	.word 0x7c206e69
	.word 0x62203420
	.word 0x2d206e69
	.word 0x6564203e
	.word 0x207c2063
	.word 0x69622035
	.word 0x3e2d206e
	.word 0x78656820
	.word 0x36207c20
	.word 0x78656820
	.word 0x203e2d20
	.word 0x2e6e6962
	.word 0x203e2d20
	.word 0x00000000

asknumber:
	.word 0x69736e49
	.word 0x6f206172
	.word 0x6d756e20
	.word 0x3a6f7265
	.word 0x00000000

resultmsg:
    .word 0x6572204f
	.word 0x746c7573
	.word 0x206f6461
	.word 0x203a6865
	.word 0x00000000

pulalinha: 
    .word 0x0d0a 

.section .text

main:
    addi sp, sp, -4
    sw ra, 0(sp)

    call breakline

    lui a0, %hi(menu)
    addi a0, a0, %lo(menu)
    addi a1, zero, 96

    addi t0, zero, 3
    ecall

    addi t0, zero, 4
    ecall

    add s2, zero, a0 # Operacao

    addi t1, zero, 1 # Comparador de operacoes
    beq s2, t1, convdectohex

    addi t1, zero, 2 
    beq s2, t1, convhextodec

    addi t1, zero, 3
    beq s2, t1, convdectobin

    addi t1, zero, 4
    beq s2, t1, convbintodec

    addi t1, zero, 5
    beq s2, t1, convbintohex

    addi t1, zero, 6
    beq s2, t1, convhextobin


breakline:
    lui a0, %hi(pulalinha)
    addi a0, a0, %lo(pulalinha)

    addi t0, zero, 3
    addi a1, zero, 4
    ecall

    ret

convhextodec:
    call readnumber

    addi s3, s0, 0 # s3 Tem o resultado 

    call printresult

readnumber:
    addi sp, sp, -4
    sw ra, 0(sp)

    call printreadmsg

    addi t0, zero, 4
    ecall

    add s0, a0, zero 

    call end

readstring:
    addi sp, sp, -4
    sw ra, 0(sp)

    call printreadmsg

    lui a0, %hi(binarynumber)
    addi a0, a0, %lo(binarynumber)

    addi a1, zero, 32
    addi t0, zero, 6
    ecall

    add s1, a0, zero # s1 guarda o endereco do numero

    call end

printreadmsg:
    lui a0, %hi(asknumber)
    addi a0, a0, %lo(asknumber)
    addi a1, zero, 20

    addi t0, zero, 3
    ecall

    ret
    
printresultmsg:
    lui a0, %hi(resultmsg)
    addi a0, a0, %lo(resultmsg)
    addi a1, zero, 20

    addi t0, zero, 3
    ecall

    ret 

printresult:
    call printresultmsg

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

    call printresultmsg
    call printnumbin

convertprabin:
    andi s2, s0, 1 # s2 Guarda o LSB do numero
    addi t2, t2, 1 # Contador do tamanho do binario

    beq s2, zero, changetozeroascii
    bne s2, zero, changetooneascii

    savevalue:
        sb s2, 0(s1)   
        addi s1, s1, 1

        srli s0, s0, 1

        bne s0, zero, convertprabin

    ret 

printnumbin:
    lbu a0, 0(s1)

    addi t0, zero, 2
    ecall

    addi s1, s1, -1
    addi t2, t2, -1

    bne t2, zero, printnumbin

    call end

changetozeroascii:
    addi s2, zero, 0x30
    j savevalue

changetooneascii:
    addi s2, zero, 0x31
    j savevalue

convbintodec:
    call readstring
    call generatedecimal
    call printresult

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

convbintohex:
    addi t6, zero, 32 # Quantidade de bits a serem olhados diminui de 4 em 4
    addi s4, s4, 31 # Comeca a olhar s4 da ultima posicao MSB 0000000000000xxxx 

    addi t1, zero, 5
    beq s2, t1, useauxword # Se o binario vem da entrada eh preciso inverter ele para o formato 00000xxxxx
    
    startconversion:
    call printresultmsg
    call printzerox

    for:                
        addi t4, zero, 4 # Contador para o bloco de 4 bits
        
        lui s5, %hi(binaryblock) # Guarda o endereco do bloco de bits a ser olhado
        addi s5, s5, %lo(binaryblock)

        beq t6, zero, end

        call createblock

        printhexnumber:
            addi s5, s5, -4
            addi t4, zero, 4
            addi s3, zero, 0
            
            call foundnumberascii

useauxword:
    call readstring

    lui s4, %hi(shifted) # Guarda o endereco do valor a ser invertido 
    addi s4, s4, %lo(shifted)

    call countbinarysize
    add s4, s4, t2 #ret Pula em s4 par inverter o numero 0101 vira 000001010
    addi s4, s4, -1

    call invertenumero

    addi s4, s4, 32 # Comeca a olhar s4 da ultima posicao MSB 0000000000000xxxx 

    j startconversion

printzerox:
    lui a0, %hi(zerox)
    addi a0, a0, %lo(zerox)
    addi a1, zero, 2

    addi t0, zero, 3
    ecall

    ret 

countbinarysize:    
    addi t2, t2, 1 # Contador do tamanho do binario
    lbu s2, 0(s1)
    addi s1, s1, 1
    
    addi t3, zero, 0x20 # Comparador do valor vazio Fim do numero
    bne s2, t3, countbinarysize

    sub s1, s1, t2 # Volta s1 para o comeco do numero
    addi t2, t2, -1

    ret

invertenumero:
   addi t3, zero, 0 # Contador pro for da inversao
    
    invert: 
        lbu s2, 0(s1)    
        sb s2, 0(s4)
        addi s1, s1, 1
        addi t3, t3, 1
        addi s4, s4, -1

        bne t3, t2, invert

    ret 

createblock:
    lbu s1, 0(s4)

    sb s1, 0(s5)  
    addi s4, s4, -1
    addi s5, s5, 1

    addi t4, t4, -1 
    
    bne t4, zero, createblock  
    
    addi t6, t6, -4
 
    ret

foundnumberascii:
    beq t4, zero, printascii
    addi t4, t4, -1

    lbu s1, 0(s5)
    addi s5, s5, 1

    addi s2, zero, 0x31

    beq s1, s2, converttoonehex
    bne s1, s2, converttozerohex

converttozerohex:
    slli s3, s3, 1
    j foundnumberascii    

converttoonehex:
    slli s3, s3, 1
    ori s3, s3, 1
    j foundnumberascii

printascii: 
    addi t5, zero, 10  # Se valor maior que 1 entao precio printar letra
    addi t0, zero, 2
    bgeu s3, t5, printletter
    bltu s3, t5, printnumber

    printletter: 
        addi a0, s3, 87
        ecall

        j for

     printnumber: 
        addi a0, s3, 48
        ecall

        j for  

convdectohex:
    call readnumber

    lui s1, %hi(binarynumber) # s1 responsavel por guardar o endereco do numero na memoria 
    addi s1, s1, %lo(binarynumber)

    call convertprabin

    lui s4, %hi(binarynumber) # s4 responsavel por guardar o endereco do numero na memoria para conversao hexa
    addi s4, s4, %lo(binarynumber)

    call convbintohex

convhextobin:
    call convdectobin    

end:
    lw ra, 0(sp)
    addi sp, sp, 4
    
    ret
