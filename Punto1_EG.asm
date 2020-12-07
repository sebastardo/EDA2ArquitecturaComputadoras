;;;;;;Nota de corrector EG: Caso D correcto unsigned LE.

;;;;;; BIEN... muy bien usado el resultado de la resta
;;;;;; como valor para retornar en A. Esto coincide con
;;;;;; lo que hace strcmp en C.

;Mi caso es el: D
	ORG	$0000
;;Reserve memoria de ser necesario
		ORG	$C000
Main
		LDS	#$00FF		; se le da valor al SP para que apunte al tope de la memoria RAM
		LDX	#N1
		LDY	#N2
		LDAB	#3
		JSR	ComparaN
FIN		BRA	FIN

N1		DB	$FF,$FF,$FF
N2		DB	$F0,$FF,$FF


* Subrutina ComparaN
*	Recibe:	Vectores X e Y, numero en acumulador B.
*	Devuelve: Acumulador A con numero positivo si el mayor es N1,
*		  un numero negativo si el mayor es N2, un 0 si son iguales. 
*	Descripcion: Resta los elementos de los vectores hasta que 
*		     la resta da distinto de 0 o acumulador B queda en 
*		     0. Guarda el resultado en acumulador A. 
*	Nota: Cambia el CCR

ComparaN
		; Se guardan los registros con los que trabaja: B, X, Y
		PSHB
		PSHX
		PSHY

		DECB			; para empezar por el final primero se decrecenta B
		ABX			; se le suma el contenido de B a la posicion de X
		ABY			; lo mismo para Y

compara		LDAA	0,X		; se carga el contenido de la posicion de X
		SUBA	0,Y		; se lo resta con el contenido de la posicion de Y
		BNE	volver		; si el resultado es distinto de 0, se encontro el mayor
		CMPB	#0		; son iguales los valores de x e y, se ve si se llego al principio del vector
		BEQ	volver		; B en 0, se probaron todos los valores
		DEX			; no es principio del vector, se mueve al lugar anterior
		DEY			; lo mismo para y
		DECB			; se decrementa B
		BRA	compara		; vuelve a hacer el loop

volver		
		PULY
		PULX
		PULB

		RTS

		ORG	$FFFE
		DW	Main