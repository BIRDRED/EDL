type Amb = [(String,Int)]

data MyMaybe a = MyJust a | MyNothing deriving Show

data Cmd = Atr String Exp
         | Seq Cmd Cmd
         | Cnd Exp Cmd Cmd
         | Rep Exp Cmd 
         | Dcl String deriving Show

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
         | Diferente Exp Exp deriving Show


avaliaExp :: Amb -> Exp -> Int
avaliaExp amb (Num v)     = v
avaliaExp amb (Add e1 e2) = (avaliaExp amb e1) + (avaliaExp amb e2)
avaliaExp amb (Sub e1 e2) = (avaliaExp amb e1) - (avaliaExp amb e2)
avaliaExp amb (Mul e1 e2) = (avaliaExp amb e1) * (avaliaExp amb e2)
avaliaExp amb (Var s) = foldr (\(var, val) a -> if var == s then val else a) 0 amb
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
avaliaCmd amb (Atr id e1) = filter (\(var, val) -> if var == id then False else True) amb ++ [(id, avaliaExp amb e1)]
avaliaCmd amb (Seq c1 c2)  = avaliaCmd amb' c2 where amb' = avaliaCmd amb c1
avaliaCmd amb (Cnd exp c1 c2) = if (avaliaExp amb exp) /= 0 then avaliaCmd amb c1 else avaliaCmd amb c2
avaliaCmd amb (Rep exp c1) = if (avaliaExp amb exp) /= 0 then avaliaCmd amb' (Rep exp c1)  else  amb' where amb' = avaliaCmd amb c1


verificaExp :: [String] -> Exp -> Bool
verificaExp vars (Var var)   = elem var vars
verificaExp vars (Add e1 e2) = verificaExp vars e1 && verificaExp vars e2
verificaExp vars (Sub e1 e2) = verificaExp vars e1 && verificaExp vars e2
verificaExp vars (Mul e1 e2) = verificaExp vars e1 && verificaExp vars e2
verificaExp _    _           = True


verificaCmd :: [String] -> Cmd -> ([String],Bool)
verificaCmd vars (Dcl var) = (var:vars,True)
verificaCmd vars (Atr var exp) = (vars, (elem var vars) && (verificaExp vars exp))
verificaCmd vars (Seq c1 c2)   = (v2, b1 && b2) where 
								 (v1,b1) = verificaCmd vars c1 
								 (v2,b2) = verificaCmd v1 c2

ambret = [("ret",5)]


verificaProg :: Cmd -> Bool
verificaProg cmd = ok where (vars, ok) = verificaCmd (map (\(var, val) -> var) ambret) cmd

avaliaProg :: Cmd -> MyMaybe Int
avaliaProg cmd = if verificaProg cmd then (foldr (\(var, val) a -> if var == "ret" then MyJust val else a) MyNothing (avaliaCmd ambret cmd)) else MyNothing

main = print (avaliaProg (Atr "ret" (Num 2)))
