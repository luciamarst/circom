pragma circom 2.2.2;

template funcion() autocomplete{
	signal input a;
	signal input b;
	signal output c;
	
	c <-- 1*a*b + a*a + (-3)*b;
	

}

component main = funcion();
