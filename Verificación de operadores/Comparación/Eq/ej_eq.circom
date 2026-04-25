pragma circom 2.2.2;

template IsEqual() autocomplete{
	signal input a;
	signal input b;
	signal output c;

	c<--a==_(2)b;
}

component main = IsEqual();
