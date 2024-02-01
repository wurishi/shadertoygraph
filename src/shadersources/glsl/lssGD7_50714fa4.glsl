float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Set ratio
	vec2 uv = fragCoord.xy / iResolution.xy;
	float screenRatio = iResolution.x / iResolution.y;
    
	// Invert video on Y if needed
    vec2 uvr = vec2(uv.x, 1. - uv.y);
    
    // Read video
	vec3 texture = texture(iChannel0, uvr).rgb;
	
    // Bar effect
	float barHeight = 6.;
	float barSpeed = 5.6;
	float barOverflow = 1.2;
	float blurBar = clamp(sin(uv.y * barHeight + iTime * barSpeed) + 1.25, 0., 1.);
	float bar = clamp(floor(sin(uv.y * barHeight + iTime * barSpeed) + 1.95), 0., barOverflow);
	
    // Snow effect
	float noiseIntensity = .75;
	float pixelDensity = 250.;
	vec3 color = vec3(clamp(rand(
		vec2(floor(uv.x * pixelDensity * screenRatio), floor(uv.y * pixelDensity)) *
		iTime / 1000.
	) + 1. - noiseIntensity, 0., 1.));
	
    // Mix colors
	color = mix(color - noiseIntensity * vec3(.25), color, blurBar);
	color = mix(color - noiseIntensity * vec3(.08), color, bar);
	color = mix(vec3(0.), texture, color);
	
    // Add a blue tint
    color.b += .042;
	
    // Vignette
	color *= vec3(1.0 - pow(distance(uv, vec2(0.5, 0.5)), 3.0) * 3.0);
	
    // Return
	fragColor = vec4(color, 1.);
}