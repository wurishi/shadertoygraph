// Simple experimental shader.
// The circle goes where the mouse click is.

bool drawPCBar(vec2 mPos, vec2 fragPos)
{
	return (fragPos.y >= 270.0)
		&& (abs(mPos.x - fragPos.x) <= 50.0);
}

bool drawPlayerBar(vec2 mPos, vec2 fragPos)
{
	return (fragPos.y <= 20.0)
		&& (abs(mPos.x - fragPos.x) <= 50.0);				
}

bool drawCircle(vec2 fragPos)
{
	vec2 dir = vec2(0.0, 1.0);
	vec2 pos = dir * (300.0 * sin(iTime));
	pos.y += 20.0;
	vec2 vecDiff = fragPos.xy - pos;
	
	float dis = sqrt ( dot(vecDiff, vecDiff) );
	float dis_T = 20.0;
	
	return dis <= dis_T;
	
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	
	vec2 uv = fragCoord.xy / iResolution.xy;	
	
	if (drawCircle(fragCoord.xy)
	 || drawPlayerBar(iMouse.xy, fragCoord.xy) 
	 || drawPCBar(iMouse.xy, fragCoord.xy) )
		
		fragColor = vec4(uv,0.5+0.5*sin(iTime),1.0);
	
	else {
		float col = 0.5 * sin(iTime);
		fragColor = vec4(0.5, 0.5, 0.5, 1.0);
	}
}