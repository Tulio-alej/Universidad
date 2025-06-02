.data

	msg1: .asciiz "ingrese el numero a calcular factorial: "
	msg2: .asciiz "el factorial de "
	msg3: .asciiz " es: "

.text

main:
	#mostrar texto de ingreso
	li $v0,4
	la $a0, msg1
	syscall
	
	#recibir entero
	li $v0, 5
	syscall
	move $t0,$v0  #t0 almacena el entero a calcular
	
	#loop para el factorial
	move $t1, $t0	#t1 es el contador y se le esta asignando el valor del entero ingresado
	move $t2, $t0	#t2 almacena el resultado y se le asigna el valor del entero ingeresado
	li $t3,1 #valor para comparar nuestro ciclo
	loop:
		beq $t1, $t3, printf #si el contador es igual a uno salta a printf
		subi $t1, $t1, 1	#restamos 1 al contador
		mul $t2, $t2, $t1	#multiplicamos resultado * cont-1
		j loop
	
	printf:
		#mostrar mensaje, entero y result
		li $v0, 4
		la $a0, msg2
		syscall
		
		li $v0,1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, msg3
		syscall
		
		li $v0,1
		move $a0, $t2
		syscall
		
	fin:
		li $v0, 10
		syscall