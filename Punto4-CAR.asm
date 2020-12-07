;Mi DNI termina en: 2

		ORG	$0000
DIRINI 		EQU 	$D000	; vector guardado en posicion ROM D000
CANT 		RMB	1	
PARES		RMB	1
NEGATIVOS	RMB	1
MINUSCULAS	RMB	1
TAM		EQU	12	;32

		ORG	$C000
Main
		LDS	#$00FF		; se le da valor al SP para que apunte al tope de la memoria RAM
		LDX	#DIRINI
		LDAA	#TAM
		STAA	CANT
		
		;; pongo en cero los contadores
		CLR	PARES		
		CLR	NEGATIVOS
		CLR	MINUSCULAS

Inicio	
		LDAB	0,X

verPar
		JSR	ChequearPar	; salta a subrutina que devuelve Z activo si es par
		BNE	verNegativo	; si no es par, sigue
		INC	PARES		; si es suma 1 a pares

verNegativo
		CMPB	#0		; compara contra cero directamente
		BPL	verASCII	; salta en caso de no ser negativo
		INC	NEGATIVOS	; incrementa 1 en caso de serlo


verASCII
		;; No se toman en cuenta caracteres de ASCII extendido
		CMPB	#'a		; compara contra a
		BLO	todoComprobado	; si es menor a $61, no es minuscula
		CMPB	#'z
		BHI	todoComprobado	; si es mayor a $7A, no es minuscula
		INC	MINUSCULAS


todoComprobado
		INX			; comprobo el caracter de la poscion de X asi que la incrementa
		DEC	CANT		; resta 1 a CANT para comprobar si recorrio todo el vector
		BNE	Inicio		; si CANT es 0, ya chequeo todos los datos, sino, sigue con el proximo

		
fin		BRA	fin


ChequearPar
* Subrutina ChequearPar
*	Recibe:	Dato en el acumulador B.
*	Devuelve: No devuelve nada, modifica Z del CCR como resultado.
*	Descripcion: Pone acumulador A en 0 para dividir acumulador D por 2, el cual se guardo en X 
*		      para usar IDIV. El resto se lo compara contra 0 para ver si es par.
*	Nota: Toma el cero como par (https://es.wikipedia.org/wiki/Paridad_del_cero).

		; guarda en pila para no cambiarlo: B, X
		PSHB
		PSHX
		
		CLRA		; se limpia el accumulador A para trabajar con el dato de B en D
		LDX	#2	; se carga el valor 2
		IDIV		; D/X => resto en D
		CMPD	#0	; se compara el resto para ver si es cero e identificar si es positivo, si lo es, Z = 1


		; se saca de stock X, B para seguir usandolo.
		PULX
		PULB

		RTS





	ORG	DIRINI
;VECTOR	DB	$2F,$6C,$7b,22,172,$F4,$DE,'y,$B5,$D3,197,222,'F,$2,0,7,$A0,$20,$F2,$F8,-6,$A9,$9B,$95,$63,$75,$0,$1D,$6F,$12,51,$B9
VECTOR	DB 	4,4,4,$81,$81,$81,100,100,100,127,127,127
	
	ORG	$FFFE
	DW	Main

