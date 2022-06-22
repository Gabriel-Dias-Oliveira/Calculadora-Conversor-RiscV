
.section .data

binarynumber:
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
	.word 0x0
 
binaryblock:
	.word 0x0

.section .text

main:
    addi s5, zero, 4

    lui s0, %hi(binarynumber)
    addi s0, s0, %lo(binarynumber)

    lui s3, %hi(binaryblock)
    addi s3, s3, %lo(binaryblock)

    addi a0, s0, 0

    addi a1, zero, 32
    addi t0, zero, 6
    ecall

    for: 
        call createblock
        
        # addi s0, s0, 1
        
        lbu s1, 0(s0)
        addi s2, zero, 0x20 
        beq s1, s2, done

        afs:
        addi s3, s3, -4
        addi s5, zero, 4
        addi s6, zero, 0
         # somar 131


        call generatedecimal

generatedecimal:
    addi t2, t2, 1

    lbu s1, 0(s3)
    addi s3, s3, 1

    addi s2, zero, 0x30

    beq s1, s2, converttozero

    addi s2, zero, 0x31

    beq s1, s2, converttoone
    
    addi s3, s3, -5

    call print

createblock:
    beq s5, zero, afs # 4 3 2 1 0 

    lbu s1, 0(s0)

    sw s1, 0(s3)
    addi s0, s0, 1
    addi s3, s3, 1

    addi s5, s5, -1

    addi s4, zero, 0x30

    beq s1, s4, createblock

    addi s4, zero, 0x31

    beq s1, s4, createblock


    ret


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