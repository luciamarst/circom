pragma circom 2.0.0;

template piedra_papel_tijera () autocomplete{

	//Piedra -> 0, Papel-> 1, Tijera->2
	signal input jugador1;//Representa ele stado del jugador 1
	signal input jugador2;//Representa el estado del jugador 2
	signal output ganador;//Representa cual de los dos jugadores ha ganado, 0-> jugador1 ; 1->jugador2, 2 -> empate

	//Código en C
	if(jugador1 == jugador2){ //Empate
		ganador <-- 2;
	}
	else if(jugador2 == 0 && jugador1 == 2){ //Gana jugador 2 con piedra
		ganador <--1;
	}
	else if(jugador1 == 0 && jugador2 == 2){ // Gana jugador 1 con piedra
		ganador <--0;
	}
	else if(jugador2 == 2 && jugador1 == 1){ //Gana jugadpr 2 con tijera
		ganador <--1;
	}
	else if(jugador1 == 2 && jugador2 == 1){ //Gana jugador 1 con tijera
		ganador <-- 0;
	}
	else if(jugador2 == 1 && jugador1 == 0){ //Gana jugador 2 ocn papel
		ganador <--1;
	}
	else if(jugador1 == 1 && jugador2 == 0){ // Gana jugador 1 con papel
		ganador <-- 0;
	}
	else{
		ganador <-- 1; //Valor no valido
	}
}	


component main = piedra_papel_tijera();
	



	
