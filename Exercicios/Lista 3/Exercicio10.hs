type Amb = String -> Int

data Cmd = Atr String Exp
         | Seq Cmd Cmd
         | Cnd Exp Cmd Cmd
         | Rep Exp Cmd deriving Show

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Mul Exp Exp
         | Var String
         | And Exp Exp 
         | Or  Exp Exp 
         | Not Exp 
         | Maior Exp Exp 
         | Menor Exp Exp 
         | MaiorIgual Exp Exp 
         | MenorIgual Exp Exp 
         | Igual Exp Exp 
         | Diferente Exp Exp 
         deriving Show


avaliaExp :: Amb -> Exp -> Int
avaliaExp amb (Num v)     = v
avaliaExp amb (Add e1 e2) = (avaliaExp amb e1) + (avaliaExp amb e2)
avaliaExp amb (Sub e1 e2) = (avaliaExp amb e1) - (avaliaExp amb e2)
avaliaExp amb (Mul e1 e2) = (avaliaExp amb e1) * (avaliaExp amb e2)
avaliaExp amb (Var id) = amb id
avaliaExp amb (And a b) =  if (avaliaExp amb a) /= 0 && (avaliaExp amb b) /= 0 then 1 else 0
avaliaExp amb (Or a b) =  if (avaliaExp amb a) == 0 || (avaliaExp amb b) == 0 then 0 else 1
avaliaExp amb (Not a) = if (avaliaExp amb a) /= 0 then 0 else 1
avaliaExp amb (Maior a b) = if (avaliaExp amb a) > (avaliaExp amb b) then 1 else 0
avaliaExp amb (Menor a b) = if (avaliaExp amb a) < (avaliaExp amb b) then 1 else 0
avaliaExp amb (MaiorIgual a b) = if (avaliaExp amb a) >= (avaliaExp amb b) then 1 else 0
avaliaExp amb (MenorIgual a b) = if (avaliaExp amb a) <= (avaliaExp amb b) then 1 else 0
avaliaExp amb (Igual a b) = if (avaliaExp amb a) == (avaliaExp amb b) then 1 else 0
avaliaExp amb (Diferente a b) = if (avaliaExp amb a) /= (avaliaExp amb b) then 1 else 0

avaliaCmd :: Amb -> Cmd -> Amb
avaliaCmd amb (Atr id e1) = (\x -> if x == id then v else amb x) where v = avaliaExp amb e1
avaliaCmd amb (Seq c1 c2)  = avaliaCmd amb' c2 where amb' = avaliaCmd amb c1
avaliaCmd amb (Cnd exp c1 c2) = if (avaliaExp amb exp) /= 0 then avaliaCmd amb c1 else avaliaCmd amb c2
avaliaCmd amb (Rep exp c1) = if (avaliaExp amb exp) /= 0 then avaliaCmd amb' (Rep exp c1)  else  amb' where amb' = avaliaCmd amb c1


amb0 :: Amb
amb0 id = 0

e1 = Num 0

p1 = Cnd (Num 0) (Atr "x" (Num 10)) (Atr "x" (Num 99))
p2 = Rep (Num 2) (Atr "x" (Add (Num 1) (Var "x")))
p3 = Rep (Num 10) (Atr "x" (Mul (Num 10) (Num 10)))
prog = Seq (Atr "x" (Num 10)) (Seq (Atr "y" (Num 10)) (Rep (Add (Num 0) (Num 10)) (Atr "x" (Mul (Var "x") (Var "y")))))

--soma de x até y
{-amb::Amb
amb "x" = 1
amb "y" = 2
amb "soma" = 0
amb _ = 2
cmd1 = Rep (Menor (Var "x") (Var "y")) (Seq (Atr "soma" (Add (Var "soma") (Var "x"))) (Atr "x" (Add (Var "x") (Num 1))))
main = print ((avaliaCmd amb cmd1) "soma")-}

-- soma dos quadrados de 1 até 10
amb::Amb
amb "x" = 1
amb "y" = 2
amb "soma" = 0
amb _ = 10
cmd1 = Rep (Menor (Var "x") (Var "y")) (Seq (Atr "soma" (Add (Var "soma") (Mul (Var "x") (Var "x")))) (Atr "x" (Add (Var "x") (Num 1))))
main = print ((avaliaCmd amb cmd1) "soma")

