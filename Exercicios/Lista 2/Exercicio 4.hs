data Arvore a = Folha | Galho a (Arvore a) (Arvore a) deriving Show

a1 = Galho 10 (Galho 10 Folha Folha) (Galho 20 Folha Folha)
a2 = Galho 20 (Galho 10 (Galho 10 Folha Folha) Folha) Folha
a3 = Galho 10 Folha (Galho 10 (Galho 10 Folha Folha) (Galho 40 Folha Folha))

soma::Num a => Arvore a -> a 
soma Folha = 0
soma (Galho n arv1 arv2) = n + soma arv1 + soma arv2

dobra::Num a => Arvore a-> Arvore a 
dobra  Folha = Folha
dobra (Galho n arv1 arv2) = Galho (n*2) (dobra arv1) (dobra arv2)

--Sem ter Arvore Binária
possui::Ord a => a -> Arvore a-> Bool
possui x Folha = False
possui x (Galho v esq dir) = x==v || possui x esq || possui x dir

--Na Arvore Binária
possuiBinary::Ord a => a -> Arvore a-> Bool
possuiBinary x Folha = False
possuiBinary x (Galho v _ dir) = x==v || possuiBinary x dir

--Função Máxima
maximo::Num a => Arvore a-> a
maximo Folha = 0
maximo (Galho v esq Folha) = v
maximo (Galho a esq dir) = maximo dir

--Função Inserção
insere:: Ord a => a -> Arvore a-> Arvore a
insere x Folha = Galho x Folha Folha
insere x (Galho a esq dir)
   | x == a = Galho x esq dir
   | x < a  = Galho a (insere x esq) dir
   | x > a  = Galho a esq (insere x dir)

main =  print (insere 15 a3)