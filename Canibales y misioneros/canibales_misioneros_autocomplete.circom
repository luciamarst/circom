pragma circom 2.2.2;

// función para comprobar la validez de cada estado del automata, básicamente ver que en ningun momenot hay mas canibales que misioneros (asi no se los comen)
// asi como ver que se cumplen las reglas como que la barca se mueve alternamente, con al menos 1 persona y maximo 2, etc...
template ValidarTransicion() autocomplete {
    //estado anterior (actual realmente)
    signal input m_ant; // misioneros antes
    signal input c_ant; // canibales antes
    signal input b_ant; // barca antes: 1->izquierda; 0->dcha

    // estado siguiente
    signal input m_sig;
    signal input c_sig;
    signal input b_sig;

    // conocer si se ha resuelto el juego o no
    signal output out;

    // sustituimos la var 
    signal v0;
    signal v1;
    signal v2;
    signal v3;
    signal v4;
    signal v5;
    signal v6;
    signal v7;
    signal v8;
    signal v9;

    // El estado inicial de la transición arranca como válido (1)
    v0 <-- 1;

    // verificamos que la barca a cambiado de una orilla a otra pasando del estado anterior al siguiente
    if (b_ant == 1 && b_sig != 0) {
        v1 <-- 0; 
    } else {
        v1 <-- v0;
    }
    
    if (b_ant == 0 && b_sig != 1) {
         v2 <-- 0; 
    } else {
         v2 <-- v1;
    }

    // calcular cuántos se mueven : la diferencia entre una orilla y la otra
    signal diff_m;
    signal diff_c;
    
    diff_m <-- b_ant * (m_ant - m_sig) + (1 - b_ant) * (m_sig - m_ant);
    diff_c <-- b_ant * (c_ant - c_sig) + (1 - b_ant) * (c_sig - c_ant);

    // 0 < barca < 3
    // 1 <= diff_m + diff_c <= 2
    var total_viajeros = diff_m + diff_c;
    if (total_viajeros <_(2) 1 || total_viajeros >_(2) 2) {
        v3 <-- 0; // Viajan más de 2 o la barca va vacía
    } else {
        v3 <-- v2;
    }

    // no puede haber una diferencia negativa de canibales o misioneros entre un estado y otro
    if (diff_m <_(2) 0) { 
        v4 <-- 0; 
    } else {
        v4 <-- v3;
    }
    
    if (diff_c <_(2) 0) { 
        v5 <-- 0; 
    } else {
        v5 <-- v4;
    }

    // para que los canibales no se coman a lo misioneros --> misioneros >= canibales siempre. A no ser que misioneros = 0
    // orilla izq: si m_sig > 0, entonces m_sig >= c_sig
    if (m_sig >_(2) 0 && m_sig <_(2) c_sig) {
        v6 <-- 0; // hay misioneros, pero mas canibales que misioneros
    } else {
        v6 <-- v5;
    }

    // orilla dcha:  (3-m_sig): si (3-m_sig) > 0, entonces (3-m_sig) >= (3-c_sig) -> c_sig >= m_sig
    var m_der = 3 - m_sig;
    var c_der = 3 - c_sig;
    if (m_der >_(2) 0 && m_der <_(2) c_der) {
        v7 <-- 0; // hay misioneros, pero mas canibales que misioneros
    } else {
        v7 <-- v6;
    }

    // el umeros de canibales y misionerso tiene que estar entre 0 y 3 (incluidos) 0 <= num <= 3
    if (m_sig <_(2) 0 || m_sig >_(2) 3) { 
        v8 <-- 0; 
    } else {
        v8 <-- v7;
    }

    if (c_sig <_(2) 0 || c_sig >_(2) 3) { 
        v9 <-- 0; 
    } else {
        v9 <-- v8;
    }

    // Asignamos el último eslabón de la cadena de validación a la salida final
    out <-- v9;
}

template MisionerosCanibales() autocomplete {
    // el input es la secuencia completa de estados en la orilla izquierda
    // cada paso estado q tiene: [misioneros, caníbales, barca]
    // tenemos 12 estados
    signal input estados[12][3]; 

    // la salida del circuito: 1 si todo perfecto, 0 si se hubo algun estado incorrecto
    signal output salida;

    // forzar a que el estado 0 sea todos en la orilla izquierda
    estados[0][0] === 3; // 3 misioneros
    estados[0][1] === 3; // 3 caníbales
    estados[0][2] === 1; // barca en la izquierda

    // para cada estado creamos un componente encargado de validar ese estado
    component validador[11];
    signal exito_parcial[12];
    exito_parcial[0] <-- 1;
    
    for(var t = 0; t < 11; t++) {
        validador[t] = ValidarTransicion();
        
        // estado.ant
        validador[t].m_ant <-- estados[t][0];
        validador[t].c_ant <-- estados[t][1];
        validador[t].b_ant <-- estados[t][2];

        // estado.sig
        validador[t].m_sig <-- estados[t+1][0];
        validador[t].c_sig <-- estados[t+1][1];
        validador[t].b_sig <-- estados[t+1][2];

        // multiplicamos los éxitos de cada paso, de esta forma con que haya un solo componente estado que no cumple con el juego ya no sirve
        exito_parcial[t+1] <-- exito_parcial[t] * validador[t].out;
    }

    // comprobamos que el ultimo estado cumple las restricciones, si el ultimo estado no se cumple algo ha ido mal
    signal estado_final_ok;
    if (estados[11][0] != 0 || estados[11][1] != 0 || estados[11][2] != 0) {
        estado_final_ok <-- 0;
    } 
    else{
       estado_final_ok <--1;
    }
    // forzar a que la salida refleje el éxito global de la ejecución
    salida <-- exito_parcial[11] * estado_final_ok;
}

component main = MisionerosCanibales();
