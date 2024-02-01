void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    vec2 position = (fragCoord.xy/iResolution.xy);

    float cX = position.x - 0.5;
    float cY = position.y - 0.5;

    float newX = log(sqrt(cX*cX + cY*cY));
    float newY = atan(cX, cY);
     
	float PI = 3.14159;
	float numHorBands = 10.0;
	float numVertBands = 10.0;
	float numDiagBands = 10.0;
    float numArms = 6.0;
	float numLines = 5.0;
	float numRings = 5.0;
	float spiralAngle = PI/3.0;
	
    float color = 0.0;
	
	//Vertical Bands
	//color += cos(numVertBands*cY + iTime);	
	//Horizontal Bands
	color += cos(numHorBands*cX - iTime);	
	//Diagonal Bands
	//color += cos(2.0*numDiagBands*(cX*sin(spiralAngle) + cY*cos(spiralAngle)) + iTime);	
	//Arms
	//color += cos(numLines*newY + iTime);
	//Rings
	color += cos(numRings*newX - iTime);
    //Spirals
	color += cos(2.0*numArms*(newX*sin(spiralAngle) + newY*cos(spiralAngle)) + iTime);
	//overall brightness/color
	//color *= cos(iTime/10.0);
    fragColor = vec4( vec3( sin( color + iTime / 3.0 ) * 0.75, color, sin( color + iTime / 3.0 ) * 0.75 ), 1.0 );

}