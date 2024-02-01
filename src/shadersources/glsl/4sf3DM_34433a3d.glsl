/*
The MIT License (MIT)

Copyright (c) 2013  Daniel Hedeblom <maxifoo@gmail.com>

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
THE SOFTWARE.
*/

float electron(vec2 u, float a, float b)
{
	#define Q 1.602e-19
	#define k 8.988e9
	return k*(Q/((pow(abs(u.x+a),2.0))+(pow(abs(u.y+b),2.0))));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float scale = iResolution.y / iResolution.x;
	uv=-(uv-0.5)*2.0;
	uv.y*=scale;
	
	float laddningar = electron(uv, 0.5*sin(iTime), 0.5*cos(iTime))
		             + electron(uv, 0.1*sin(-iTime), 0.1*cos(iTime));
	
	fragColor = vec4(sin(laddningar*2000000000.0),laddningar*50000000.0/3.0,laddningar*50000000.0,1.0);
}