pragma circom 2.2.2;

template or() autocomplete{
	signal input a;
	signal input b;
	signal output c;

	c<--a||b;
}

component main = or();


