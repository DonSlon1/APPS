#include <stdio.h>
#include <stdlib.h>
#include <time.h>


// global public variables
int apps_string_i = 0x53415050;
char rgba_string[] = "RGBA";

typedef struct {
    float hodnota; // Offset 4
    char flag;     // Offset 8
    // Pozor: C kompilátor sem přidá 3 byty "padding" (vycpávku), aby byla struktura zarovnaná!
} Data;

// external variables
extern int rgba_int;
extern char apps_chars[];

// external function
void convert_rgba();
void access_string();
int temp_func(long value,int* temp,int* moist);
int sum(int a, int b,int c);
void display(unsigned int* array, int len);
int string_convert(char* data);
int edit_number(int N);
float calculate_circle(float radius,int multiplicator);
int sum_diagonal(int **matrix, int size);
void add_float_arrays(float *a, float *b, float *result, int count);
unsigned long factorial(unsigned long n);
unsigned long ffactorial(unsigned long n) {
    if (n == 0 || n == 1) {
        return 1;
    }
    return ffactorial(n-1) * n;
}
int get_random() {
    int rand_n = rand() % 100;
    printf("random number: %i\n",rand_n);
    return rand_n;
}
void print_val(int val) {
    printf("val %d\n",val);
}
void rand_print_asm();
int edit_data(Data *d,int len);
int g_int_array[15] = { -3, -8, 80, 2710, 32, 439, 9099, 10, 77, -273, 2, 22222, 0, -23, 23};
extern int g_neg_val_array[15];
extern int g_int_outup;
char g_char_array[32] = "testovaci pole pro cv2";
int conver_string();
int edit_int();

int main()
{
    srand(time(NULL));
    access_string();
    printf( "Modifies  string: '%s'\n", apps_chars );
    convert_rgba();
    printf( "RGBA int: 0x%X\n", rgba_int );
    long value = 0x000111110022;
    int temp=0;
    int moist=0;
    printf("len: %lu\n", sizeof(value));
    int sum_t = temp_func(value,&temp,&moist);
    printf("Temp is: %d\n", temp);
    printf("Moist is: %d\n", moist);
    printf("sum is: %d\n", sum_t);
    int x = sum(100,200,50);
    printf("sum function is: %d\n",x);
    unsigned int pole[] = {0x00000000,0xFF0000FF,0x04FFAACC};
    display(pole,3);
    for (int i = 0;i < 3; i++) {
        printf("ARGB: 0x%x\n",pole[i]);
    }
    char data[] = "Ahoj a ahoj";
    int res = string_convert(data);
    printf("string convert: %i\n string: %s\n",res,data);
    rand_print_asm();
    printf("Edited number: %d\n", edit_number(10));

    printf("circle number: %f\n", calculate_circle(5.0f,2));
    Data d_array[3] = {
        {1, 3.2f, 'A'},
        {2, 2.71f, 'X'},
        {3, 1.62f, 'C'}
    };
    printf("Total modified :%d\n",edit_data(d_array, 3));
    for (int i = 0; i < 3; i++) {
        printf("Data %d: id=%d, hodnota=%.2f, flag=%c\n", i, d_array[i].id, d_array[i].hodnota, d_array[i].flag);
    }
    int **matrix = (int**)malloc(3 * sizeof(int*));
    for (int i = 0; i < 3; i++) {
        matrix[i] = (int*)malloc(3 * sizeof(int));
        for (int j = 0; j < 3; j++) {
            matrix[i][j] = i + j +1; // Naplnění matice nějakými hodnotami
        }
    }
    // print matrix
    printf("Matrix:\n");
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
    printf("Total sum of diagonal is %d\n", sum_diagonal(matrix, 3));
    printf("Factorial %lu\n",ffactorial(4));

    float a_array[] = {1.0f, 2.0f, 3.0f, 4.0f,5.0f, 6.0f, 7.0f, 8.0f};
    float b_array[] = {9.0f, 10.0f, 11.0f, 12.0f,13.0f, 14.0f, 15.0f, 16.0f};
    float result[8];
    add_float_arrays(a_array,b_array,result,8);
    printf("Result of adding float arrays:\n");
    for (int i = 0; i < 8; i++) {
        printf("%f ", result[i]);
    }
    printf("\n");
    edit_int();
    // print g_neg_val_array and g_int_outup
    printf("g_neg_val_array: ");
    for (int i = 0; i < 15; i++) {
        printf("%d ", g_neg_val_array[i]);
    }
    printf("\n");
    printf("g_int_outup: %d\n", g_int_outup);
    printf("\n");
    printf("total number of samohlasky : %d\n", conver_string());
    printf("converted string is : %s\n", g_char_array);
    return 0;
}
