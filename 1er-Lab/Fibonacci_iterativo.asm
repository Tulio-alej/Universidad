.data
    msg1:   .asciiz "Ingrese el valor de n: "
    msg2:  .asciiz "El resultado es:  "
    salto:    .asciiz "\n"

.text
.globl main

main:
    # Pedir valor de n al usuario
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # Guardar n en $t0

    # Calcular Fibonacci(n) iterativamente
    jal fib_iterativo
    move $s0, $v0      # Guardar resultado en $s0

   
    li $v0, 4  # Mostrar resultado
    la $a0, msg2
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, salto
    syscall

    # Terminar programa
    li $v0, 10
    syscall

# Función iterativa Fibonacci
fib_iterativo:
    # Casos base: fib(0)=0, fib(1)=1
    beq $t0, 0, fib0
    beq $t0, 1, fib1

    # Inicialización para n >= 2
    li $t1, 0          # fib(0) = 0
    li $t2, 1          # fib(1) = 1
    li $t3, 2          # contador i = 2

loop:
    # Calcular fib(i) = fib(i-1) + fib(i-2)
    add $t4, $t1, $t2  # $t4 = fib(i)
    
    # Actualizar valores para la siguiente iteración
    move $t1, $t2      # fib(i-2) = fib(i-1)
    move $t2, $t4      # fib(i-1) = fib(i)
    
    # Incrementar contador y verificar condición
    addi $t3, $t3, 1
    ble $t3, $t0, loop # Si i <= n, repetir

    move $v0, $t4      # Retornar fib(n)
    jr $ra

fib0:
    li $v0, 0
    jr $ra

fib1:
    li $v0, 1
    jr $ra