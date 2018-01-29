.data 

vocales: .asciiz "aeiou"
badbunny: .asciiz "La vocal repatida es: " ##no es repatida es bad Bunny
ozuna: .asciiz "\n" ##Te faltaba un espacio despues del .asciiz"(pollasEnVinager)"
maluma: .space 101

.text
.globl __start
__start:
        la $6,maluma ##Esta mal, es en $4 la longitud del buffer
        li $5,100
        get_cadena
        li $9,0
bucleone: beq $9,5,fin
          lb $10,vocales($9)
          subu $30,$39,4    #Restamos un word al stack pointer, y es $30, no $39
          sw $9,0($30)
          jal rutina
          























######################Subrutinas de La Pila######################
get_cadena: li $2,8
            syscall
            jr $31
