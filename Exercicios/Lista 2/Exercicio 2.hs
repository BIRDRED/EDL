data Arvore = Folha | Galho Int Arvore Arvore deriving Show

a1 = Galho 10 (Galho 10 Folha Folha) (Galho 20 Folha Folha)
a2 = Galho 20 (Galho 10 (Galho 10 Folha Folha) Folha) Folha
a3 = Galho 10 Folha (Galho 10 (Galho 10 Folha Folha) (Galho 10 Folha Folha))

soma::Arvore -> Int
soma Folha = 0
soma (Galho n arv1 arv2) = n + soma arv1 + soma arv2

dobra::Arvore -> Arvore
dobra  Folha = Folha
dobra (Galho n Folha Folha) = Galho (n*2) Folha Folha
dobra (Galho _ arv1 arv2) = dobra arv2 

--Sem ter Arvore Binária
possui::Int -> Arvore -> Bool
possui x Folha = False
possui x (Galho v esq dir) = x==v || possui x esq || possui x dir

--Na Arvore Binária
possuiBinary::Int -> Arvore -> Bool
possuiBinary x Folha = False
possuiBinary x (Galho v _ dir) = x==v || possui x dir

--Função Máxima
maximo:: Arvore -> Int
maximo Folha = 0
maximo (Galho v esq Folha) = v
maximo (Galho a esq dir) = maximo dir

--Função Inserção
insere:: Int -> Arvore -> Arvore
insere x Folha = Galho x Folha Folha
insere x (Galho a esq dir)
   | x == a = Galho x esq dir
   | x < a  = Galho a (insere x esq) dir
   | x > a  = Galho a esq (insere x dir)

main =  print (insere 15 a2)