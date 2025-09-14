pragma circom 2.0.0;
include "node_modules/circomlib/circuits/comparators.circom";

/*This circuit template checks that c is the multiplication of a and b.*/

template igualdadRepetida(val){
        signal input in;
        signal output out;

        component cmp = IsEqual();
        cmp.in[0] <== in;
        cmp.in[1] <== val;
        out <== cmp.out;
}


template tres_en_raya () {
   //Tamaño del tablero, el cual es cuadrado, es decir, nxn
   var n = 3;
   
   // El jugador1 -> Circulos, jugador2-> Cruces
   
   signal input tablero[n][n]; //Circulos -> 0, Cruces->1, 2-> Ninguno
   signal output ganador; //Si el valor de ganador es 1, es porque gano el jugador 1(circulos), en cambio, si gana el jugador 2(cruces) el valor será 2, 0 si no hay ganador

   //Variables que almacenan si se encontro algún ganador o no en los recorridos horizontales, verticales o digonales
   signal rh;
   signal rv;
   signal rd1;
   signal rd2;


   //Recorrido Horizontal//=================================================================================================================================================
   
   //***Variables de R.H**//
   signal suma_circulo[n][n+1];
   signal suma_cruz[n][n+1];
   component circulo[n][n];
   component cruz[n][n];
  
   signal total[n];
   component alineacion_circulo[n];
   component alineacion_cruz[n];


   //***Iteración del recorrido horizontal***//
   for (var i = 0; i < n; i++){
   
   	//Por cada iteracion tenemos que volver a iniciar los valores del sumatorio, de lo contrario podría coger cualquier valor
   	suma_circulo[i][0] <== 0;
        suma_cruz[i][0] <== 0;
        
	for(var j = 0; j < n; j++){
		circulo[i][j] = igualdadRepetida(0);
		cruz[i][j] = igualdadRepetida(1);
		
		circulo[i][j].in <== tablero[i][j];
		cruz[i][j].in <== tablero[i][j];
		
		suma_circulo[i][j+1] <== suma_circulo[i][j] + circulo[i][j].out;
		suma_cruz[i][j+1] <== suma_cruz[i][j] + cruz[i][j].out;	
	}
	
	//Volvemos a inicializar el valor de las alineaciones por el mismo motivo expuesto anteriormente
	alineacion_circulo[i]  = igualdadRepetida(n);
	alineacion_cruz[i] = igualdadRepetida(n);
	
	alineacion_circulo[i].in <== suma_circulo[i][n];
        alineacion_cruz[i].in <== suma_cruz[i][n];

        //Por cada iteración tenemos un resultado, ya que en las n filas del tablero podríamos tener una iteración o no tenerla, por tanto al necesitar comprobar
        // todas las filas en busca de una alineación, necesitamos almacenar este valor por fila.
	total[i] <== alineacion_circulo[i].out * 1 + alineacion_cruz[i].out * 2; //Si hay circulo
   }
   
   //Almacenamos el valor obtenido tras el recorrido dado
   rh <== total[0] + total[1] + total[2]; //Si ha ganado algun jugador horizontalmente, se guarda en rh

  
   //Recorrido Vertical//=================================================================================================================================================
   
   //***Variables de R.V**//
   signal suma_circulo2[n][n+1]; //SUma acumulada circulos
   signal suma_cruz2[n][n+1]; //SUma acumulada cruces

   component circulo1[n][n] ; //Igualdad circulo en el tablero para recorrido vertical
   component cruz1[n][n]; //Igualsas cruz en tablero para r.vertical
    
   signal total1[n];
   component alineacion_circulo1[n];
   component alineacion_cruz1[n];

   for(var j = 0; j < n; j++){
         suma_circulo2[j][0] <== 0;
         suma_cruz2[j][0] <== 0;
	 for(var i = 0; i < n; i++){ 
	 	circulo1[i][j] = igualdadRepetida(0);
		cruz1[i][j] = igualdadRepetida(1);
	 
                circulo1[i][j].in <== tablero[i][j];
                cruz1[i][j].in <== tablero[i][j];

                suma_circulo2[j][i+1] <== suma_circulo2[j][i] + circulo1[i][j].out;
                suma_cruz2[j][i+1] <== suma_cruz2[j][i] + cruz1[i][j].out;     
        }
	
	alineacion_circulo1[j]  = igualdadRepetida(n);
	alineacion_cruz1[j] = igualdadRepetida(n);
	
	
        alineacion_circulo1[j].in <== suma_circulo2[j][n];
        alineacion_cruz1[j].in <== suma_cruz2[j][n];

        total1[j] <== alineacion_circulo1[j].out * 1 + alineacion_cruz1[j].out * 2; //Si hay circulo
   }

   rv <== total1[0] + total1[1] + total1[2];

   //Recorrido Diagonal 1//=================================================================================================================================================
   
   //***Variables de R.D1***//
   signal suma_circulo3[n+1];
   signal suma_cruz3[n+1];
   component circulo2[n][n];
   component cruz2[n][n];

   
   component alineacion_circulo2 = igualdadRepetida(n);
   component alineacion_cruz2 = igualdadRepetida(n);

   //***Inicialización de las variables de R.D2***// //(Si no son iniciadas peta porque no tiene ningún valor desde el que empezar el sumatorio)
   suma_circulo3[0] <== 0;
   suma_cruz3[0] <== 0;
   
   //***Recorrido de la diagonal principal***//
   for(var i = 0; i < n; i++){
   	circulo2[i][i] = igualdadRepetida(0);
	cruz2[i][i] = igualdadRepetida(1);
   
	circulo2[i][i].in <== tablero[i][i];
        cruz2[i][i].in <== tablero[i][i];

        suma_circulo3[i+1] <== suma_circulo3[i] + circulo2[i][i].out;
        suma_cruz3[i+1] <== suma_cruz3[i] + cruz2[i][i].out;

   }
	
   //Comprobamos si después de recorrer la diagonal hay algun ganador o si no lo hay
   alineacion_circulo2.in <== suma_circulo3[n];
   alineacion_cruz2.in <== suma_cruz3[n];


   //SI lo hay, rd1 == 1 si hubo una alineacion de circulo o rd1 == 2 si la hubo de cruces, si no hay ganador su valor será 0
   rd1 <== alineacion_circulo2.out * 1 + alineacion_cruz2.out * 2;
   

   //Recorrido Diagonal 2//=================================================================================================================================================
   
   //***Variables de R.D2***//
   signal suma_circulo4[n+1];
   signal suma_cruz4[n+1];
   component circulo3[n][n];
   component cruz3[n][n];


   component alineacion_circulo3 = igualdadRepetida(n);
   component alineacion_cruz3 = igualdadRepetida(n);


   //***Inicialización de las variables de R.D2***// //(Si no son iniciadas peta porque no tiene ningún valor desde el que empezar el sumatorio)
   suma_circulo4[0] <== 0;
   suma_cruz4[0] <== 0;
   
   //***Recorrido de la diagonal inversa***//
   for(var i = 0; i < n; i++){
   
        //Iniciamos el componente por cada celda que comprobamos
   	circulo3[i][n-1-i] = igualdadRepetida(0);
	cruz3[i][n-1-i] = igualdadRepetida(1);
	
	
	//Realizamos la comparacion
        circulo3[i][n-1-i].in <== tablero[i][n-1-i];
        cruz3[i][n-1-i].in <== tablero[i][n-1-i];

        //Actualizamos el sumatorio de cada tipo en función de lo que hubiese en esa celda
        suma_circulo4[i+1] <== suma_circulo4[i] + circulo3[i][n-1-i].out;
        suma_cruz4[i+1] <== suma_cruz4[i] + cruz3[i][n-1-i].out;

   }

   //Comprobamos si después de recorrer la diagonal hay algun ganador o si no lo hay
   alineacion_circulo3.in <== suma_circulo4[n];
   alineacion_cruz3.in <== suma_cruz4[n];

   //SI lo hay, rd2 == 1 si hubo una alineacion de circulo o rd2 == 2 si la hubo de cruces, si no hay ganador su valor será 0
   rd2 <== alineacion_circulo3.out * 1 + alineacion_cruz3.out * 2;




  ganador <== rh +rv +rd1 + rd2; //EN función de la alineacion encontrado (recuerdo que esta versión es para una entrada con un alineación ÚNICA) se diŕa cual es el ganador o si no hay
}

component main = tres_en_raya();

