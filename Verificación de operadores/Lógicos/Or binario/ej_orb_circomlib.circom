pragma circom 2.2.2;
include "bitify.circom";

template BitwiseAnd(n) {
    signal input a;
    signal input b;
    signal output out;

    // Pasamos a
    component n2b_a = Num2Bits(n);
    component n2b_b = Num2Bits(n);
    component b2n = Bits2Num(n);

    n2b_a.in <== a;
    n2b_b.in <== b;

    // Aplicamos el && a cada par de bits con una multiplicación
    // Metemos el resultado en bits2num directamente, el resultaod devuelto es decimal
    for (var i = 0; i < n; i++) {
        b2n.in[i] <==n2b_a.out[i] + n2b_b.out[i] - n2b_a.out[i] * n2b_b.out[i];
    }

    out <== b2n.out;
}

component main = BitwiseAnd(1);
