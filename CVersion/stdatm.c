#include <stdio.h>
#include <stdlib.h>
#include <math.h>

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

float stdatm( float Height )
{

	/* Declare the type as float for all variables */
	float Gravity, Temperature, Pressure, Radious, L, M, R;
	float Gravity_ini, Temperature_ini, Pressure_ini;

	/* Set up the initial value of variables */
	Gravity_ini = 9.80665;
	Temperature_ini = 288.15;
	Pressure_ini = 101.325e3;
	Radious = 6378;
	L = 0.0065;
	M = 0.0289644;
	R =  8.31447;

	/* Start the main algorithm */
	Gravity = Gravity_ini * sqrt( Radious / ( Radious + ( Height / 1000.0 ) ) );

	// printf(" %f \n ", Gravity );

	return Gravity;
} 
