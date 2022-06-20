.section .data

negativo:
    .word 0x2d

.section .text

main:   
    addi t5, zero, 1  

    addi t4, zero, 0 

    addi t0, zero, 2147483648
    addi t1, zero, 2147483648

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
    
    slt s6, s5, zero  
    
    blt s3, t1, glub 
    
    voltadoglub:
    bgeu s4, t1, glublgub

    voltadoglubglub:
    slli t0, t0, 1

    

    beq t0, zero, divide
     

glub:
    slli s3, s3, 1
    slli s4, s4, 1

    or s3, s3, s6 
    ori s4, s4, 0

    j voltadoglub

glublgub:
    ori s4, s4, 0
    slli s4, s4, 1

    ori s4, s4, 1

    sub s3, s3, t1

    j  voltadoglubglub 

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