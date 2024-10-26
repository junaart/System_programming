#include<stdio.h>

int main(){
  printf("char:%ld bytes\n",sizeof(char));
  printf("int: %ld bytes\n",sizeof(int));
  printf("long int: %ld bytes\n",sizeof(long int));
  printf("long long int: %ld bytes\n",sizeof(long long int));
  printf("unsigned int: %ld bytes\n",sizeof(unsigned int));
  printf("unsigned long: %ld bytes\n",sizeof(unsigned long));
  printf("unsigned long long: %ld bytes\n",sizeof(unsigned long long));
  return 0;
}
   
