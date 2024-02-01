void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float t = mod(iTime, 24.0);
	
	float offset = 7.0;
	
	float duskStart = 16.0 - offset;
	float duskEnd   = 19.0 - offset;
	float darkStart = 21.0 - offset;
	float darkEnd   = 24.0 - offset;
	float dayStart  =  4.0 - offset + 24.0;
	float dayEnd    =  7.0 - offset + 24.0;
	
	t = mod(t - offset, 24.0);

	float toDusk = (clamp(t, duskStart, duskEnd) - duskStart) / (duskEnd - duskStart);
	float toDark = (clamp(t, darkStart, darkEnd) - darkStart) / (darkEnd - darkStart);
	float toDay  = (clamp(t, dayStart,   dayEnd) -  dayStart) / (dayEnd  -  dayStart);

	vec4 dayTop  = vec4(0.0, 0.0, 1.0, 1.0);
	vec4 dayBtm  = vec4(1.0, 1.0, 1.0, 1.0);
	vec4 duskTop = vec4(0.5, 0.2, 0.0, 1.0);
	vec4 duskBtm = vec4(0.8, 0.8, 0.8, 1.0);
	vec4 darkTop = vec4(0.0, 0.0, 0.0, 1.0);
	vec4 darkBtm = vec4(0.0, 0.0, 0.0, 1.0);

	vec4 top = dayTop;
	vec4 btm = dayBtm;

	top = mix(top, duskTop, toDusk);
	top = mix(top, darkTop, toDark);
	top = mix(top, dayTop, toDay);

	btm = mix(btm, duskBtm, toDusk);
	btm = mix(btm, darkBtm, toDark);
	btm = mix(btm, dayBtm, toDay);
	
	fragColor = mix(top, btm, 1.0 - (fragCoord.y / iResolution.y));
}
