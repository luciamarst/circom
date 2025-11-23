- Las macros en Rust son metaprogramación en tiempo de compilación., generando código a partir de la sintaxis que se le pasa. 
### format
- $(...)* : Significa que captura cualquier cantidad de tokens
- tt es un token tree, es de cir, cualquifragmneto válido de Rust
- Vamos, que el format acepta todo
- Una vez que ($($arg:tt)* ) captura cualquier cosa:
  1) format_args! transforma lo que nos llega en argumentos
  2) Se llama a la función que produce el String
  3) El resultado se devuelve como must_use para obligar a usarlo