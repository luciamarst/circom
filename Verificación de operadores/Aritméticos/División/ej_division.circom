pragma circom 2.2.2;

template funcion() autocomplete{
	signal input a;
	signal input b;
	signal output c;

	c <-- a/_(4) b;

}

component main = funcion();
