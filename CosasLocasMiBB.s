    .data
vocales:      .asciiz     "aeiou"
maluma: .asciiz     "Mete a BadBunny: "
ozuna:    .asciiz     "El número de vocales es: "
negritoojosclaros:     .asciiz     "\n"
badbunny:        .space      100
pollas: .space 5

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


