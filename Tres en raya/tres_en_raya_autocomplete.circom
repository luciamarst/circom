pragma circom 2.2.2;

template VerificarLinea() autocomplete {
    signal input casilla[3]; 
    signal output resultado;

    var c1 = casilla[0];
    var c2 = casilla[1];
    var c3 = casilla[2];

    if (c1 == 0 && c2 == 0 && c3 == 0) {
        resultado <-- 1; //  Círculo
    } else {
        if (c1 == 1 && c2 == 1 && c3 == 1) {
            resultado <-- 2; //  Cruz
        } else {
            resultado <-- 0; // Nadie
        }
    }
}


template tres_en_raya_autocomplete() autocomplete {
   signal input tablero[3][3]; 
   signal output ganador; 

   component comp_lineas[8];
   for(var i = 0; i < 8; i++) {
       comp_lineas[i] = VerificarLinea();
   }

   for (var i = 0; i < 3; i++) {
       for (var j = 0; j < 3; j++) {
           comp_lineas[i].casilla[j] <-- tablero[i][j];
           comp_lineas[3 + i].casilla[j] <-- tablero[j][i];
       }
   }

   for (var i = 0; i < 3; i++) {
       comp_lineas[6].casilla[i] <-- tablero[i][i];
       comp_lineas[7].casilla[i] <-- tablero[i][2 - i];
   }

   signal v[8];
   v[0] <-- comp_lineas[0].resultado;

   for(var i = 1; i < 8; i++) {
       var res = comp_lineas[i].resultado;
       if (res == 0) {
           v[i] <-- v[i-1];
       } else {
           v[i] <-- res;
       }
   }

   ganador <-- v[7];
}

component main = tres_en_raya_autocomplete();
