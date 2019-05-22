data Arvore a = Folha a | Galho (Arvore a) (Arvore a) deriving Show

a1 = Galho (Galho (Folha 10) (Folha 10)) (Galho (Folha 20) (Folha 30))
a2 = Galho (Galho (Galho (Folha 10) (Folha 10)) (Folha 10)) (Folha 20)
a3 = Galho (Folha 10) (Galho (Galho (Folha 10) (Folha 10)) (Galho (Folha 10) (Folha 10)))


soma::Arvore Int -> Int
soma (Folha v) = v
soma (Galho esq dir) = (soma esq) + (soma dir)

dobra::Arvore Int-> Arvore Int
dobra (Folha v) = (Folha (v*2))
dobra (Galho esq dir) = (Galho (dobra esq) (dobra dir))

--Sem ter Arvore Binária
possui::Int -> Arvore Int -> Bool
possui x (Folha v) = x==v || False 
possui x (Galho esq dir) = possui x esq || possui x dir || False

--Na Arvore Binária
possuiBinary::Int -> Arvore Int -> Bool
possuiBinary x (Folha v) = x==v || False
possuiBinary x (Galho _ dir) = possuiBinary x dir

--Função Máxima
maximo:: Arvore Int -> Int
maximo (Folha v) = v
maximo (Galho esq dir) = maximo dir

--Função Inserção
insere:: Int -> Arvore Int -> Arvore Int
insere x (Folha a)
   | x == a = (Galho (Folha x) (Folha a))
   | x < a  = (Folha a)
   | x > a  = (Galho (Folha x) (Folha a))
insere x (Galho esq dir) = (Galho (insere x esq) (insere x dir))


main =  print (insere 15 a1)