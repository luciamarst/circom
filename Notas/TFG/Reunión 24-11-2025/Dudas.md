
## 1. Representación de la operación división en la memoria
![[Pasted image 20251123131539.png]]
- Aquí definí la operación pensando en la expresión $a = b * q +r$, pero realmente para la división (/) solo necesitamos $a = b*q$ (Forzamos a que q sea exactamente el valor del resultado a/b). La notación debería ser:
$$TC(a/b) = (C_1 ∪ C_2 ∪ \{a' = b' + q_{aux} = 0\}, q_{aux})$$

- Mientras que para la división entera (\) debería conservarse el resto, ya que tenemos que 
- Tendríamos que diferenciar entre división entera y real![[Pasted image 20251123140302.png]]