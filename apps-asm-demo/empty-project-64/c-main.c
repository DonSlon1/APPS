#include <stdio.h>
#include <stdlib.h>
#include <time.h>



long g_long_array[5] = { 255, 594, 11, 45678, 321};
char g_char_array[99] = "fsadfasdfasdfsdfsdauifu7fhhvdsfui IO cUIRINvOLuhfighafoadf";
char g_to_replace = 'f';
char g_new = 'X';
char g_encoded[] = "onaFxn";
int g_counter;
int g_output;
void work_int();
void replace_string();
void decode();
int main()
{
    work_int();
    printf("g_counter: %d\n", g_counter);
    printf("g_output: %d\n", g_output);
    replace_string();
    printf("edited string is: %s\n", g_char_array);
    decode();
    printf("decoded string is : %s\n", g_encoded);
    return 0;
}
