pragma circom 2.2.2;
template andb() autocomplete{
	signal input a;
	signal input b;
	signal output c;
	
	
	c<--a&_(1) b;
}

component main = andb();
