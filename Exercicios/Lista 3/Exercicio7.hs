type Amb = String -> Int

data Cmd = Atr String Exp   -- atribuicao, ex.: x=1
         | Seq Cmd Cmd      -- sequencia,  ex.: x=1 ; y=x
         deriving Show

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Var String
         deriving Show




--c0 = Atr "x" (Num 1)
--x = 1 + x - 20
--c1 = Atr "x" (Sub (Add (Num 1) (Var "x")) (Num 20))
--x = 1 ; y = 2 ; z = x+y
c21 = (Atr "x" (Num 1)) 
c22 = (Atr "y" (Num 2))
c23 = (Atr "z" (Add (Var "x") (Var "y")))

avaliaExp :: Amb -> Exp -> Int
avaliaExp amb (Num v)     = v
avaliaExp amb (Add e1 e2) = (avaliaExp amb e1) + (avaliaExp amb e2)
avaliaExp amb (Sub e1 e2) = (avaliaExp amb e1) - (avaliaExp amb e2)
avaliaExp amb (Var id) = amb id

avaliaCmd :: Amb -> Cmd -> Amb
avaliaCmd amb (Atr id exp) = (\x -> if x==id then v
                                             else amb x)
                             where v = avaliaExp amb exp
avaliaCmd amb (Seq c1 c2)  = avaliaCmd amb' c2
                             where amb' = avaliaCmd amb c1



c0 = (Atr "x" (Add (Num 1) (Num 2)))
c1 = Seq (Atr "x" (Num 10)) (Atr "x" (Num 1))
c2 = Seq (Atr "x" (Num 1)) (Seq (Atr "y" (Add (Var "x") (Num 1))) (Atr "x" (Var "y")))
amb0 :: Amb
amb0 id = 0

main = print ((avaliaCmd amb0 c2) "x")