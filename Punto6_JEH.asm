;Mi caso es el: A

* NOTA: no utiliza la Ñ

		ORG $0000
CRYPTO		RMB 	$FE	* como el tamaño del mensaje puede variar y no se usa para nada mas, uso casi toda la RWM
KEY		RMB	1

		ORG $C000
Main	
		LDAA	#2	 ; cargo el valor de la key en A
		STAA	KEY	 ; lo guardo en memoria
		LDX	#MENSAJE ; cargo direccion del mensaje a codificar en indice X
		LDY	#CRYPTO	 ; cargo direccion del mensaje a codificado en indice Y

Inicio
		LDAA	0,X	 ; guardo caracter en acumulador
		BEQ	termino	 ; si es cero, se termino la codificacion
	
		ADDA	KEY	 ; le sumo la key al caracter
		CMPA	#91	 ; compruebo que no haya ido de rango
		BLO	insertar ; si no se fue, paso a guardarlo
		
		SUBA	#'Z	 ; si salio del rango de las letras mayusculas, resto "Z"
		ADDA	#64	 ; lo que sobra le sumo el valor anterior a "A" y con eso se completa el cifrado


insertar	
		STAA	0,Y	 ; guardo en la ubicacion que le corresponde de CRYPTO
		INX		 ; incremento X e Y para trabajar con la siguiente letra
		INY
		BRA	Inicio


termino		
		DECA		 ; el valor es 0, lo convierto en $FF
		STAA	0,Y	 ; lo inserto al final de CRYPTO y termina

fin 		BRA	fin



MENSAJE 	FCC 	"HOLASEBICAPODELMUNDO" * "HABLEMASFUERTEQUETENGOUNATOALLA"
FINMENSAJE 	DB 	0

		ORG $FFFE
		DW Main

; Si bien felicito tu autoestima por el MENSAJE "HOLASEBICAPODELMUNDO" , el enunciado solicitaba uses otro.
; Emplear una constante (tipo EQU) para la KEY en lugar de hardcodearla... eso te haría 10% más capo.
; Hace lo que se pide. Buen trabajo.