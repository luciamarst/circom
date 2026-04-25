pragma circom 2.2.2;

include "comparators.circom";
include "bitify.circom";

template circomlibDivision(n){
    signal input a;
    signal input b;
    signal output salida; //Cociente
 
    component n2b_a = Num2Bits(n);
    n2b_a.in <== a;
    
    component n2b_b = Num2Bits(n);
    n2b_b.in <== b;
 

    signal q<--a\b; //Cociente
    signal r<--a%b; //Cociente

    // Comprobamos que b!=0
    component is_zero = IsZero();
    is_zero.in<==b;
    is_zero.out === 0;
	    

    // Comprobamos que 0<=r<|b|; 0 <= r no hace falta porque al estar en campo finito se entiende
    // r < |b|
    component lt = LessThan(n);
    lt.in[0] <== r;
    lt.in[1] <== b;
    lt.out === 1;

    // Una vez hecho eso, comprobamos que se cumple a === b*q+r
    signal bq <== b * q;    
    a === bq +r;
    salida <==q; 
}

component main = circomlibDivision(3);
