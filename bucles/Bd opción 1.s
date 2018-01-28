.data
stringuno: .asciiz "Pulse un número de opcion para continuar:\n"
opuno:  .asciiz "[1] Añadir un nuevo usuario\n"
opdos:  .asciiz "[2] Buscar un usuario\n"
optres: .asciiz "[3] Eliminar un usuario\n"
string1: .asciiz "Opción 1 seleccionada!"
string2: .asciiz "Opción 2 seleccionada!"
string3: .asciiz "Opción 3 seleccionada!"

.text
.globl __start

__start: li $2,4
         la $4,stringuno
         syscall
         la $4,opuno
         syscall
         la $4,opdos
         syscall
         la $4,optres
         syscall
         li $2,5
         syscall
         move $6,$2
         bgt $6,4, __start
         blt $6,0, __start
         beq $6,1,anadir
         beq $6,2,buscar
         beq $6,3,eliminar
         j fin

anadir:  li $2,4
         la $4,string1
         syscall
         j fin
buscar:  li $2,4
         la $4,string2
         syscall
         j fin
eliminar:  li $2,4
         la $4,string3
         syscall
         j fin


fin: .end






         
         

