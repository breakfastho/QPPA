#include <math.h>

/* The subfunction for induced velocity */
float v1h( float T, float R, float A, int B)
{
	float removal;
    removal = sqrt( T / ( 2.0 * R * A * B) );	
	return removal;
};