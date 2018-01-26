.data
letra: .space 1 #Dejamos espacio para alojar la letra
espacio: .byte 0x20 #El código ascii del espacio

.text
.globl __start

__start:
        li $8,0x41            #Cargamos en $8 el codigo ascii de la primera letra, es 0x41
        j bucle               #Saltamos a bucle para no sobreescribir el registro con el bucle
bucle:  sb $8,letra           #Guardamos lo que hay en $8 en letra
        la $4,letra           #Cargamos en $4 la dirección de letra
        li $2,4               #Cargamos el número de la syscall para imprimir cadena
        syscall               #Ejecutamos la Syscall
        addi $8,$8,1          #Añadimos 1 a lo que hay en $8 para imprimir la B
        la $4,espacio         #Colocamos el espacio en una situación propicia
        syscall               #Ejecutamos la syscall para imprimir el espacio
        bne $8,0x55,bucle     #Si no es igual volvemos al bucle
        j fin                 #Si es igual seguimos el flujo del programa y lo terminamos
        
fin:    .end                  #Etiqueta para salir del programa
        
        

        