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
	float time = iTime;
	float alpha = 1.;
	
	vec2 pos = fragCoord.xy / vec2(iResolution.xy);
	pos -= .5;
	pos *= 1.3;
	pos += .5;
	
	vec2 dx = pos - .5;
	float r = dot(dx,dx);
	float phase = time * 5. + r * 15.;
	
	vec3 lerps;
	lerps.r = cos(phase) * .5 + .5;
	lerps.g = cos(phase - 2.0943951023932) * .5 + .5;
	lerps.b = cos(phase - 4.1887902047864) * .5 + .5;
	
	lerps.rgb *= alpha;
	lerps.r += 1. - alpha;
	
	vec2 lookup = pos;
	lookup.x += (2. * lerps.g - 1.) * .05 * alpha;
	lookup.y -= (2. * lerps.b - 1.) * .05 * alpha;
	vec4 nyanColor = getNyanCatColor(lookup);
	vec4 bgColor = texture(iChannel1, lookup);
	vec4 color;
	color.rgb = nyanColor.rgb * nyanColor.a + (1. - nyanColor.a) * bgColor.rgb;
	color.a = bgColor.a;
	
	fragColor.r = .75 * dot(color.rgb, lerps.rgb);
	fragColor.g = .75 * dot(color.rgb, lerps.brg);
	fragColor.b = .75 * dot(color.rgb, lerps.gbr);
	fragColor.a = color.a;
}