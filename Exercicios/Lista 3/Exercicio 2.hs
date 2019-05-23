data Exp = Num Float
         | Mul Exp Exp
         | Div Exp Exp deriving Show

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

avalia'::Exp -> Exp
avalia' (Num i) = (Num i)
avalia' (Mul (Num e1) (Num e2)) = Num (e1 * e2)
avalia' (Mul e1 e2)  = (avalia' (Mul (avalia' e1) (avalia' e2)))
avalia' (Div (Num e1) (Num e2)) = Num (e1 / e2)
avalia' (Div e1 e2)  = (avalia' (Div (avalia' e1) (avalia' e2)))


e0 = Mul (Num 1) (Num 2)
e1 = Mul (Mul (Mul (Num 1) (Num 2)) (Num 3)) (Num 4)
e2 = Mul (Num 1) (Mul (Num 2) (Div (Num 3) (Num 4)))
e3 = Div (Div (Div (Num 1) (Num 2)) (Num 3)) (Num 4)
e4 = Div (Num 1) (Div (Num 2) (Div (Num 3) (Num 4)))
e5 = Div (Div (Num 1) (Num 2)) (Div (Num 3) (Num 4))



main = print (avalia' e4)