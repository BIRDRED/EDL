# **CLOJURE**




![](https://pbs.twimg.com/profile_images/1491801917/clojure-conj-logo-square.png)


## **Introdução**

Clojure é uma linguagem baseada em programação funcional (LISP) que possui integração com boa parte das linguagens atuais , além de ser bastante utilizado no mercado profissional.


## **Origens e Influencias**

A linguagem Clojure foi criada por Rich Hickey criada em 2007.Foi criado por que era necessária uma linguagem parecida com Lisp, que funcionasse como Programação Funcional, com uma plataforma estabelecida e Concorrência.


## **Caracteristicas e Vantagens**

Clojure é uma linguagem compilada. Ela compila para bytecode JVM da mesma maneira que o Java faz.É baseada em recursão e consegue escrever código Java em  Clojure. 
Programas escrito em Clojure são muitos pequenos melhorando a manutenção de códigos.

![](http://conteudo.imasters.com.br/25335/49477.png)

Ex : De um sistema de Tradução e Logs feito em Java e em Clojure.

## **Sobre a Linguagem**


Como é inspirado em LISP, a interpretação é inicializada com parenteses:

**- Olá Mundo:** 

    (println "Olá Mundo!")
    

**- Definindo uma função**


    (defn raiz-quadrada [x] (* x x))


**- Chamando uma função**

```
(raiz-quadrada 4)
```

**- Comparação**

Já possui alguns comparadores nativos como sort, compare e subseq para verificação de listas

 - compare

Semelhante ao compareTo do Java

```
(compare 10 20)
;-1
```

- sort


```
(sort [4 2 3 1])
;(1 2 3 4)
```

- subseq

```
(subseq (sorted-set 1 2 3 4) > 2)
;(3 4)
```



#**Comparação com PHP**


### - Macro

##### - Clojure

 Um recurso muito poderoso da linguagem que vem com Clojure é macros, uma maneira de fazer a metaprogramação.
Metaprogramação é utilizado para gerar código embutido e facilitar a rotina do desenvolvedor usando a própria linguagem.
Isso é bem diferente de outras linguagens conhecidas por bons recursos de metaprogramação (por exemplo, Ruby) no Clojure, a metaprogramação não significa geração de strings. Em vez disso, significa utilizar construtores de expressões ou listas.
As macros são avaliadas em tempo de compilação e produzem estruturas de dados modificadas que são compiladas no bytecode da JVM. Esse bytecode é executado no tempo de execução.
A macro pode retornar um código ao inves de somente um valor e  macro é definida no momento de compilação podendo gerar um erro especifico no momento em que a macro é avaliada.

- Exemplo de Macro
```
(defn Example []
   (defmacro Simple [arg]
      (list 2 arg))
   (println (macroexpand '(Simple 2))))
```

Chamada da Função: ``` (Example)```

Retorno: ```(2 2)```


#### -Qual é exatamente a diferença entre uma macro e uma função?

------------


Uma explicação comum da diferença entre funções e macros é:
  - uma função transforma valores em outros valores.
  - uma macro transforma o código em outro código.

Para ser mais especifico , duas perguntas precisam ser respondidas:
  1) Quando os argumentos (a entrada) são verificados?
  2) O valor de retorno é verificados?


Nas funções:
  1) Argumentos de função (a entrada) são avaliados antes da execução do código de função
  2) Valor de retorno da função (a saída) não é avaliado

Nas macros:
  1) Argumentos de macros (a entrada) não são avaliados antes que o código de macro os utilize
  2) Valor de retorno das macros (a saída) é avaliado


Isso significa que os argumentos podem ser avaliados várias vezes ou não.
Como exemplo é uma macro. Se o primeiro argumento for falso, o segundo argumento nunca será avaliado. 
Se fosse uma função, isso não seria possível, porque os argumentos sempre seriam avaliados antes da execução da função.


