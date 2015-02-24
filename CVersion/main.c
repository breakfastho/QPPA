#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "v1h.h"

/*COPYRIGHT
	Copyright (c) 2014-2015 Wei-Chieh Chang

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.*/

/*AUTHOR
	Wei-Chieh Chang
	Send the bug report or comment to 602430307@s02.tku.edu.tw
	The lated version will puslish at
	https://github.com/addischang1991/QPPA/tree/master/CVersion
	Version : 1.0 at 24 Feb 2015 */ 


/* The main function is execute form here  */
int main(void)
{
	/* Declare the variable
		T : Thrust
		M : Mass
		g : Gravity
		R : Air density
		A : Rotor area
		B : Rotor number
		V : Induced velocity
		N : Power loss rate */
	int B;
	float T, M, g, R, A, V, N;

	M = 2.58;
	g = 9.81;
	N = 0.05;
	T = ( M * g ) / ( 1.0 - N );
	R = 1.125;
	A = 0.1547*0.1547*3.14;
	B = 4;

	/* Call the function to compute induced velocity */
	V = v1h( T, R, A, B );

	/* Print the result */
	printf( "The induced velocity is %f m/s \n", V );

	/* Indicates the sucessful termination */
	return 0;
}

