
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

.section .text

main:
    addi t6, zero, 32

    lui s0, %hi(binarynumber)
    addi s0, s0, %lo(binarynumber)

    addi a0, s0, 0

    addi a1, zero, 32
    addi t0, zero, 6
    ecall

    lui s4, %hi(shifted)
    addi s4, s4, %lo(shifted)

    lui a0, %hi(zerox)
    addi a0, a0, %lo(zerox)
    addi a1, zero, 2

    addi t0, zero, 3
    ecall

    call countbinarysize
    add s4, s4, t3
    addi s4, s4, -1
    addi s0, s0, -1

    addi t0, zero, 0
    
    invert: 
        lbu s1, 0(s0)    
        sb s1, 0(s4)
        addi s0, s0, 1
        addi t0, t0, 1
        addi s4, s4, -1

        bne t0, t3, invert

    addi s4, s4, 32

    for:                
        addi s5, zero, 4
        # lbu s1, 0(s0)
        
        lui s3, %hi(binaryblock)
        addi s3, s3, %lo(binaryblock)

        beq t6, zero , done

        call createblock
  
        printhexnumber:
            addi s3, s3, -4
            addi s5, zero, 4
            addi s6, zero, 0
            
            call generatedecimal

countbinarysize:    
    addi t3, t3, 1
    lbu s2, 0(s0)
    addi s0, s0, 1
    
    addi t2, zero, 0x20
    bne s2, t2, countbinarysize

    addi t3, t3, -1
    sub s0, s0, t3

    ret

createblock:
    lbu s1, 0(s4)

    sw s1, 0(s3)
    addi s4, s4, -1
    addi s3, s3, 1

    addi s5, s5, -1 
    
    bne s5, zero, createblock  

    addi t6, t6, -4
 
    ret

generatedecimal:
    beq s5, zero, print
    addi s5, s5, -1

    addi t2, t2, 1

    lbu s1, 0(s3)
    addi s3, s3, 1

    addi s2, zero, 0x31

    beq s1, s2, converttoone
    
    bne s1, s2, converttozero

    call print

converttozero:
    slli s6, s6, 1
    j generatedecimal    

converttoone:
    slli s6, s6, 1
    ori s6, s6, 1
    j generatedecimal

print: 
    addi s2, zero, 10 
    bgeu s6, s2, printletter
    bltu s6, s2, printnumber

    printletter: 
        addi a0, s6, 87
        addi t0, zero, 2
        ecall

        j for

     printnumber: 
        addi a0, s6, 48
        addi t0, zero, 2
        ecall

        j for  