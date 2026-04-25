pragma circom 2.2.2;

template funcion() autocomplete{
	signal input a;
	signal output b;

	b <-- a <<_(4) 2;
}

component main = funcion();
