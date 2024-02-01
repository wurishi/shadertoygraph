// The MIT License
// Copyright © 2013 Inigo Quilez
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	
	vec3  col = texture( iChannel0, vec2(uv.x,1.0-uv.y) ).xyz;
	float lum = dot(col,vec3(0.333));
	vec3 ocol = col;
	
	if( uv.x>0.5 )
	{
		// right side: changes in luminance
        float f = fwidth( lum );
        col *= 1.5*vec3( clamp(1.0-8.0*f,0.0,1.0) );
	}
    else
	{
		// bottom left: emboss
        vec3  nor = normalize( vec3( dFdx(lum), 64.0/iResolution.x, dFdy(lum) ) );
		if( uv.y<0.5 )
		{
			float lig = 0.5 + dot(nor,vec3(0.7,0.2,-0.7));
            col = vec3(lig);
		}
		// top left: bump
        else
		{
            float lig = clamp( 0.5 + 1.5*dot(nor,vec3(0.7,0.2,-0.7)), 0.0, 1.0 );
            col *= vec3(lig);
		}
	}

    col *= smoothstep( 0.003, 0.004, abs(uv.x-0.5) );
	col *= 1.0 - (1.0-smoothstep( 0.007, 0.008, abs(uv.y-0.5) ))*(1.0-smoothstep(0.49,0.5,uv.x));
    col = mix( col, ocol, pow( 0.5 + 0.5*sin(iTime), 4.0 ) );
	
	fragColor = vec4( col, 1.0 );
}