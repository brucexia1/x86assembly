#include <stdint.h>
#include <stdio.h>
#include <string.h>

// The following structure must match the structure that's declared in IntegerOperands_.asm
typedef struct
{
    uint8_t a8;
    uint16_t a16;
    uint32_t a32;
    uint64_t a64;
    uint8_t b8;
    uint16_t b16;
    uint32_t b32;
    uint64_t b64;
}ClVal;

extern void CalcLogical_(ClVal* cl_val, uint8_t c8[3], uint16_t c16[3], uint32_t c32[3], uint64_t c64[3]);


int main() 
{
    ClVal x;
    uint8_t c8[3];
    uint16_t c16[3];
    uint32_t c32[3];
    uint64_t c64[3];
 
    x.a8 = 0x81;
	x.b8 = 0x88;
    x.a16 = 0xF0F0;
	x.b16 = 0x0FF0;
    x.a32 = 0x87654321;
	x.b32 = 0xF000F000;
    x.a64 = 0x0000FFFF00000000;
    x.b64 = 0x0000FFFF00008888;
 
    CalcLogical_(&x, c8, c16, c32, c64);
 
    printf("\nResults for CalcLogical()\n");
 
    printf("\n8-bit operations\n"); 
	printf("0x%02X & 0x%02X = 0x%02X\n", x.a8, x.b8, c8[0]);
    printf("0x%02X | 0x%02X = 0x%02X\n", x.a8, x.b8, c8[1]);
    printf("0x%02X ^ 0x%02X = 0x%02X\n", x.a8, x.b8, c8[2]);
 
    printf("\n16-bit operations\n");
    printf("0x%04X & 0x%04X = 0x%04X\n", x.a16, x.b16, c16[0]);
    printf("0x%04X | 0x%04X = 0x%04X\n", x.a16, x.b16, c16[1]);
    printf("0x%04X ^ 0x%04X = 0x%04X\n", x.a16, x.b16, c16[2]);
 
    printf("\n32-bit operations\n");
    printf("0x%08X & 0x%08X = 0x%08X\n", x.a32, x.b32, c32[0]);
    printf("0x%08X | 0x%08X = 0x%08X\n", x.a32, x.b32, c32[1]);
    printf("0x%08X ^ 0x%08X = 0x%08X\n", x.a32, x.b32, c32[2]);
	
	printf("\n64-bit operations\n");
    printf("0x%016llX & 0x%016llX = 0x%016llX\n", x.a64, x.b64, c64[0]);
    printf("0x%016llX | 0x%016llX = 0x%016llX\n", x.a64, x.b64, c64[1]);
    printf("0x%016llX ^ 0x%016llX = 0x%016llX\n", x.a64, x.b64, c64[2]);
	
    return 0;
}












