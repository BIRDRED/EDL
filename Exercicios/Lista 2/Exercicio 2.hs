data Arvore = Folha | Galho Int Arvore Arvore deriving Show

a1 = Galho 10 (Galho 10 Folha Folha) (Galho 20 Folha Folha)
a2 = Galho 10 (Galho 10 (Galho 10 Folha Folha) Folha) Folha
a3 = Galho 10 Folha (Galho 10 (Galho 10 Folha Folha) (Galho 10 Folha Folha))

soma::Arvore -> Int
soma Folha = 0
soma (Galho n arv1 arv2) = n + soma arv1 + soma arv2

dobra::Arvore -> Arvore
dobra  Folha = Folha
dobra (Galho n Folha Folha) = Galho (n*2) Folha Folha
dobra (Galho _ arv1 arv2) = dobra arv2 


possui::Int -> Arvore -> Bool
possui x Folha = False
possui x (Galho v esq dir) = x==v || possui x esq || possui x dir


main =  print (possui 15 a1)