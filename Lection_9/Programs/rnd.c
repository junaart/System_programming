#include<stdio.h>
#include<time.h>
#include <unistd.h>
void setrnd(){
  srand(time(NULL));
}

unsigned long get_random(){
  return rand();
}
