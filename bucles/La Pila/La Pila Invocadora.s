.data 

vocales: .asciiz "aeiou"
badbunny: .asciiz "La vocal repatida es: "
ozuna: .asciiz"\n"
maluma: .space 101
pregunta: .asciiz "Introduzca una cadena de 100 carcteres maximo.\n\n"


.text
.globl __start
__start:
        la $4,maluma
        li $5,100
        get_cadena
        li $9,0
bucleone: beq $9,5,fin
          lb $10,vocales($9)
          subu $30,$39,4    #Restamos un word al stack pointer
          sw $9,0($30) #guardamos en la pila
          jal rutina
























######################Subrutinas de La Pila######################
get_cadena: li $2,8
            syscall
            jr $31
