// Animated nyan cat lookup stolen from https://www.shadertoy.com/view/4slGWH

vec4 getNyanCatColor( vec2 p )
{
	p = clamp(p,0.0,1.0);
	p.x = p.x*40.0/256.0;
	p.y = 0.5 + 1.2*(0.5-p.y);
	p = clamp(p,0.0,1.0);
	float fr = floor( mod( 20.0*iTime, 6.0 ) );
	p.x += fr*40.0/256.0;
	return texture( iChannel0, p );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = fragCoord.xy / iResolution.xy - 0.5;
	if(iResolution.x > iResolution.y)
		p.x /= iResolution.y / iResolution.x;
	else
		p.y /= iResolution.x / iResolution.y;
	float angle = sin(iTime)*3.1416*3.0;
	p = vec2(p.x * cos(angle) - p.y * sin(angle), p.y * cos(angle) + p.x * sin(angle));
	p /= 1.3;
	p *= sin(iTime) * 2.0;
	p += 0.5;
	if(sin(iTime) > 0.0)
		p.y = 1.0 - p.y;
	fragColor = getNyanCatColor(p);
}