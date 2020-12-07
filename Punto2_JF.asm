;Mi caso es el: A

		ORG 	$0000
RES 		RMB 	3

		ORG $C000
Main
;Caso A
NUMA		DB	$ff,$ff
NUMB		DB	$ff,$Ff

		CLR	RES		; limpio el byte donde ira el signo del resultado
Inicio
		LDD	NUMA 		; carga el primer numero
		ADDD	NUMB		; hace la suma con el segundo
		STD	RES+1		; carga el absoluto en RAM
		BEQ	fin		; si la cuenta da cero, termina
		BGE	fin		; si la cuenta da positivo, tambien termina
	
		DEC	RES		; con resultado negativo, se completa el numero en CB
fin		BRA	fin
		

		ORG $FFFE
		DW Main