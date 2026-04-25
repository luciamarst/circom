pragma circom 2.2.2;

template not() autocomplete{
	signal input a;
	signal output b;

	b<--!a;
}

component main = not();
