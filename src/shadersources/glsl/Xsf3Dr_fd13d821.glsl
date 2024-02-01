// The MIT License
// Copyright © 2013 Inigo Quilez
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


// HW linear interpolation vs manual interpolation. HW interpolation
// happens with https://www.shadertoy.com/8 bit precision only and hence produces staircase-like
// artifacts.
//
// Top half is hardware interpolation, bottom half is software interpolation.
// 
// Yellow-blue gradient is just the interpolation of two colors. Seemingly
// both look the same. However the hardware version (top) has discontinutities
// that the software version (bottom) hasn't. These become apparent when 
// passing the color through a high frequency sin wave for example (rainbow
// gradients) or when taking derivatives of the color (top most and bottom most
// rows) - the hardware interpolation at the top produces a discrete series of
// color jumps while the software interpolation produces a constant color
// derivative as expected.
//
// You can undefine the USE8BIT in line 27 and confirm that indeed HW is 
// using 8 bit point arighmetic by checking line 46.
//
// More information: https://iquilezles.org/articles/hwinterpolation/


//#define USE8BIT

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = fragCoord / iResolution.xy;
	
	// texture resolution
	float texRes = 64.0;
	
	// pixel under examination
    ivec2 pixOff = ivec2(46,40);
	
    // linear interpolation done by the hardware	
	vec3 c = textureLod( iChannel0, (vec2(pixOff)+vec2(0.5+p.x,0.5))/texRes, 0.0 ).xyz;

	// linear interpolation made by hand
	vec3 d = mix( texelFetch( iChannel0, pixOff+ivec2(0,0), 0 ).xyz, 
				  texelFetch( iChannel0, pixOff+ivec2(1,0), 0 ).xyz, 
#ifdef USE8BIT
                  round(p.x*256.0)/256.0	 );
#else
				  p.x );
#endif

	// compare both. upper half: HW, lower half: manual
	vec3 r = (p.y<0.5) ? d : c;
    
    float h = abs(p.y-0.5);

    // show derivatives
	if( h>0.3 ) r = 2.0*abs(dFdx(r))*iResolution.x;

    // pass it through a high freq sin wave to highlight discontinuities
    else if( h>0.15 ) r = 0.5+0.5*sin(r*314.0);


    // separation bars
	r *= smoothstep( 0.004, 0.005, abs(p.y-0.5) );
    r *= smoothstep( 0.001, 0.002, abs( abs(p.y-0.5)-0.15) );
    r *= smoothstep( 0.001, 0.002, abs( abs(p.y-0.5)-0.30) );
	
	fragColor = vec4(r,1.0);
}