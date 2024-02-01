void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// Simple Starburst
	// @author Tomek Augustyn 2010
	
	// Ported from my old PixelBender experiment
	// https://github.com/og2t/HiSlope/blob/master/src/hislope/pbk/generators/Starburst.pbk
	
	// Hold and drag horizontally to adjust the number of rays (period)
	// Hold and drag vertically to adjust the twist
	
	// Disclaimer: May cause seizures, watch out!
	
	float ratio = iResolution.y / iResolution.x;
	float period = floor(((iMouse.x / iResolution.x) - 0.5) * 20.0) + 0.0;
	float twist = float(iMouse.y / iResolution.y * 1000.0) - 500.0;
	float rotation = iTime * 4.0; 
	vec2 center = vec2(0.5, 0.5 * ratio);
	vec3 background = vec3(0.4, 0.2, 0.1);
	vec3 foreground = vec3(0.2, 0.5, 0.8);
	
	float coordX = fragCoord.x / iResolution.x;
	float coordY = fragCoord.y / iResolution.x;
	vec2 coord = vec2(coordX, coordY);
	
	vec2 shift = coord - center;
        
    float offset = rotation + sqrt(shift.x * shift.x + shift.y * shift.y) * twist / 10.0;
    float val = sin((offset + atan(shift.x, shift.y) * period));

	fragColor = vec4(
    	mix(background.r, foreground.r, val),
        mix(background.g, foreground.g, val),
        mix(background.b, foreground.b, val),
        1.0
    );
}