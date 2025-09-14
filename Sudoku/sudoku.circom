pragma circom 2.0.0;
include "node_modules/circomlib/circuits/comparators.circom";


template igualdadRepetida(val){
        signal input in;
        signal output out;

        component cmp = IsEqual();
        cmp.in[0] <== in;
        cmp.in[1] <== val;
        out <== cmp.out;
}

//=========================================EXTRAS================================================
template iniciar(){ //Funcion encargada de iniciar cada fila a extraer antes de asignarle su valor real
    signal output out[9]; //Fila que queremos rellenar

    for(var i = 0; i < 9; i++){
        out[i] <== 0;
    }
}

template sumatorio(){ //Funcion encargada de comprobar si la suma de los numeros que componen cada elemento es 45
    signal input array[9];
    signal output completa;

    var sumatorio = 0;

    for(var i = 0; i < 9; i++){
        sumatorio += array[i];
    }

    var cmp = igualdadRepetida(45)(sumatorio);
    completa <== cmp;
}

template completas(){ //Funcion encargada de comprobar que de los 9 elementos (fila,columnas,subtablero) lo cumplen todos
    signal input in;
    signal output out;

    var cmp = igualdadRepetida(9)(in);
    out <== cmp;
}

//========================FILAS==================================

template extraerFila(n_fila){ // Función encargada de extraer una fila dada del tablero
    signal input tablero[9][9];
    signal output fila[9];

    for(var i = 0; i < 9; i++){ //Columna
        fila[i] <== tablero[n_fila][i];
    }
}

/* FUNCION GENERAL
    -> Encargada de
        1. Inicializar la fila a extraer
        2. Una vez extraida, asignarle dicha variable la fila extraida
        3. COmprobar que la suma de todos los número de esa fila es 45
        4. Repetir el proceso anterior 9 veces
        5. SI en las 9 iteraciones, se cumple que todas esas filas suman 45, entonces las filas cumplen su condicion
*/
template filas(){ 
    //Entradas y salidas del circuito
    signal input tablero[9][9];
    signal output out;

    var filas_perfectas = 0; // Número de filas que cumplen las condiciones

    component extraccion[9]; //Para la extraccion de cada fila
    component comprobar_fila[9]; //Para comprobar que cada fila tiene lo numeros [1..9]
    component inicializar[9]; //Para iniciar cada fila a 0 antes de extraerlas del tablero

    // Para cada dila que tenemos
    for(var fila=0; fila < 9; fila++){
        
        //Iniciar todos los valores de la fila a 0
        var fila_completa[9];
        inicializar[fila] = iniciar();
        fila_completa = inicializar[fila].out;
        

        // Del tablero extraemos fila a fila
        extraccion[fila] = extraerFila(fila);
        extraccion[fila].tablero <== tablero;
        
        // Una vez hemos extraido la fila, queda almacenada en fila_completa
        fila_completa = extraccion[fila].fila;

        // UNa vez tenemos la fila, comprobamos si ésta cumple las condiciones
        comprobar_fila[fila] = sumatorio();
        comprobar_fila[fila].array <== fila_completa;

        filas_perfectas = filas_perfectas + comprobar_fila[fila].completa; //Si contiene todos los números sin repeticiones tendremos una fila mas correcta
    }

    // Despues de comprobar todas las filas, si filas_perfectas = 9, entonces todas las filas cumplen la condicion

    component comprobacion_condicion_filas = completas(); //Lllamamos a la funcion con in: filas_perfectas
    comprobacion_condicion_filas.in <== filas_perfectas;
    out <== comprobacion_condicion_filas.out; //Devolvemos el valor de comprobar si el número de filas que cumplen la condicion es 9
    
}

//==============================COLUMNAS=============================================
template extraerColumna(n_columna){ // Extrae una columna dad del tablero
    signal input tablero[9][9];
    signal output columna[9];

    for(var i = 0; i < 9; i++){ //FIla
        columna[i] <== tablero[i][n_columna];
    }
}

/* FUNCION GENERAL
    -> Encargada de
        1. Inicializar la columna a extraer
        2. Una vez extraida, asignarle dicha variable la columna extraida
        3. COmprobar que la suma de todos los número de esa columna es 45
        4. Repetir el proceso anterior 9 veces
        5. SI en las 9 iteraciones, se cumple que todas esas columna suman 45, entonces las columnas cumplen su condicion
*/
template columnas(){
    //Entradas y salidas del circuito
    signal input tablero[9][9];
    signal output out;

    var columnas_perfectas = 0; // Número de filas que cumplen las condiciones

    component extraccion[9]; //Para la extraccion de cada fila
    component comprobar_columna[9]; //Para comprobar que cada fila tiene lo numeros [1..9]
    component inicializar[9]; //Para iniciar cada fila a 0 antes de extraerlas del tablero

    // Para cada dila que tenemos
    for(var columna=0; columna < 9; columna++){
        
        //Iniciar todos los valores de la fila a 0
        var columna_completa[9];
        inicializar[columna] = iniciar();
        columna_completa = inicializar[columna].out;
        

        // Del tablero extraemos fila a fila
        extraccion[columna] = extraerColumna(columna);
        extraccion[columna].tablero <== tablero;
        
        // Una vez hemos extraido la fila, queda almacenada en fila_completa
        columna_completa = extraccion[columna].columna;

        // UNa vez tenemos la fila, comprobamos si ésta cumple las condiciones
        comprobar_columna[columna] = sumatorio();
        comprobar_columna[columna].array <== columna_completa;

        columnas_perfectas = columnas_perfectas + comprobar_columna[columna].completa; //Si contiene todos los números sin repeticiones tendremos una fila mas correcta
    }

    // Despues de comprobar todas las filas, si filas_perfectas = 9, entonces todas las filas cumplen la condicion

    component comprobacion_condicion_columna = completas(); //Lllamamos a la funcion con in: filas_perfectas
    comprobacion_condicion_columna.in <== columnas_perfectas;
    out <== comprobacion_condicion_columna.out; //Devolvemos el valor de comprobar si el número de filas que cumplen la condicion es 9
}

