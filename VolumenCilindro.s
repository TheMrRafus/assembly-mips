.data

preg1: .asciiz"Introduzca el radio de la base: "
preg2: .asciiz"Introduzca la altura: "
resp1: .asciiz "El resultado es: "
mayor: .asciiz "El resultado es mayor que 33.33"
menor:  .asciiz "El resultado es menor que 33.33"
limite: .float 33.33
pi:     .float 3.1415



.text
.globl __start

__start:
        la $4,preg1         #Cargamos el string en el registro $4
        li$2,4	# Aquí cargamos la syscall para mostrar  el string en pantalla
        syscall             #Ejecutamos la syscall
        li $2,6             #Cambiamos el codigo de la syscall para recoger flotantes
        syscall             #Ejecutamos la syscall 
        mov.s $f3,$f0       #movemos lo que hay en $f0(resultado de la syscall) a $f3
        la $4,preg2         #Cargamos el string en el registro $4
        li	$2, 4	     	# Aquí cargamos la syscall para mostrar  el string en pantalla
        syscall             #Ejecutamos la syscall
        li $2,6             #Cambiamos el codigo de la syscall para recoger flotantes
        syscall             #Ejecutamos la syscall
        mov.s $f4,$f0	  	#Movemos lo que hemos capturado a otro registro
        l.s	$f6,pi          #Cargamos PI en un registro
        mul.s $f10,$f3,$f3  #Multiplicamos la base para elevarla al cuadrado
        mul.s $f11,$f10,$f6	#Multiplicamos Pi por R al cuadrado
        mul.s $f12,$f11,$f4 #Multiplicamos por la altura
        li $2,2             #Cargamos la syscall para mostrarlo en pantalla
        syscall
        l.s $f13,limite
        c.le.s $f12,$f13
        bc1t rutmenor
        la $4,mayor       #Cargamos el string en el registro $4
        li$2,4	# Aquí cargamos la syscall para mostrar  el string en pantalla
        syscall             #Ejecutamos la syscall
        j fin
rutmenor:
        la $4,menor         #Cargamos el string en el registro $4
        li$2,4           	# Aquí cargamos la syscall para mostrar  el string en pantalla
        syscall             #Ejecutamos la syscall
        j fin


fin: .end      
         
        

        

        
        


        
