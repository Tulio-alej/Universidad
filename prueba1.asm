.data
mensajeA: .asciiz "ingrese el primer número: "
mensajeB: .asciiz "ingrese el segundo número: "
mensajeC: .asciiz "el resultado es: "

.text
main:

	#pedir el primer numero
	li $v0, 4
	la $a0, mensajeA
	syscall
	
	#leer primer numero
	li $v0, 5
	syscall
	move $t0, $v0 #guardamos $v0 en $t0
	
	#pedir el segundo numero
	li $v0, 4
	la $a0, mensajeB
	syscall
	
	#leer el segundo numero
	li $v0, 5
	syscall
	move $t1, $v0 #guardamos v0 en t1
	
	#sumar ambos
	add $t2, $t0, $t1
	
	##mostrar mensaje 3
	li $v0, 4
	la $a0, mensajeC
	syscall
	
	#mostrar resultado
	li $v0, 1
	move $a0,$t2
	syscall
	
