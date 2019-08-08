#include <stdint.h>
#include <stdio.h>
#include <string.h>

int64_t IntegerAdd_(int64_t a, int64_t b, int64_t c, int64_t d, int64_t e, int64_t f); 
int64_t IntegerMul_(int8_t a, int16_t b, int32_t c, int64_t d, int8_t e, int16_t f, int32_t g, int64_t h); 
void IntegerDiv_(int64_t a, int64_t b, int64_t quo_rem_ab[2], int64_t c, int64_t d, int64_t quo_rem_cd[2]);


void IntegerAdd(void) 
{
    int64_t a = 100;
    int64_t b = 200;
    int64_t c = -300;
    int64_t d = 400;
    int64_t e = -500;
    int64_t f = 600;

    // Calculate a + b + c + d + e + f    
	int64_t sum = IntegerAdd_(a, b, c, d, e, f);
 
    printf("\nResults for IntegerAdd\n");    
	printf("a: %5lld b: %5lld c: %5lld\n", a, b, c);    
	printf("d: %5lld e: %5lld f: %5lld\n", d, e, f);    
	printf("sum: %lld\n", sum); 
}

void IntegerMul(void) 
{
    int8_t a = 2;
    int16_t b = -3;
    int32_t c = 8;
    int64_t d = 4;
    int8_t e = 3;
    int16_t f = -7;
    int32_t g = -5;
    int64_t h = 10;
 
    // Calculate a * b * c * d * e * f * g * h    
	int64_t result = IntegerMul_(a, b, c, d, e, f, g, h);
    printf("\nResults for IntegerMul\n");
    printf("a: %5d b: %5d c: %5d d: %5lld\n", a, b, c, d);
    printf("e: %5d f: %5d g: %5d h: %5lld\n", e, f, g, h);
    printf("result: %5lld\n", result); 
}

void IntegerDiv(void) 
{
    int64_t a = 102;
    int64_t b = 7;
    int64_t quo_rem_ab[2];
    int64_t c = 61;
    int64_t d = 9;
    int64_t quo_rem_cd[2];
 
    // Calculate a / b  and c / d    
	IntegerDiv_(a, b, quo_rem_ab, c, d, quo_rem_cd);
 
    printf("\nResults for IntegerDiv\n");
    printf("a:   %5lld b:   %5lld ", a, b);
    printf("quo: %5lld rem: %5lld\n", quo_rem_ab[0], quo_rem_ab[1]);
    printf("c:   %5lld d:   %5lld ", c, d);
    printf("quo: %5lld rem: %5lld\n", quo_rem_cd[0], quo_rem_cd[1]);
}

int main() 
{
    IntegerAdd();
    IntegerMul();
    IntegerDiv();
	
    return 0;
}












