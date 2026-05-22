pragma circom 2.2.2;

include "comparators.circom";

template ValidarTransicion() {
    signal input anterior[3]; 
    signal input siguiente[3];
    signal output out;

    signal m_ant <== anterior[0];
    signal c_ant <== anterior[1];
    signal b_ant <== anterior[2];

    signal m_sig <== siguiente[0];
    signal c_sig <== siguiente[1];
    signal b_sig <== siguiente[2];

    // que la barca alterne
    signal barca_ok;
    barca_ok <-- (b_ant + b_sig == 1) ? 1 : 0;
    barca_ok === 1; 

    // conocer la diferencia de los que van en el barco
    signal diff_m <== b_ant * (m_ant - m_sig - (m_sig - m_ant)) + (m_sig - m_ant);
    signal diff_c <== b_ant * (c_ant - c_sig - (c_sig - c_ant)) + (c_sig - c_ant);

    // 3. 1 <= barco <= 2
    component viajan_ok = LessThan(4);
    viajan_ok.in[0] <== diff_m + diff_c;
    viajan_ok.in[1] <== 3;

    component no_vacia = GreaterThan(4);
    no_vacia.in[0] <== diff_m + diff_c;
    no_vacia.in[1] <== 0;

    
    component diff_m_pos = GreaterEqThan(4);
    diff_m_pos.in[0] <== diff_m;
    diff_m_pos.in[1] <== 0;

    component diff_c_pos = GreaterEqThan(4);
    diff_c_pos.in[0] <== diff_c;
    diff_c_pos.in[1] <== 0;

    // 5. Orilla Izquierda
    component izq_m_geq_c = GreaterEqThan(4);
    izq_m_geq_c.in[0] <== m_sig;
    izq_m_geq_c.in[1] <== c_sig;

    component izq_m_zero = IsZero();
    izq_m_zero.in <== m_sig;
    
    signal orilla_izq_ok <-- (izq_m_zero.out + izq_m_geq_c.out > 0) ? 1 : 0;

    
    signal m_der <== 3 - m_sig;
    signal c_der <== 3 - c_sig;
    component der_m_geq_c = GreaterEqThan(4);
    der_m_geq_c.in[0] <== m_der;
    der_m_geq_c.in[1] <== c_der;

    component der_m_zero = IsZero();
    der_m_zero.in <== m_der;

    signal orilla_der_ok <-- (der_m_zero.out + der_m_geq_c.out > 0) ? 1 : 0;

    // 0 <= num <= 3
    component m_lim_sup = LessEqThan(4);
    m_lim_sup.in[0] <== m_sig;
    m_lim_sup.in[1] <== 3;

    component c_lim_sup = LessEqThan(4);
    c_lim_sup.in[0] <== c_sig;
    c_lim_sup.in[1] <== 3;

    // analizar todos lo visto
    signal mult1 <== viajan_ok.out * no_vacia.out;
    signal mult2 <== mult1 * diff_m_pos.out;
    signal mult3 <== mult2 * diff_c_pos.out;
    signal mult4 <== mult3 * orilla_izq_ok;
    signal mult5 <== mult4 * orilla_der_ok;
    signal mult6 <== mult5 * m_lim_sup.out;
    
    
    out <== mult6 * c_lim_sup.out;
}

template MisionerosCanibales() {
    signal input estados[12][3]; 
    signal output salida;

    estados[0][0] === 3; 
    estados[0][1] === 3; 
    estados[0][2] === 1; 

    component validador[11];
    for(var t = 0; t < 11; t++) {
        validador[t] = ValidarTransicion();
    }

    for(var t = 0; t < 11; t++) {
	for(var i = 0; i < 3; i++) {
	    validador[t].anterior[i]  <== estados[t][i];
	    validador[t].siguiente[i] <== estados[t+1][i];
	}
    }

    signal v[11];
    v[0] <== validador[0].out;
    for(var t = 1; t < 11; t++) {
	v[t] <== v[t-1] * validador[t].out;
    }

    component m_final = IsZero();  m_final.in <== estados[11][0];
    component c_final = IsZero();  c_final.in <== estados[11][1];
    component b_final = IsZero();  b_final.in <== estados[11][2];

    signal meta_parcial <== m_final.out * c_final.out;
    signal meta_ok <== meta_parcial * b_final.out;

    salida <== v[10] * meta_ok;
}

component main = MisionerosCanibales();
