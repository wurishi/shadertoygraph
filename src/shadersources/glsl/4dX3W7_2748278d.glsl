/*
	Mandelbrot Shader
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

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	float scale = iResolution.y / iResolution.x;
	uv=((uv-0.5)*3.5)*(exp(-(cos(iTime/5.0+(3.14))+1.0)*6.0));
	uv.y*=scale;
	uv.y+=0.651117;
	uv.x-=0.030149;
	/*
	uv.y-=-0.5+iMouse.y/iResolution.y;
	uv.x-=iMouse.x/iResolution.x;
	*/
	

	vec2 z = vec2(0.0, 0.0);
	vec2 z2 = vec2(0.0, 0.0);
	vec3 c = vec3(0.0, 0.0, 0.0);
	float v;
	for(int i=0;(i<170);i++)
	{

		if(((z.x*z.x+z.y*z.y) >= 4.0)) break;
		z = vec2(z.x*z.x - z.y*z.y, 2.0*z.y*z.x) + uv;
		
		/*
		z2 = vec2(z2.y, z2.x*z2.x+z.y*z.y) + sin(uv);

			if(dot(z2, z)>=1.0)
			{
				c+=vec3(float(i)*uv.x/iResolution.x,tan(float(uv.x)),0.01)/1500.0;
			}*/
		
		if((z.x*z.x+z.y*z.y) >= 2.0)
		{
			//c.b=float(i)/150.0;
			//c.r=sin((float(i)/150.0) *20.0 + iTime);
			
			v = float(i) - log(z.x*z.x+z.y*z.y);
			c.b=cos((v/1000.0) * 100.0 + iTime + 3.14);
			
			v = float(i) - log(z.x*z.y);
			c.r=sin(sqrt((v/1.0))/2.5);
			
			v =log(z.x*z.y);
			c.g=sin(((v/1.0))/2.5);
			
		}

	}
	
	
	fragColor = vec4(c,1.0);
}