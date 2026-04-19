Primeramente, generamos los archivos r1cs:
```
/home/lucia/Documentos/GitHub/circom_autocomplete/target/release/circom ej_eq.circom --r1cs --O0

```

```
/home/lucia/Documentos/GitHub/circom_autocomplete/target/release/circom ej_eq_circomlib.circom --r1cs --O0

```


Una ves tenemos los archivos R1CS de los archivos a comparar, tenemos que aplicar el solver con el comando correcto para poder aplicar el ffsol a zkgenver es:

```
/home/lucia/ZK-GENVER-work_circom/target/release/zkgenver ej_eq.r1cs --solver ffsol
```

Todo esto después de haber añadido a las variables de entorno (_Concretamente a la variable $LD_LIBRARY_PATH_) la ruta.
```
export LD_LIBRARY_PATH=/home/lucia/proving_unsat/z3-z3-4.16.0/build:$LD_LIBRARY_PATH
```

Una vez que que ejecutamos el primer comando, si todo ha salido guay deberiamos ver algo omo esto:
![[Pasted image 20260416195544.png]]


Una vez hemos verificado que los dos sistemas de ecuaciones construidos por cada programa circom son deterministas, es decir, para cada señal es imposible que haya más de un valor de forma que siga cumpliendo el sistema, podemos proceder a checkear si funciona guay para X entradas.

Para ello, tenemos que generar los archivos $*$.smt2:
```
/home/lucia/ZK-GENVER-work_circom/target/release/zkgenver ej_eq.r1cs --solver ffsol --verbose
```

EL verbose es necesario porque hay un bloque de código en Rust que pone que si no utilizamos el verbose lo que hace ffsol es generar el archivo smt2, usarlo para verificar y una vez acabe eliminarlo. Al añadir el verbose lo crea y no lo elimina al acabar.

```
../ZK-GENVER/target/release/zkgenver ej_eq.r1cs --solver ffsol --check_equivalence ej_eq_circomlib.r1cs
```


