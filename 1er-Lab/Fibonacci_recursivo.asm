.data
    msg1:   .asciiz "Ingrese el valor de n: "
    msg2:  .asciiz "El resultado es: "
    salto:    .asciiz "\n"

.text
.globl main

main:
    
    li $v0, 4 # Pedir valor de n
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $a0, $v0      # Guardar n en $a0 

    # Calcular Fibonacci(n)
    jal fibonacci
    move $s0, $v0      # Guardar resultado en $s0

    
    li $v0, 4 # Mostrar resultado
    la $a0, msg2
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, salto
    syscall

    
    li $v0, 10 # Terminar programa
    syscall

# Función recursiva Fibonacci
fibonacci:
    # Casos base: fibonacci(0)=0, fibonacci(1)=1
    ble $a0, 1, caso_base

    # Preparar llamada recursiva (fibonacci(n-1))
    addi $sp, $sp, -12
    sw $ra, 0($sp)      # Guardar $ra
    sw $a0, 4($sp)      # Guardar n original

    addi $a0, $a0, -1   # n-1
    jal fibonacci
    sw $v0, 8($sp)      # Guardar fibonacci(n-1)

    # Preparar llamada recursiva (fibonacci(n-2))
    lw $a0, 4($sp)      # Recuperar n original
    addi $a0, $a0, -2   # n-2
    jal fibonacci
    lw $t0, 8($sp)      # Recuperar fibonacci(n-1)

    add $v0, $t0, $v0   # fibonacci(n) = fibonacci(n-1) + fibonacci(n-2)

    # Restaurar registros y retornar
    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra

caso_base:
    move $v0, $a0       # fibonacci(0)=0 o fibonacci(1)=1
    jr $ra