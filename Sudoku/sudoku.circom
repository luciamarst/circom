pragma circom 2.2.2;
include "comparators.circom";

template ValidarGrupo9() {
    signal input array[9];
    signal output out;

    component es_igual[9][9];
    signal cuenta_numero[9];
    component verig_uno[9];
    signal grupo_ok[9];

    for (var num = 1; num <= 9; num++) {
        var acumulador = 0;
        for (var i = 0; i < 9; i++) {
            es_igual[num-1][i] = IsEqual();
            es_igual[num-1][i].in[0] <== array[i];
            es_igual[num-1][i].in[1] <== num;
            acumulador += es_igual[num-1][i].out;
        }
        cuenta_numero[num-1] <-- acumulador;
        
        // Comprobamos si la cuenta es exactamente 1 (devuelve 1 si es correcto, 0 si no)
        verig_uno[num-1] = IsEqual();
        verig_uno[num-1].in[0] <== cuenta_numero[num-1];
        verig_uno[num-1].in[1] <== 1;
        grupo_ok[num-1] <== verig_uno[num-1].out;
    }

    // Multiplicamos en cascada para ver si los 9 números del grupo aparecieron exactamente 1 vez
    signal mult_g[8];
    mult_g[0] <== grupo_ok[0] * grupo_ok[1];
    for (var i = 1; i < 8; i++) {
        mult_g[i] <== mult_g[i-1] * grupo_ok[i+1];
    }
    out <== mult_g[7];
}

template ValidarFilas() {
    signal input tablero[9][9];
    signal output out;

    component validadores[9];
    signal fila_ok[9];

    for (var f = 0; f < 9; f++) {
        validadores[f] = ValidarGrupo9();
        for (var c = 0; c < 9; c++) {
            validadores[f].array[c] <== tablero[f][c];
        }
        fila_ok[f] <== validadores[f].out;
    }

    signal mult[8];
    mult[0] <== fila_ok[0] * fila_ok[1];
    for (var i = 1; i < 8; i++) {
        mult[i] <== mult[i-1] * fila_ok[i+1];
    }
    out <== mult[7];
}

template ValidarColumnas() {
    signal input tablero[9][9];
    signal output out;

    component validadores[9];
    signal col_ok[9];

    for (var c = 0; c < 9; c++) {
        validadores[c] = ValidarGrupo9();
        for (var f = 0; f < 9; f++) {
            validadores[c].array[f] <== tablero[f][c];
        }
        col_ok[c] <== validadores[c].out;
    }

    signal mult[8];
    mult[0] <== col_ok[0] * col_ok[1];
    for (var i = 1; i < 8; i++) {
        mult[i] <== mult[i-1] * col_ok[i+1];
    }
    out <== mult[7];
}

template ValidarSubtableros() {
    signal input tablero[9][9];
    signal output out;

    component validadores[9];
    signal sub_ok[9];

    var box = 0;
    for (var fila_inicio = 0; fila_inicio < 9; fila_inicio += 3) {
        for (var col_inicio = 0; col_inicio < 9; col_inicio += 3) {
            
            validadores[box] = ValidarGrupo9();
            
            var idx = 0;
            for (var f = 0; f < 3; f++) {
                for (var c = 0; c < 3; c++) {
                    validadores[box].array[idx] <== tablero[fila_inicio + f][col_inicio + c];
                    idx++;
                }
            }
            sub_ok[box] <== validadores[box].out;
            box++;
        }
    }

    signal mult[8];
    mult[0] <== sub_ok[0] * sub_ok[1];
    for (var i = 1; i < 8; i++) {
        mult[i] <== mult[i-1] * sub_ok[i+1];
    }
    out <== mult[7];
}

template sudoku() {
    signal input tablero[9][9];
    signal output salida;

    component f_val = ValidarFilas();
    f_val.tablero <== tablero;

    component c_val = ValidarColumnas();
    c_val.tablero <== tablero;

    component s_val = ValidarSubtableros();
    s_val.tablero <== tablero;

    signal paso_parcial <== f_val.out * c_val.out;
    salida <== paso_parcial * s_val.out;
}

component main = sudoku();
