#include <stdio.h>

enum Exp{Num,Add,Sub}; 
union add 
        { 
        int num1; 
        int num2; 
        }; 
union sub
        { 
        int num1; 
        int num2; 
        }; 
int avalia(struct Exp) {
    if(Num){return num; }
   return 0; 
}

int main(void)
{
  /*Criando a struct */
  struct Exp
  {
    int num;
    union add;
    union sub;
  };

 
  av = avalia(Num 1);

  printf("%d",&av);

}

