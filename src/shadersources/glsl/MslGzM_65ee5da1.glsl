void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float gridSize = max(iMouse.x/8.0, 0.1); //Divided by 8 because it gets too unseeable
	
	float gridSizeX = gridSize/iResolution.x;
	float gridSizeY = gridSize/iResolution.y;
	
	float uvx = fragCoord.x / iResolution.x;
	float uvy = fragCoord.y / iResolution.y;
	
	float gx = floor(uvx/gridSizeX)*gridSizeX;
	float gy = floor(uvy/gridSizeY)*gridSizeY;
	
	//fragColor = vec4(gx,gy,0,1.0);
	fragColor = texture(iChannel0, vec2(gx, gy));
}