;Mi caso es el: A
TAM		EQU	128

* Nota de Ezequiel: Muy buen programa!

		ORG 	$0000
ORDENADO	RMB	TAM
FINAL		RMB	1	; obtengo la ubicacion final del vector + 1
MITAD		RMB	2	; se guardara la ubicacion de la mitad del vector
AUXILIAR	RMB	1	; auxiliar para mover
ULTIMO		RMB	1	; memoria para guardar ultimo valor del vector ordenado
CAMBIO		RMB	1	; bandera para ordenar

		ORG $C000
Main
;; Comienza el programa:
DESORDENADO	DB 	53,51,84,99,146,227,44,84,99,255,87,162,219,124,164,61,163,223,73,128,201,126,110,224,44,57,66,231,121,234,142,218,219,31,113,85,70,149,136,18,82,18,98,71,129,170,205,177,89,155,112,225,52,61,96,143,114,71,176,86,237,91,220,24,24,124,140,76,121,162,79,22,179,105,148,253,29,131,158,228,60,103,248,120,9,227,78,8,58,164,87,252,140,23,7,9,133,224,41,3,160,87,183,217,211,29,20,96,195,48,247,73,152,243,160,240,243,94,232,151,62,135,254,220,55,99,116,67

;$01,$3f,$80,$17,$cc,$00,$20,$ce,$00,$02,$02,$df,$21,$ce,$c0,$00,$18,$ce,$00,$00,$a6,$00,$18,$a7,$00,$08,$18,$08,$18,$8c,$00,$20
	


;; Calculo mitad de vector para usar mas adelante

		LDD	#FINAL
		LDX	#2
		IDIV
		STX	MITAD		; si los bytes de ORDENADO son pares, la direccion sera la mitad +1






;; Guardo el vector desordenado en RAM para manejar mejor el ordenamiento

		LDX	#DESORDENADO
		LDY	#ORDENADO

guardar		
		LDAA	0,X		; lo saco de DESORDENADO
		STAA	0,Y		; lo pongo en ORDENADO
		INX
		INY
		CMPY	#FINAL		; si se llego al final del vector, no se agregan mas datos
		BNE	guardar




		


;; Ordeno el vector de manera ascendente donde el menor valor estara al principio del vector

Ordenar
		CLR	CAMBIO
		INC	CAMBIO		; se usa para controlar si hubo acomodamientos

desdePrincipio		
		LDX	#ORDENADO	; cargo el verctor en X
		LDAA	CAMBIO		; cargo el control
		BEQ	Acomodar	; si esta en 0 no hay mas cambios que hacer
		CLR	CAMBIO		; si no esta en cero, lo pongo en cero para controlar si se necesitan o no hacer nuevos cambios

cambiador		
		LDAA	0,X		; cargo el elemento del vector a comparar
		CMPA	1,X		; y lo comparo con el siguiente
		BLS	menor		; si es menor, no se modifica
		
		STAA	AUXILIAR	; si es mayor se lo guarda en un aux
		LDAA	1,x		; se carga en A al siguiente
		STAA	0,X		; y como es menor que el que se estaba controlando, se lo pone en su lugar
		LDAA	AUXILIAR	; se vuelve a cargar el mauor
		STAA	1,X		; se lo guarda en la posicion del menor
		INC	CAMBIO		; se activa la bandera de cambio

menor
		INX			; se aumenta el indice X
		CPX	#FINAL		; se controla si se llego al final del vector
		BLO	cambiador	; si aun no, se debe seguir comparando
		LDAA	CAMBIO		; si se llego al final, se carga el control para comprobar si hubo cambios
		BNE	desdePrincipio	; si no esta en 0, hay que seguir ordenando






;; Paso a acomodar de manera circular ascendente el vector

acomodar

		LDY	MITAD		; guardo la ubicacion anterior a la mitad del vector en Y
		DEY			; lo decremento en 1 para comprobar que el anterior al que en medio sea el dato mas grande

		LDAA	ORDENADO	; tomo el primer valor del vector (el mas chico)
		STAA	AUXILIAR	; lo guardo en memoria para controlar si se acomodo el vector
		LDX	#FINAL-1
		LDAA	0,X
		STAA	ULTIMO		; guardo el ultimo valor del vector para hacer comprobacion del orden

vuelta
		LDX	#FINAL-1	; empiezo del final
		LDAB	0,X		; pongo el ultimo en acc B para despues ponerlo en el primer lugar del vector

mover
		DEX			; decremento en 1 el indice X para moverlo hacia el siguiente
		LDAA	0,X		; y guardo su valor en A
		STAA	1,X		; piso el siguiente con ese valor
		CPX	#ORDENADO	; compuebo X tiene o no la primera ubicacion del vector indexada
		BNE	mover		; en caso de no tenerla, vuelve a hacer el ciclo
		
		STAB	0,X		; si X esta en la primera ubicacion del vector, inserta el que esta al final


		
		LDAA	1,Y		; cargo el dato que esta en el medio del vector
		CMPA	AUXILIAR	; lo comparo con el menor dato del vector
		BNE	vuelta		; si no son el mismo, vuelvo a acomodar todo

		LDAA	0,Y		; cargo en A el dato de la ubicacion anterior a la mitad
		CMPA	ULTIMO		; si en el medio esta el menor compruebo que el anterior sea el mayor (para acomodar repetidos)
		BNE	vuelta		; no lo esta, sigo acomodando



fin		BRA	fin
		


		ORG 	$FFFE
		DW 	Main