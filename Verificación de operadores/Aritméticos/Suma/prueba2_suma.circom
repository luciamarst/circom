pragma circom 2.2.2;

template funcion() autocomplete{
	signal input a;
	signal input b;
	signal output c;

	c <-- a+b * 3 + 10*a;

}

component main = funcion();
