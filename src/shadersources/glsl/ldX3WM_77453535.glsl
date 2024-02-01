void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float time = iTime * -30.0;
	float thickness = 15.0 + sin(time * 0.02) * 10.0;
	vec2 uv = fragCoord.xy / iResolution.xy; // 0..1
	uv = uv * 2.0 - vec2(1.0, 1.0); // -1 .. +1
	float d = length(uv); // distance from center
	float angle = degrees(atan(uv.y, uv.x)); // angle from center
	float mixer = step(mod(angle + time + 150.0 * log(d), 30.0), thickness);
	
	fragColor = mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(1.0, 1.0, 1.0, 1.0), mixer);
}