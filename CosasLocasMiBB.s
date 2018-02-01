.data
vocales:  .byte 0x61 0x00
	  .byte 0x65 0x00
	  .byte 0x69 0x00
	  .byte 0x6F 0x00
	  .byte 0x75 0x00

result: .asciiz " se repite "
resulta2: .asciiz " veces"
bitParidad: .asciiz "\n-------------------------\n"
frase: .space 101
pregunta: .asciiz "Introduzca una frase de 30 caract. max\n\n"
salto: .asciiz "\n"
pollas: .space 5


#Atemporal, largo e inutil
#AAA: .space 1
#EEE: .space 1
#III: .space 1
#OOO: .space 1
#UUU: .space 1

#####
#      En este prograna se pretende pedir al usuario una cadena de texto con X caracteres maximo,
#      despues de leer la cadena, recorrer un bucle, en el que un contador($t0) representara una vocal
#      (0=a, 1=e, 2=i, 3=o, 4=u), dentro de ese bucle cargamos la vocal situada en una variable del 
#      segmento de datos(vocales($t0)) y la comparamos con cada letra de la frase introducida, esto 
#      lo haremos con el uso de un bucle do-while, en el que tendremos un contador($t3) y una
#      letra de la cadena, la cual cargamos en $t4, y comparamos. Si la letra coincide con la vocal actual, 
#      sumamos a $s1 1, esta variable la usaremos como contador de repeticions de cada vocal. Una vez se haya
#      recorrido todas las letras de la frase, guardamos en (pollas($t0)) el numero de veces que ha repetido
#      la vocal ($t0), aumentamos $t0+1 y comenzamos de nuevo con la siguiente vocal.
# 
#      Cuando acabamos imprimos en pantalla los resultados, en formato:
#		-"$t0" se repite "pollas($t0)" veces.
#####

.text
.globl __start
__start:
	li $t0, 0    ##Variable que usamos como contador de vocales
	li $t1, 0
	li $t5, 5   ##Numero maximo de iteraciones
	
	##------Preguntamos la frase y la leemos--------
	
	li $2, 4
	la $4, pregunta
	syscall
	li $2, 8
	la $4, frase
	li $5, 30
	syscall
	
	##--------------------------------------------------------------------------------------------##
	                                                                                              ##
	bucle:                                                                                      ##
		beq $t0, 10, tracaFinal ##Si el contador es 5 finalizamos  (imprimimos los resultados) ##
		lb $s0, vocales($t0)   ##Guardamos vocalXvocal en $s0 (static)                        ##     
		                                                                                      ##
		                                                                                      ##
		##-----------Convenio de pila-----------------##                                      ##
			subu $sp, $sp, 4                                                              ##
			##--Restamos 4 posiciones y guardamos el RA($31) actual en la pila            ##
			move $ra, $sp                                                                 ##
		##--------------------------------------------##                                      ##
												      ##		
		 										      ##
		li $t3,0 ##Usado como contador del bucle repeat-until                                 ##
		li $s1, 0 ##Usado para contar el numero de repeticiones de cada letra de la frase     ##
		jal comparados  ##Comenzamos el bucle para comparar cada vocal  
		sb $s1, pollas($t1)                      ##
		#####INUSADO########jal guardarResultados                                             ##     
								          			         ##
									                         	 ##		
		##-----------Convenio de pila-----------------##                                      ##
			move $sp, $ra                                                                 ##
			##El RA anterior lo sacamos de la pila y lo                                   ##
			##----------------devolvemos al RA($31)                                       ##
			addu $sp,$sp, 4                                                               ##
		##--------------------------------------------##                                      ##
											              ##		
											     	 ##
		add $t0,$t0,2                                                                         ##
		j bucle                                                                               ##
											          	 ##
	##--------------------------------------------------------------------------------------------##	
	
    
    ###############Bastante inutil, complejo y bastardo###########
	#guardarResultados:
	#	beq $t0, 0, guardoA
	#	beq $t0, 1, guardoE
	#	beq $t0, 2, guardoI
	#	beq $t0, 3, guardoO
	#	beq $t0, 4, guardoU
	#	
	#guardoA: 
	#	sb $s1, AAA
	#	jr $ra	
	#guardoE: 
	#	sb $s1, EEE
	#	jr $ra	
	#guardoI: 
	#	sb $s1, III
	#	jr $ra	
	#guardoO: 
	#	sb $s1, OOO
	#	jr $ra	
	#guardoU: 
	#	sb $s1, UUU
	#	jr $ra	
	##############################################################	
			
	##----------------------------------------------------------##
	comparados:                                                 ##
		lb $t4, frase($t3)                                  ##
		add $t3, $t3, 1	                                    ##
		                                                    ##
		beq $s0, $t4, addOnePosition                        ##
		bne $s0, $t4, noIguala                              ##
		addOnePosition:	add $s1, $s1,1                      ##
		noIguala:  blt $t3, 100, comparados                 ##
		blt $t3, 31, comparados                             ##
		                                                    ##
		                                                    ##
		jr $ra                                              ##
	##----------------------------------------------------------##	
		
	tracaFinal: 
		li $t0, 0
		li $t1, 0
	segunBadBunny:
		li $2, 4
        
		la $4, bitParidad
		                        syscall
		la $4, vocales($t0)
       		li $2, 4
		                        syscall 
		la $4, result
        	li $2, 4
		                        syscall
		lb $4, pollas($t1)
        	li $2, 1
		                        syscall
       		li $2, 4
		la $4, resulta2
		                        syscall
		lb $4, salto
        	li $2, 1
		                        syscall
		addi $t0, $t0,2
		addi $t1, $t1, 1
		bgt $t0, 10, mae
		j segunBadBunny
	

		
	
	
	
	
	mae: .end
	
