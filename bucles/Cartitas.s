.data
cartas: .space 5
                                          #Dejamos un byte en medio para separar la memoria
pregunta: .asciiz"Introduzca un numero de carta: \n"
badbunny: .asciiz"Has fallado...\n"
mayorbb:  .asciiz"La carta mayor es: "
atacama:  .asciiz"\n"
.text
.globl __start
       __start:         li $10,1                                # $7 = 1 Contador de fallos
                        li $11,0                                #Contador de cartas
                        j continuar
        continuar:      li $2,4
                        la $4,pregunta 
                        syscall                                 #Mostramos el string
                        li $2,5
                        syscall                                 #recogemos el entero
                        sb $2,cartas($11)                       #Almacenamos el entero el la primera posición de memoria
                        blt $2, 0, fallaste             	# Si el numero es menor que 0 fallaste...
                        bgt $2, 10, fallaste                    # Si el numero es mayor que 10 fallaste...
                        addi	$11, $11, 1			# $11 = $11 + 1
                        bne   $11, 5, continuar	                # si $11 != 5 nos vamos a continuar
                        li $13,0                                #Contador
        mayorbaby:      lb  $17,cartas                          #Cargamos la posicion para comparar
        		lb  $18,cartas +1($13)                  #La posición siguiente
                        bgt $17,$18, setmayor                   # Salta a setmayor si $17 es mayor que $18, si no continuamos        
                        sb $18,cartas                           #guardamos el mayor en la primera posición de cartas
                        j siguiente                             #Saltamos a siguiente para qué no ejecute el sisguiente codigo y sobreescriba...
        setmayor:       sb $17, cartas                          #Esto es la subrutina en el caso de que el $17 sea mayor, en cuyo caso guardamos ese registro en cartas
       siguiente:   
        		addi $13,$13,1                          #Incrementamos el contador en 1 
                        bne $13,4,mayorbaby                     #Si no es igual a 4, volvemos a la subrutina para seleccionar el mayor
                        la $4,mayorbb                           #Carga el string en $4
                        li $2,4                                 #Codigo de llamada al sistema para mostrar el string
                        syscall                                 #Syscall en acción
                        lb $4,cartas                            #Cargamos el primer byte de la dirección cartas preparandola para la syscall
                        li $2,1                                 #Codigo de llamada al sistema para mostrar enteros
                        syscall
                        la $4,atacama                           #Carga el string en $4
                        li $2,4                                 #Codigo de llamada al sistema para mostrar el string
                        syscall                                 #Syscall en acción 
                        j __start                               #Volvemos al inicio para volver a ejecutar el programa

        fallaste:       beq $10, 2,tracafinal                   #Si te equivocas 2 veces nos vamos a la  traca final
                        addi	$10, $10, 1                     #Incrementamos el contador en 1
                        j continuar			        #Volvemos a la rutina principal
        tracafinal:
                        li $2,4                                 #Cargamos el codigo de la syscall 
                        la $4, badbunny                         #Carga el string en $4
                        syscall                                 #Syscall en acción
                        j fin                                   #Terminamos


fin:     .end                                                           


                        		
                        
        

                        
                        

                        



                

   
     