Para o exemplo:
```
(defmacro twice [e] `(do ~e ~e))
(twice (println "Testando"))
```
Saída: "Testando Testando"
Ele verifica o argumento da String e como não tem dois argumentos , a macro copia o argumento e gera a lista (do (println "foo") (println "foo")).
Portanto este novo código é executado.


Exemplo Função

```
(defn twice [e] `(do ~e ~e))
(twice (println "Testando"))
```
Saída: "Testando" => #'user/twice (do nil nil)
O argumento da String é avaliado imediatamente. 
Como só tem um argumento a função retorna nil para uma das função então retorna nil para a função.
Não é avaliado como código então a função é tratada como lista.


- Um exemplo de macro é quando utilizamos unless (que é uma forma contrária a utilizar o if) e para isso como não está disponivel diretamente na linguagem a única forma de utilizar é através de macros

```
(defmacro unless
[condition & forms]
`(if (not ~condition)
~@forms))
```
Chamada da Função
```
(unless (= 1 2)
"um igual a dois"
"um nao e igual a dois. Como?")
```
Retorno  ```"um igual a dois"```

Conseguimos verificar como é utilizado a origem do Macro:
```(macroexpand-1 '(unless (= 1 2) true false))```

Retorno : ```;= (if (clojure.core/not (= 1 2)) true false)```

-  Muitos elementos nativos do Clojure são somente Macros feitos através de Macro.
Exemplo: OR
Conseguimos avaliar através do comando : ``` (source or)```
```
(defmacro or
  "Evaluates exprs one at a time, from left to right. If a form
  returns a logical true value, or returns that value and doesn't
  evaluate any of the other expressions, otherwise it returns the
  value of the last expression. (or) returns nil."
  {:added "1.0"}
  ([] nil)
  ([x] x)
  ([x & next]
      `(let [or# ~x]
         (if or# or# (or ~@next)))))
```

##### - PHP


O mais próximo que PHP consegue utilizar com macro é a utilização do define igual ao C

```
define ( string $name , mixed $value [, bool $case_insensitive = FALSE ] ) : bool
```


## - Protocol

##### - Clojure

O protocolo gerá automaticamente uma interface de acordo com a função.
A interface terá métodos correspondentes às funções do protocolo e o protocolo funcionará automaticamente com instâncias da interface.

```
(defprotocol P
  (foo [x])
  (bar-me [x] [x y]))

(deftype Foo [a b c]
  P
  (foo [x] a)
  (bar-me [x] b)
  (bar-me [x y] (+ c y)))

(bar-me (Foo. 1 2 3) 42)
= > 45
```

#####- PHP

No PHP não será possivel implementar a função da interface


```
<?php

// Declara a interface 'iTemplate'
interface iTemplate
{
    public function setVariable($name, $var);
    public function getHtml($template);
}

// Isso NÃO funcionará
// Fatal error: Class BadTemplate contains 1 abstract methods
// and must therefore be declared abstract (iTemplate::getHtml)
class BadTemplate implements iTemplate
{
    private $vars = array();

    public function setVariable($name, $var)
    {
        $this->vars[$name] = $var;
    }
}
?>

```


## **Pontos Interessantes**

- Facilidade na utilização de listas
- Facilidade na utilização de Threads.
- É possível incluir Clojure em um projeto JAVA
- Possui implementações para rodar em Ruby , Python e Perl
- É possível utilizar frameworks Java como Maven
- Possui uma implementação chamada Clojure Script que compila para Javascript 


## **Conclusão**

Clojure é uma linguagem que traz facilidades na utilização da programação funcional e pode ser utilizado em vasta escala trazendo toda a facilidade 






## **Bibliografia e Links**


- Clojure : [clojure.org]()
- Wikipedia Clojure: [https://pt.wikipedia.org/wiki/Clojure#Hist.C3.B3ria_e_processo_de_desenvolvimento]()
- Clojure Docs : [https://clojuredocs.org]()
- Artigo 'Devemos usar Clojure?' : [http://imasters.com.br/artigo/25335/linguagens/devemos-usar-clojure?trace=1519021197&source=single]()
- GrokPodCast 141 Clojure : [http://www.grokpodcast.com/2015/07/16/episodio-141-clojure/]()
- GrokPodCast 142 Clojure : [http://www.grokpodcast.com/2015/07/23/episodio-142-clojure/]()
- GrokPodCast 143 Clojure : [http://www.grokpodcast.com/2015/07/30/episodio-143-clojure/]()
- HipsterChat : [http://hipsters.tech/tecnologias-no-nubank-hipsters-01/]()
- Implementação : [https://www.php.net/manual/pt_BR/language.oop5.interfaces.php]()
- Exemplos de Macro (Macro x Função) : [http://blog.klipse.tech/clojure/2016/05/01/macro-tutorial-1.html]()
- Mais Exemplos de Macro : [http://clojure-doc.org/articles/language/macros.html]()
- Outros Exemplos de Macro :[https://aphyr.com/posts/305-clojure-from-the-ground-up-macros]()
- Exemplo das Funções :[https://stackoverflow.com/questions/3667403/what-is-the-difference-between-defn-and-defmacro]()


