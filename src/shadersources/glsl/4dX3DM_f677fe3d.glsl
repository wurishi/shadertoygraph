
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    int CELL_SIZE = 6;
    float CELL_SIZE_FLOAT = float(CELL_SIZE);
    int RED_COLUMNS = int(CELL_SIZE_FLOAT/3.);
    int GREEN_COLUMNS = CELL_SIZE-RED_COLUMNS;

    
	vec2 p = floor(fragCoord.xy / CELL_SIZE_FLOAT)*CELL_SIZE_FLOAT;
	int offsetx = int(mod(fragCoord.x,CELL_SIZE_FLOAT));
	int offsety = int(mod(fragCoord.y,CELL_SIZE_FLOAT));

	vec4 sum = texture(iChannel0, p / iResolution.xy);
	
	fragColor = vec4(0.,0.,0.,1.);
	if (offsety < CELL_SIZE-1) {		
		if (offsetx < RED_COLUMNS) fragColor.r = sum.r;
		else if (offsetx < GREEN_COLUMNS) fragColor.g = sum.g;
		else fragColor.b = sum.b;
	}
	
}