// The MIT License
// https://www.youtube.com/c/InigoQuilez
// https://iquilezles.org/
// Copyright © 2013 Inigo Quilez
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


// An example on how to compute a distance estimation for an ellipse (which provides
// constant thickness to its boundary). This is achieved by dividing the implicit 
// description by the modulus of its gradient. The same process can be applied to any
// shape defined by an implicity formula (ellipses, metaballs, fractals, mandelbulbs).
//
// top    left : f(x,y)
// top    right: f(x,y) divided by analytical gradient
// bottom left : f(x,y) divided by numerical GPU gradient
// bottom right: f(x,y) divided by numerical gradient
//
// More info here:
//
// https://iquilezles.org/articles/distance

const float a = 1.0;
const float b = 3.0;

float r, e;

// f(x,y) (top left)
float ellipse1(vec2 p)
{
    float f = length( p*vec2(a,b) );
    return abs(f-r);
}

// f(x,y) divided by analytical gradient (top right)
float ellipse2(vec2 p)
{
    float f = length( p*vec2(a,b) );
    float g = length( p*vec2(a*a,b*b) );
    return abs(f-r)*f/g;
}

// f(x,y) divided by numerical GPU gradient (bottom left)
float ellipse3(vec2 p)
{
    float f = ellipse1(p);
    float g = length( vec2(dFdx(f),dFdy(f))/e );
    //float g = fwidth(f)/e;
	return f/g;
}

// f(x,y) divided by numerical gradient (bottom right)
float ellipse4(vec2 p)
{
    float f = ellipse1(p);
    float g = length( vec2(ellipse1(p+vec2(e,0.0))-ellipse1(p-vec2(e,0.0)),
                           ellipse1(p+vec2(0.0,e))-ellipse1(p-vec2(0.0,e))) )/(2.0*e);
    return f/g;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    r = 0.9 + 0.1*sin(3.1415927*iTime);
    e = 2.0/iResolution.y;
    
	vec2 uv = (2.0*fragCoord-iResolution.xy) / iResolution.y;
    
	float f1 = ellipse1(uv);
	float f2 = ellipse2(uv);
	float f3 = ellipse3(uv);
	float f4 = ellipse4(uv);
	
	vec3 col = vec3(0.3);

    // ellipse     
    float f = mix( mix(f1,f2,step(0.0,uv.x)), 
                   mix(f3,f4,step(0.0,uv.x)), 
                   step(uv.y,0.0) );
    
	col = mix( col, vec3(1.0,0.6,0.2), 1.0-smoothstep( 0.1, 0.11, f ) );
    
    // lines    
	col *= smoothstep( e, 2.0*e, abs(uv.x) );
	col *= smoothstep( e, 2.0*e, abs(uv.y) );
	
	fragColor = vec4( col, 1.0 );
}