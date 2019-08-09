#include <stdint.h>
#include <stdio.h>
#include <string.h>

extern int NumFibVals_, FibValsSum_; 
extern int MemoryAddressing_(int i, int* v1, int* v2, int* v3, int* v4);



int main() 
{
    FibValsSum_ = 0;
	int i;
 
    for (i= -1; i < NumFibVals_ + 1; i++)    
	{
        int v1 = 0, v2 = 0, v3 = 0, v4 = 0;
        int rc = MemoryAddressing_(i, &v1, &v2, &v3, &v4);
		
        printf("i: %2d  rc: %2d | ", i, rc);
        printf("v1: %5d v2: %5d v3: %5d v4: %5d\n", v1, v2, v3, v4);
	}
 
    printf("FibValsSum_: %d\n", FibValsSum_);
    return 0;
}












