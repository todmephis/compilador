#include <unistd.h>
#include <stdio.h>
#include <pthread.h>
#include <string.h>

struct e_hilo{
  int num;
};

void* f_hilo(void* params){
  struct e_hilo *e_params=(struct e_hilo *)params;
  short i=0;
  for(i=1; i<=10; i++){
    printf("[Hilo %d] %d x %d = %d\n", e_params->num, i, e_params->num, (e_params->num)*i);
  }
  //pthread_exit(NULL); Se elimina debido a:
  /* If the
     start_routine returns, the effect is as if there was an implicit call to pthread_exit() using
     the return value ofstart_routine as the exit status.*/
  return (void *)e_params;
}

int main(){
  struct e_hilo *ptr_aux = NULL;
  pthread_t hilo[10];
  int i = 0xFF;
  int j = 0777;
  
  struct e_hilo arr[10];
  for(i=1; i<=10; i++){
    arr[i].num = i;
    pthread_create(&hilo[i], NULL, f_hilo, (void *) &arr[i]);
  }

  for(i=0;i<10;i++){
    pthread_join(hilo[i], (void *)&ptr_aux);
    //printf("En main: [%d], Struct num [%d] arr[%s]\n", getppid(), ptr_aux->num, ptr_aux->arr);
  }
  return 0;
}
