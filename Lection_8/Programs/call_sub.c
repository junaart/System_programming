#include<stdio.h>

int mysub(int, int);

int main(){
  int a,b;
  scanf("%d", &a);
  scanf("%d", &b);
  printf("%d\n",mysub(a,b));
  return 0;
}
