#include <stdint.h>
#include <stdio.h>
#include <string.h>

extern int64_t Cc1_(int8_t a, int16_t b, int32_t c, int64_t d, int8_t e, int16_t f, int32_t g, int64_t h);



int main() 
{
    int8_t a = 10, e = -20;
    int16_t b = -200, f = 400;
    int32_t c = 300, g = -600;
    int64_t d = 4000, h = -8000;
 
    int64_t x = Cc1_(a, b, c, d, e, f, g, h);
 
    printf("\nResults for CallingConvention1\n");
    printf("  a, b, c, d:  %8d %8d %8d %8lld\n", a, b, c, d);
    printf("  e, f, g, h:  %8d %8d %8d %8lld\n", e, f, g, h);
    printf("  x:           %8lld\n", x);
    return 0;
}












