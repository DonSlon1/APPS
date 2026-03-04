#include <stdio.h>
long area(int *sides, int shape);
void div(long * arr_in, long * arr_mod, int div);
int prime_div(int * num_arr, int div);
int main(void)
{
    printf("Helloo, World!\n");
    printf("The area of a triangle with sides of length 5 and 10 is %ld\n", area((int[]){5, 10}, 1));
    printf("The area of a rectangle with sides of length 5 and 10 is %ld\n", area((int[]){5, 10}, 2));
    long arr_in[] = {11, 22, 33, 44, 55};

    long arr_mod[5];

    div(arr_in, arr_mod, 10);
    printf("The result of dividing the array by 10 is: ");
    for (int i = 0; i < 5; i++) {
        printf("%ld ", arr_mod[i]);
    }
    printf("\n");
    printf("The number of prime devided by 2 is: %d\n", prime_div((int[]){2, 3, 4, 5, 6}, 2));
    return 0;
}
