// Doodle based on Sound Visualizer https://www.shadertoy.com/view/Xds3Rr
// and 
// http://vimeo.com/51993089 @ the 0min 44s mark
// 
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = 2.0*(fragCoord.xy/iResolution.xy) - 1.0;
	// equvalent to the video's spec.y, I think
	vec2 spec = 1.0*texture( iChannel0, 
                               vec2(0.25,5.0/100.0) ).xx;
	
    float col = 0.0;
    uv.x += sin(iTime * 6.0 + uv.y*1.5)*spec.y;
    col += abs(0.066/uv.x) * spec.y;
	fragColor = vec4(col,col,col,1.0);
}