//==============================SUBTABLEROS=============================================
template extraerSubtablero(f_s,c_s){ // Extrae un subtablero dado del tablero
    signal input tablero[9][9];
    signal output out[9];

    var indice = 0;
    for(var i = f_s; i < f_s+3; i++){
        for(var j = c_s; j < c_s+3;j++){
            out[indice] <== tablero[i][j];
            indice = indice + 1;
        }
    }
}

template subtablero(){
    //Entradas y salidas del circuito
    signal input tablero[9][9];
    signal output out;

    var subtableros_perfectos = 0; // Número de subtableros que cumplen las condiciones
    var fila_sub = 0;
    var columna_sub = 0;

    component inicializar[9]; //Para iniciar cada subtablero a 0 antes de extraerlas del tablero
    component extraccion[9]; //Para la extraccion de cada subtablero
    component comprobar_subtablero[9]; //Para comprobar que cada subtablero tiene lo numeros [1..9]

    // Para cada dila que tenemos
    for(var subtablero=0; subtablero < 9; subtablero++){
        
        //Iniciar todos los valores de la fila a 0
        var subtablero_completo[9];
        inicializar[subtablero] = iniciar();
        subtablero_completo = inicializar[subtablero].out;
        

        // Del tablero extraemos fila a fila
        extraccion[subtablero] = extraerSubtablero(fila_sub, columna_sub);
        extraccion[subtablero].tablero <== tablero;
        
        // Una vez hemos extraido la fila, queda almacenada en fila_completa
        subtablero_completo = extraccion[subtablero].out;

        // UNa vez tenemos la fila, comprobamos si ésta cumple las condiciones
        comprobar_subtablero[subtablero] = sumatorio();
        comprobar_subtablero[subtablero].array <== subtablero_completo;

        subtableros_perfectos = subtableros_perfectos + comprobar_subtablero[subtablero].completa; //Si contiene todos los números sin repeticiones tendremos una fila mas correcta
    
        //Aumentamos las variables de fila y columna sub

        columna_sub = columna_sub + 3;

        if(columna_sub == 9){
            columna_sub = 0;
            fila_sub = fila_sub + 3;
        }
    }

    // Despues de comprobar todas las filas, si filas_perfectas = 9, entonces todas las filas cumplen la condicion

    component comprobacion_condicion_subtablero = completas(); //Lllamamos a la funcion con in: filas_perfectas
    comprobacion_condicion_subtablero.in <== subtableros_perfectos;
    out <== comprobacion_condicion_subtablero.out; //Devolvemos el valor de comprobar si el número de filas que cumplen la condicion es 9

}

//================================COMPROBACIÓN========================================
//Comprobar que las 3 condiciones se cumplen
template comprobarCondicionFinal(){
    signal input filas;
    signal input columnas;
    signal input subtableros;
    signal output out;

    component cmp = IsEqual();
    cmp.in[0] <== (filas + columnas + subtableros);
    cmp.in[1] <== 3;

    out <== cmp.out;
}

//=================================== SUDOKU ===============================================
template sudoku () {

    //Representación de un tablero 9x9, que es la entrada 
    signal input tablero[9][9];

    // La salida es si se ha resuelto correctamente
    signal output salida;

    //Una vez tenemos este tablero, tenemos que realizar las siguientes comprobaciones
    /*
        1. Cada fila del tablero tiene que tener los numero 1-9, hay que comprobar esto 9 veces
        2. Cada columna del tablero tiene que tener los numeros 1-9, hay que comprobar esto 9 veces
        3. Dentro del tablero tenemos 9 subtableros de 3x3, dentro de estos subtableros tenemos que comprobar que tienen los numeros 1-9 exactamente    
    */

    //==============================FILAS======================================================================
    component filas_funcion = filas();
    filas_funcion.tablero <== tablero;

    //==============================COLUMNAS======================================================================
    component columnas_funcion = columnas();
    columnas_funcion.tablero <== tablero;

    //==============================SUBTABLEROS======================================================================
    component subtableros_funcion = subtablero();
    subtableros_funcion.tablero <== tablero;

    //=========================================SALIDA=======================================================
    salida <== comprobarCondicionFinal()(filas_funcion.out, columnas_funcion.out, subtableros_funcion.out); //SI s ecumplen las 3 la suma será == 3, por tanto la salida será 1, de lo contrario, salida = 0
}   


component main = sudoku();