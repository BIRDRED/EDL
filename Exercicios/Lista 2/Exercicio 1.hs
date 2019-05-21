data Arvore = Folha | Galho Arvore Arvore deriving Show

a1 = Galho (Galho Folha Folha) (Galho Folha Folha)
a2 = Galho (Galho (Galho Folha Folha) Folha) Folha
a3 = Galho Folha (Galho (Galho Folha Folha) (Galho Folha Folha))


--Quantidade de Folhas
folhas::Arvore -> Int
folhas Folha = 1
folhas (Galho esq dir) = folhas esq + folhas dir


--Quantidade de Altura 
altura::Arvore -> Int
altura Folha = 0
altura (Galho esq dir) = 1 + altura esq + altura dir


--Inversão de Arvores
espelho::Arvore -> Arvore
espelho Folha = Folha
espelho (Galho esq dir) = (Galho (espelho dir) (espelho esq))



main =  print (espelho a1)