/*
	Rotating Munching Squares Shader
    Copyright (C) 2013  Daniel Hedeblom <maxifoo@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

vec3 color;
float c,p;
vec2 a, b, g;

vec2 rotate(vec2 pin, float angle)
{
	vec2 p;
	float s = sin(angle);
	float c = cos(angle);
	p = -pin;
	vec2 new =  vec2(p.x * c - p.y * s, p.x * s + p.y * c);
	p = new;
  return p;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float scale = iResolution.x / iResolution.y;
	uv = uv-0.5;
	uv.y/=scale;
	
	/*
	//morph
	g.x = cos(uv.x * 2.0 * 3.14);
	g.y = sin(uv.y * 2.0 * 3.14);
	g*=sqrt(uv.x*uv.x + uv.y*uv.y);
	g+=2.0;
	*/	
	
	//rotate
	g = rotate(uv, iTime*0.5);
	
	//zoom in/out
	a = g*(sin(iTime*0.5)/2.0+1.0);
	
	b    = a*256.0;
	
	b.x += (sin(iTime*0.35)+2.0)*200.0;
	b.y += (cos(iTime*0.35)+2.0)*200.0;
	c = 0.0;
	
	
	for(float i=16.0;i>=1.0;i-=1.0)
	{
		p = pow(2.0,i);

		if((p < b.x) ^^
		   (p < b.y))
		{
			c += p;
		}
		
		if(p < b.x)
		{
			b.x -= p;
		}
		
		if(p < b.y)
		{
			b.y -= p;
		}
		
	}
	
	c=mod(c/128.0,1.0);
	
	color = vec3(sin(c+uv.x*cos(uv.y*1.2)), tan(c+uv.y-0.3)*1.1, cos(c-uv.y+0.9));
	
	fragColor = vec4(color,1.0);
}