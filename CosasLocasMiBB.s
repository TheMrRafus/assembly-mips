#################################################################################
#    .data
#   vocales:      .asciiz     "aeiou"
#   maluma: .asciiz     "Mete a BadBunny: "
#   ozuna:    .asciiz     "El número de vocales es: "
#   negritoojosclaros:     .asciiz     "\n"
#   badbunny:        .space      100
#   pollas: .space 5
#
###################################Esto realmente sobraba########################
#.text
#    .globl  main
#main:
#    #Imprimimos maluma
#    li      $v0,4
#    la      $a0,maluma
#    syscall
#
#   #recogemos el string
#    li      $v0,8
#    la      $a0,badbunny
#    li      $a1,100
#    syscall
#
#    li      $s2,0                   # inicializamos las vocales
#    la      $s0,badbunny                 # apuntando a badbunny
#
## registricos:
##   s0 -- apuntando a el caracter de badbunny
##   s1 -- apuntando a vocales
##   s2 -- contador de vocales
##
##   t0 -- caracter actual de badbunny
##   t1 -- caracter actual de vocales
##FinRegistros
#badbunnying_loop:
#    lb      $t0,0($s0)             #Cargamos el caracter de badbuny
#    addiu   $s0,$s0,1               #sumamos uno a badbunny
#    beqz    $t0,badbunnybabe       
#
#    la      $s1,vocales               
#
#vocales_loop:
#    lb      $t1,0($s1)             #cargamos la vocal a comparar
#    beqz    $t1,badbunnying_loop         
#    addiu   $s1,$s1,1               #apuntamos a la siguiente
#    bne     $t0,$t1,vocales_loop     #Si no es volvemos a empezar
#    addi    $s2,$s2,1              #añadimos uno
#    j       badbunnying_loop            
#
#badbunnybabe:
###############################Aquí imprimimos###############################
#    li      $v0,4
#    la      $a0,ozuna
#    syscall
#
#
#    li      $v0,1
#    move    $a0,$s2
#    syscall
#
#
#    li      $v0,4
#    la      $a0,negritoojosclaros
#    syscall
#
#
#    li      $v0,10
#    syscall
#    
###################################Esto realmente sobraba########################


.data
vocales: .asciiz "aeiou"
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
	bucle:                                                                                        ##
		beq $t0, 5, tracaFinal ##Si el contador es 5 finalizamos  (imprimimos los resultados) ##
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
		jal comparados  ##Comenzamos el bucle para comparar cada vocal                        ##
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
		add $t0,$t0,1                                                                         ##
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
		li $2, 4
        li $t0, 0
        
		la $4, bitParidad
		                        syscall
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
		addi $t0, $t0,1
		beq $t0, 5, mae
		j tracaFinal
	
	imprimirResultados:
		beq $t0, 0, imprimoa
		beq $t0, 1, imprimoe
		beq $t0, 2, imprimoi
		beq $t0, 3, imprimoo
		beq $t0, 4, imprimou
		
	imprimoa:
		la $4, AAA
		syscall
		jr $ra
	imprimoe:
		la $4, EEE
		syscall
		jr $ra
	imprimoi:
		la $4, III
		syscall
		jr $ra
	imprimoo:
		la $4, OOO
		syscall
		jr $ra
	imprimou:
		la $4, UUU
		syscall
		jr $ra
	
	
	
	
	mae: .end
	
