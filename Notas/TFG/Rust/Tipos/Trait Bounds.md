### ¿Qué es un Trait Bound?
- Un trait bound es una restricción de tipo
	- En el compilador, cuando por ejemplo se declara $ArithmeticExpression<C>$,  tienen que especificar que es C.
	- $C: Hash + Eq$,  lo que significa que el tipo debe implementar Hash (Indica que el tipo puede ser hasheado, así se puede usar en un Map) y Eq (Para que pueda compararse con otros).
	- Es decir, para el tipo anterior, se defina que pueda ser comparado y hasheado