;Mi caso es el: C
*Mi corrección
*Compila. Funciona
*Resultado BIEN

		ORG	$0000
NUEVOVECTOR	RMB	64	; 16 lugares de 4 bytes cada uno
ELEMENTOS	EQU	12	; cantidad a elementos a cargar en NUEVOVECTOR


		ORG	$C000
Main
		LDX	#NUEVOVECTOR
		LDY	#VECTOR
		
seguir		
		;; paso a cargar en acumuladores el numero de 16 bits del vector
		LDAA	0,Y	; parte alta en A
		LDAB	1,Y	; parte baja en B

		; paso a guardar el numero completo en la posicion que le corresponde en NUEVOVECTOR
		STD	2,X	; el absoluto en la parte baja
		
		ASLD			; guardo el signo del numero en carry
		BCC	positivo	; y si no se activo C, es positivo
		

		LDD	#$FFFF		; en caso de ser negativo, cargo FF en acumulador
		BRA	cargarSigno	

positivo	
		LDD	#0	; en caso de ser positivo, cargo 0 en acumulador

cargarSigno	
		STD	0,X	; guardo el acumulador en la parte alta de la posicion de memoria a donde apunta X

		CPX	#NUEVOVECTOR+ELEMENTOS-4	; veo si estoy en la posicion que indica si se cargaron todos los elementos
		BEQ	fin	; si es el final, termina

		XGDX		; en caso que falten cargar, intercambio la direccion de X a D
		ADDD	#4	; le sumo 4 que es el tamaño del numero en NUEVOVECTOR
		XGDX		; vuelvo a intercambiar con X para que sea la proxima posicion con la que trabajar
		INY		
		INY		; incremento Y dos veces ya que se el numero es de 16 bits
		BRA	seguir	; vuelve a controlar

fin		BRA	fin


		
VECTOR 		DB	$80,$00,$CA,$7F,$04,$00
		ORG	$FFFE
		DW	Main