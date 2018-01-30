.data
vocales: .asciiz "aeiou"
result: .asciiz " se repite "
resulta2: .asciiz " veces"
bitParidad: .asciiz "-------------------------"
frase: .space 101
pregunta: .asciiz "Introduzca una frase de 100 caract. max\n\n\n"
salto: .asciiz "\n"
	.word 0xADD
pollas: .space 6


.text
.globl __main
__main:
	li $t0, 0    ##Variable que usamos como contador 
	li $t5, 5   ##Numero maximo de iteraciones
	li $t9, 4  ##Numero de bytes
	
	##------Preguntamos la frase y la leemos--------
	
	li $2, 4
	la $4, pregunta
	syscall
	li $2, 8
	la $4, frase
	li $5, 100
	syscall
	
	##---------------------------------------------------------------------------------------##
	                                                                                         ##
	bucle:                                                                                   ##
		beq $t0, 5, tracaFinal ##Si el contador es 5 finalizamos                         ##
		sb $s0, vocales($t0)   ##Guardamos vocalXvocal en $s0 (static)                   ##     
		                                                                                 ##
		                                                                                 ##
		##-----------Convenio de pila-----------------##                                 ##
			subu $sp, $sp, $t9                                                       ##
			##--Restamos 4 posiciones y guardamos el RA($31) actual en la pila       ##
			move $ra, $sp                                                              ##
		##--------------------------------------------##                                 ##
												 ##		
		 										 ##
		li $t3,0 ##Usado como contador del bucle repeat-until                            ##
		jal comparados  ##Comenzamos el bucle para comparar cada vocal                   ##
		sb $s1, pollas($t0)                                                              ##
											         ##
												 ##		
		##-----------Convenio de pila-----------------##                                 ##
			move $sp, $ra                                                             ##
			##El RA anterior lo sacamos de la pila y lo                              ##
			##----------------devolvemos al RA($31)                                  ##
			addu $sp,$sp, $t9                                                          ##
		##--------------------------------------------##                                 ##
											         ##		
												 ##
		add $t0,$t0,1                                                                    ##
		j bucle                                                                          ##
												 ##
	##---------------------------------------------------------------------------------------##	
			
		
			
	##----------------------------------------------------------##
	comparados:                                                 ##
		lb $t4, frase($t3)                                  ##
		li $s1, 0 ##Registro para el contador de            ##
		add $t3, $t3, 1	                                    ##
		                                                    ##
		beq $s0, $t4, addOnePosition                        ##
		bne $s0, $t4, noIguala                              ##
			addOnePosition:	add $s1, $s1,1              ##
		noIguala:                                           ##
				                                    ##
		blt $t3, 100, comparados                            ##
		                                                    ##
		                                                    ##
		jr $ra                                              ##
	##----------------------------------------------------------##	
		
	tracaFinal: 
		li $2, 4
		la $4, bitParidad
		syscall
		li $t0, 0
		lb $4, vocales($t0)
		syscall 
		la $4, result
		syscall
		lb $4, pollas($t0)
		syscall
		la $4, resulta2
		syscall
		lb $4, salto
		syscall
		beq $t0, 5, mae
		j tracaFinal
	
	
mae: .end	
	
	
	
	