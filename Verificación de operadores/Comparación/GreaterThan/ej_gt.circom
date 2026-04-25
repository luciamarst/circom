pragma circom 2.2.2;

template greatherThan(n) autocomplete{
	signal input a;
	signal input b;
	signal output c;

	c<--a >_(n) b;


}

component main = greatherThan(3);
