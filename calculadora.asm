.data
    msgContinue: .asciiz "\ndesea continuar?\ningrese:\n1 para seguir\n0 para salir\n"
    msg1: .asciiz "Ingrese su cuenta en formato: entero, operador, entero (separados por enter)\n"
    msgError: .asciiz "Operador incorrecto\n"
    msgResult: .asciiz "Resultado: "
    msgX: .asciiz " = "
    op_buffer: .space 3       # Buffer ampliado para seguridad
    nl: .asciiz "\n"
    msgErrorDivision: .asciiz "ERROR (la division entre cero no esta permitida)\n"
.text
main:

    #crear la bandera para el while
    li $s4,1	#s4=1
    
    # Mostrar instrucciones
    li $v0, 4
    la $a0, msg1
    syscall

leer_todo:
    # Leer primer número
    li $v0, 5
    syscall
    move $s0, $v0 #s0 almacena a

    # Leer operador (MÉTODO MEJORADO)
    li $v0, 8
    la $a0, op_buffer
    li $a1, 3           # Buffer para operador + \n + \0
    syscall
    
    # EXTRAER SOLO EL CARÁCTER (eliminando \n)
    lb $s1, op_buffer   # $s1 = operador real

    # Leer segundo número
    li $v0, 5
    syscall
    move $s2, $v0 #s2 almacena b

    # COMPARACIÓN CON OPERADORES (VERSIÓN ROBUSTA)
    li $t0, 43          # Código ASCII de '+'
    beq $s1, $t0, suma
    li $t0, 45          # Código ASCII de '-'
    beq $s1, $t0, resta
    li $t0, 42          # Código ASCII de '*'
    beq $s1, $t0, multiplica
    li $t0, 47          # Código ASCII de '/'
    beq $s1, $t0, division

    # Operador inválido
    li $v0, 4
    la $a0, msgError
    syscall
    j fin
    #s3 almacena resultado
suma:
    add $s3, $s0, $s2
    j mostrar

resta:
    sub $s3, $s0, $s2
    j mostrar

multiplica:
    mul $s3, $s0, $s2
    j mostrar

division:
    beqz $s2, errorDivision #condicional division 0
    mtc1 $s0, $f0 #mover s0 a flotante0
    cvt.s.w $f0, $f0 #convertir a single presicion(32bits)
    mtc1 $s2, $f1 #mover s1 a flotante1
    cvt.s.w $f1, $f1 #convertir a single presicion(32bits)
    div.s $f2,$f0,$f1
    mov.s $f12, $f2
    j mostrarDivi

mostrar:
    # Mostrar operación completa
    li $v0, 4
    la $a0, msgResult
    syscall
    
    li $v0, 1
    move $a0, $s0
    syscall
    
    li $v0, 11
    move $a0, $s1
    syscall
    
    li $v0, 1
    move $a0, $s2
    syscall
    
    li $v0, 4
    la $a0, msgX
    syscall
    
    li $v0, 1
    move $a0, $s3
    syscall
    j while
    
mostrarDivi:
    # Mostrar operación completa
    li $v0, 4
    la $a0, msgResult
    syscall
    
    li $v0, 1
    move $a0, $s0
    syscall
    
    li $v0, 11
    move $a0, $s1
    syscall
    
    li $v0, 1
    move $a0, $s2
    syscall
    
    li $v0, 4
    la $a0, msgX
    syscall
    
    #imprimir decimal
    li $v0,2 #servicio decimal almacenado en $f12
    syscall
    j while
    
    
#####ciclo para seguir calculando#####################################3
while:
    li $v0,4
    la $a0, msgContinue
    syscall
    
    li $v0, 5
    syscall
    move $s4, $v0
    
    beqz $s4, fin
    j main
    
errorDivision:
    li $v0, 4
    la $a0, msgErrorDivision
    syscall
fin:
    li $v0, 10
    syscall