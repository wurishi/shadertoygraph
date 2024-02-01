void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	 vec3 waveParams = vec3( 10.0, 0.8, 0.1 );
	 vec2 tmp = vec2( iMouse.xy / iResolution.xy );
	 vec2 uv = fragCoord.xy / iResolution.xy;
	 vec2 texCoord = uv;
	 float distance = distance(uv, tmp);
	 
	 if ( (distance <= ((iTime ) + waveParams.z )) && ( distance >= ((iTime ) - waveParams.z)) ) 
	 {
		    float diff = (distance - (iTime)); 
		    float powDiff = 1.0 - pow(abs(diff*waveParams.x), waveParams.y); 
		 
		    float diffTime = diff  * powDiff; 
		    vec2 diffUV = normalize(uv - tmp); 
		    texCoord = uv + (diffUV * diffTime);
		    
	 } 
	 vec4 original = texture( iChannel0, texCoord);
	 fragColor = original; 
}