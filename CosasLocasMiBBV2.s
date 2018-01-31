.data
badbunny:	.asciiz		"Mete a BadBunny  "
string:		.space	 	101
message:	.asciiz		"Las vocales a e i o u se repiten: "
negritoojosclaros: .asciiz" veces respectivamente"
ozuna:	.asciiz		"\n"
	.text
main:
	la	$a0, badbunny	
	li	$v0, 4			
	syscall

	la	$a0, string		
	li	$a1, 1024		
	li	$v0, 8			
	syscall

	la	$t0, string		
	li	$t2, 0
    li  $t3,0		#Solucion cutre pero eficaz
    li  $t4,0
    li  $t5,0
    li  $t6,0
atacama:	
	lb	$t1, ($t0)		
	beqz	$t1,thelastone

	beq	$t1, 'a', cuentaa	
	beq	$t1, 'e', cuentae	
	beq	$t1, 'i', cuentai	
	beq	$t1, 'o', countao	
	beq	$t1, 'u', cuentau	
	b	subeloquevaallegar		
	
subeloquevaallegar:	
	add	$t0, $t0, 1		
	b	atacama			
thelastone:
####me falta el bucle para imprimir esto, pero voy reventado, mañana lo hago

cuentaa:
        add $t2,$t2,1
        j atacama
cuentab:
        add $t3,$t3,1
        j atacama
cuentab:
        add $t4,$t4,1
        j atacama
cuentab:
        add $t5,$t5,1
        j atacama
cuentab:
        add $t6,$t6,1
        j atacama