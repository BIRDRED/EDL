type Amb = String -> Int

data Cmd = Atr String Exp   -- atribuicao, ex.: x=1
         | Seq Cmd Cmd      -- sequencia,  ex.: x=1 ; y=x
         deriving Show

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Var String
         deriving Show


--x=1
c0 = Atr "x" (Num 1)
--x = 1 + x - 20
c1 = Atr "x" (Sub (Add (Num 1) (Var "x")) (Num 20))
--x = 1 ; y = 2 ; z = x+y
c2 = Seq (Atr "x" (Num 1)) (Seq (Atr "y" (Num 2)) (Atr "z" (Add (Var "x") (Var "y"))))


avaliaExp :: Amb -> Exp -> Int
avaliaExp amb (Num v)     = v
avaliaExp amb (Add e1 e2) = (avaliaExp amb e1) + (avaliaExp amb e2)
avaliaExp amb (Sub e1 e2) = (avaliaExp amb e1) - (avaliaExp amb e2)
avaliaExp amb (Var id) = amb id

avaliaCmd :: Amb -> Cmd -> Amb
avaliaCmd amb (Atr id e1) = (\x -> if x == id then v else amb x) where v = avaliaExp amb e1
avaliaCmd amb (Seq c1 c2) = avaliaCmd amb' c2 where amb' = avaliaCmd amb c1


amb0 :: Amb
amb0 id = 0

e1 = Num 1

avaliaProg :: Cmd -> Int
avaliaProg (Atr id e1) = avaliaExp amb0 e1
avaliaProg (Seq c1 c2) = avaliaExp (avaliaCmd (avaliaCmd amb0 c1) c2) e1

c3 = Atr "x" (Add (Num 1) (Num 2))
--Resposta: x = 1 + 2 -- (valor final x=3)
c4 = Seq (Atr "x" (Num 10)) (Atr "x" (Num 1))
-- x = 10 ; x = 1 ; valor final x = 1
c5 = Seq (Atr "x" (Num 1)) (Seq (Atr "y" (Add (Var "x") (Num 1))) (Atr "x" (Var "y")))
-- x = 1; y = x + 1; x = y; valor final x = 2


main = print (avaliaProg c3)


