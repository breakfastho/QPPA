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

/* The subfunction for induced velocity in vertical climb */
float v1c( float viv, float V )
{
	float removal;
	removal = -( viv / 2 ) + sqrt( (viv/2)*(viv/2) + V*V );
	return removal;
}
