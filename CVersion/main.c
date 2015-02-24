#include"main.h"
#include<math.h>
int main(void)
{
	float T, R, A, V;
	T = 15.0;
	R = 1.125;
	A = 0.1547*0.1547*3.14;
	V = v1h( T, R, A );
	printf( "The induced velocity is %f m/s \n", V );
}

float v1h( float T, float R, float A )
{
	float removal;
        removal = sqrt( T / ( 2 * R * A ) );	
	return removal;
};
