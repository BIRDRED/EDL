data Exp = Num Float
         | Mul Exp Exp
         | Div Exp Exp 
         | And Exp Exp 
         | Or  Exp Exp 
         | Not Exp 
         | Maior Exp Exp 
         | Menor Exp Exp 
         | MaiorIgual Exp Exp 
         | MenorIgual Exp Exp 
         | Igual Exp Exp 
         | Diferente Exp Exp deriving Show

--LISTA DE EXEMPLOS
--1
ex0 = Num 1
--1 + 10 - 20
ex1 = Mul (Div (Num 1) (Num 10)) (Num 20)
--1 + (10 - 20)
ex2 = Div (Num 1) (Mul (Num 10) (Num 20))
--(5 + 5) - (5 - 5)
ex3 = Mul (Div (Num 5) (Num 5)) (Mul (Num 5) (Num 5))


avalia::Exp -> Float 
avalia (Num i) = i
avalia (Mul e1 e2) = (avalia e1) * (avalia e2)
avalia (Div e1 e2) = (avalia e1) / (avalia e2)
avalia (And a b) =  if (avalia a) /= 0 && (avalia b) /= 0 then 1 else 0
avalia (Or a b) =  if (avalia a) == 0 || (avalia b) == 0 then 0 else 1
avalia (Not a) = if (avalia a) /= 0 then 0 else 1
avalia (Maior a b) = if (avalia a) > (avalia b) then 1 else 0
avalia (Menor a b) = if (avalia a) < (avalia b) then 1 else 0
avalia (MaiorIgual a b) = if (avalia a) >= (avalia b) then 1 else 0
avalia (MenorIgual a b) = if (avalia a) <= (avalia b) then 1 else 0
avalia (Igual a b) = if (avalia a) == (avalia b) then 1 else 0
avalia (Diferente a b) = if (avalia a) /= (avalia b) then 1 else 0


avalia'::Exp -> Exp
avalia' (Num i) = (Num i)
avalia' (Mul (Num e1) (Num e2)) = Num (e1 * e2)
avalia' (Mul e1 e2)  = (avalia' (Mul (avalia' e1) (avalia' e2)))
avalia' (Div (Num e1) (Num e2)) = Num (e1 / e2)
avalia' (Div e1 e2)  = (avalia' (Div (avalia' e1) (avalia' e2)))
avalia' (And (Num a) (Num b)) =  if a /= 0 && b /= 0 then Num 1 else Num 0
avalia' (And a b) = (avalia' (And (avalia' a) (avalia' b)))
avalia' (Or (Num a) (Num b)) =  if a == 0 || b == 0 then Num 0 else Num 1
avalia' (Or a b) = (avalia' (Or (avalia' a) (avalia' b)))
avalia' (Not (Num a)) = if a /= 0 then Num 0 else Num 1
avalia' (Not a) = (avalia' (Not (avalia' a)))
avalia' (Maior (Num a) (Num b)) = if a > b then Num 1 else Num 0
avalia' (Maior a b) = (avalia' (Maior (avalia' a) (avalia' b)))
avalia' (Menor (Num a) (Num b)) = if a < b then Num 1 else Num 0
avalia' (Menor a b) = (avalia' (Menor (avalia' a) (avalia' b)))
avalia' (MaiorIgual (Num a) (Num b)) = if a >= b then Num 1 else Num 0
avalia' (MaiorIgual a b) = (avalia' (MaiorIgual (avalia' a) (avalia' b)))
avalia' (MenorIgual (Num a) (Num b)) = if a <= b then Num 1 else Num 0
avalia' (MenorIgual a b) = (avalia' (MenorIgual (avalia' a) (avalia' b)))
avalia' (Igual (Num a) (Num b)) = if a == b then Num 1 else Num 0
avalia' (Igual a b) = (avalia' (Igual (avalia' a) (avalia' b)))
avalia' (Diferente (Num a) (Num b)) = if a /= b then Num 1 else Num 0
avalia' (Diferente a b) = (avalia' (Diferente (avalia' a) (avalia' b)))

e0 = Diferente (Num 2) (Num 3)
e1 = Mul (Mul (Mul (Num 1) (Num 2)) (Num 3)) (Num 4)
e2 = Mul (Num 1) (Mul (Num 2) (Div (Num 3) (Num 4)))
e3 = Div (Div (Div (Num 1) (Num 2)) (Num 3)) (Num 4)
e4 = Div (Num 1) (Div (Num 2) (Div (Num 3) (Num 4)))
e5 = Div (Div (Num 1) (Num 2)) (Div (Num 3) (Num 4))



main = print (avalia' e0)