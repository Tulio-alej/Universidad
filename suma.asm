.data
	msg1: .asciiz "ingrese el primer numero: "
	msg2: .asciiz "ingrese el segundo numero: "
	msg3: .asciiz "el resultado es: "
	msg4: .asciiz "ingrese 1 para sumar o 2 para restar "
	msgResta: .asciiz "se ha seleccionado resta "
	msgSuma: .asciiz "se ha seleccionado suma"

.text
main:
	#pedir primer numero
	li $v0, 4
	la $a0, msg1
	syscall
	
	#leer primer numero
	li $v0, 5
	syscall
	move $t0,$v0
	
	#pedir segundo numero
	li $v0, 4
	la $a0, msg2
	syscall
	
	#leer segundo numero
	li $v0, 5
	syscall
	move $t1,$v0
	
	#mostrar cuarto mensaje
	li $v0, 4
	la $a0, msg4
	syscall
	
	#leer valor de operacion
	li $v0, 5
	syscall
	move $t7, $v0
	
	#asignamos el valor a comparar
	li $t6, 1
	
	#condicional(=1)
	beq $t7, $t6, suma
	
	#else (resta)
	sub $t2,$t0,$t1
	
	#mostramos 3er mensaje
	li $v0, 4
	la $a0, msg3
	syscall
	
	#mostramos resultado
	li $v0, 1
	move $a0, $t2
	syscall
	
	#saltar al final para no pasar por el if
	j end_if

#if
suma:
	#sumamos los numeros
	add $t2,$t1,$t0
	
	#mostramos 3er mensaje
	li $v0, 4
	la $a0, msg3
	syscall
	
	#mostramos resultado
	li $v0, 1
	move $a0, $t2
	syscall

end_if: 
	#terminar el programa
	li $v0, 10
	syscall
	
