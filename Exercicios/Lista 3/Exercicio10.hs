type Amb = String -> Int

data Cmd = Atr String Exp
         | Seq Cmd Cmd
         | Cnd Exp Cmd Cmd
         | Rep Exp Cmd
         deriving Show

data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Mul Exp Exp
         | Var String
         deriving Show


avaliaExp :: Amb -> Exp -> Int
avaliaExp amb (Num v)     = v
avaliaExp amb (Add e1 e2) = (avaliaExp amb e1) + (avaliaExp amb e2)
avaliaExp amb (Sub e1 e2) = (avaliaExp amb e1) - (avaliaExp amb e2)
avaliaExp amb (Mul e1 e2) = (avaliaExp amb e1) * (avaliaExp amb e2)
avaliaExp amb (Var id) = amb id

avaliaCmd :: Amb -> Cmd -> Amb
avaliaCmd amb (Atr id e1) = (\x -> if x == id then v else amb x) where v = avaliaExp amb e1
avaliaCmd amb (Seq c1 c2)  = avaliaCmd amb' c2 where amb' = avaliaCmd amb c1
avaliaCmd amb (Cnd exp c1 c2) = if (avaliaExp amb exp) /= 0 then avaliaCmd amb c1 else avaliaCmd amb c2
avaliaCmd amb (Rep e1 c1) = if (avaliaExp amb e1) > 0 then avaliaCmd (avaliaCmd amb c1) (Rep (Num ((avaliaExp amb e1) - 1)) c1) else avaliaCmd amb c1



amb0 :: Amb
amb0 id = 0

e1 = Num 0

p1 = Cnd (Num 0) (Atr "x" (Num 10)) (Atr "x" (Num 99))
p2 = Rep (Num 2) (Atr "x" (Add (Num 1) (Var "x")))
p3 = Rep (Num 10) (Atr "x" (Mul (Num 10) (Num 10)))
main = print ((avaliaCmd amb0 p3) "x")


