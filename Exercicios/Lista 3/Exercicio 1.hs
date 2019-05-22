data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp deriving Show

--LISTA DE EXEMPLOS
--1
ex0 = Num 1
--1 + 10 - 20
ex1 = Sub (Add (Num 1) (Num 10)) (Num 20)
--1 + (10 - 20)
ex2 = Add (Num 1) (Sub (Num 10) (Num 20))
--(5 + 5) - (5 - 5)
ex3 = Sub (Add (Num 5) (Num 5)) (Sub (Num 5) (Num 5))


avalia::Exp -> Int 
avalia (Num i) = i
avalia (Add e1 e2) = (avalia e1) + (avalia e2)
avalia (Sub e1 e2) = (avalia e1) - (avalia e2)


e0 = Add (Num 1) (Num 2)
e1 = Add (Add (Add (Num 1) (Num 2)) (Num 3)) (Num 4)
e2 = Add (Num 1) (Add (Num 2) (Add (Num 3) (Num 4)))
e3 = Sub (Sub (Sub (Num 1) (Num 2)) (Num 3)) (Num 4)
e4 = Sub (Num 1) (Sub (Num 2) (Sub (Num 3) (Num 4)))
e5 = Sub (Sub (Num 1) (Num 2)) (Sub (Num 3) (Num 4))

{-avalia'::Num a => Exp -> Num Int
avalia' (Num i) = i
avalia' (Add e1 e2) = (avalia' e1) + (avalia' e2)
avalia' (Sub e1 e2) = (avalia' e1) - (avalia' e2)-}

main = print (avalia' e0)