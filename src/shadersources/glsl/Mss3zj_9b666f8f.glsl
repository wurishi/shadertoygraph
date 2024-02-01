//sets point where we call a cell alive or dead.
#define threshold 0.4

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
 	
	vec2 q = fragCoord.xy / iResolution.xy;
    vec2 p = -1.0 + 2.0*q;
	int count = 0;
	
	//TODO: START USING iChannelResolution0 INSTEAD
	float cw = 0.01/64.0; //the width of the cells
	float ch = 0.01/64.0; //the height of the cells
	
	//TODO: REPLACE THE TEXTURE WITH IQ'S NOISE MAGIC
  	vec4 C = texture(iChannel0, p);	//the cell we are working from
  	
	//the cell's 8 neighbouring cells
	vec4 E = texture( iChannel0, vec2(p.x + cw, p.y) );
	vec4 W = texture( iChannel0, vec2(p.x - cw, p.y) );
  	vec4 N = texture( iChannel0, vec2(p.x, p.y + ch) );
  	vec4 S = texture( iChannel0, vec2(p.x, p.y - ch) );
  	vec4 NE = texture( iChannel0, vec2(p.x + cw, p.y + ch));
  	vec4 NW = texture( iChannel0, vec2(p.x - cw, p.y + ch));
  	vec4 SE = texture( iChannel0, vec2(p.x + cw, p.y - ch));
  	vec4 SW = texture( iChannel0, vec2(p.x - cw, p.y - ch));
 
	//count the number of neighbouring cells which are dead
  	if(E.r < threshold) { count++; }
  	if(N.r < threshold) { count++; }
  	if(W.r < threshold) { count++; }
  	if(S.r < threshold) { count++; }
  	if(NE.r < threshold) { count++; }
  	if(NW.r < threshold) { count++; }
  	if(SE.r < threshold) { count++; }
	if(SW.r < threshold) { count++; }
 	
	//the simple rules. No particular rule set but just a pleaing result
  	if ((C.r == 0.0 && count > 5) || (C.r < threshold && (count > 3))) {
    	fragColor = vec4(1.0, 1.0, 1.0, 1.0); //cell lives...
  	} else {
    	fragColor = vec4(0.0, 0.0, 0.0, 1.0); //cell dies...
  	}
}
