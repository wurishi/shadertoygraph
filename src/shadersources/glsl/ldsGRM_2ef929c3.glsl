vec2 fragCoord;
vec4 fragColor;

float distanceToLineSegment(vec2 a, vec2 b, vec2 p)
{
    float dist = distance(a,b);
    vec2 v = normalize(b-a);
    float t = dot(v,p-a);
    vec2 spinePoint;
    if (t > dist) spinePoint = b;
    else if (t > 0.0) spinePoint = a + t*v;
    else spinePoint = a;
    return distance(p,spinePoint);

}

float distanceToLine(float angle, float factor)
{
  float s = sin(angle)*factor;
  float c = cos(angle)*factor;
  vec2 p1 = vec2(0.5,0.5) * iResolution.xy + vec2(s,c) * iResolution.yy;
  vec2 p2 = vec2(0.5,0.5) * iResolution.xy;
  return distanceToLineSegment(p1, p2, fragCoord.xy);
}

float distanceToLine(float angle, float end, float begin)
{
  float se = sin(angle)*end;
  float ce = cos(angle)*end;
  vec2 p1 = vec2(0.5,0.5) * iResolution.xy + vec2(se,ce) * iResolution.yy;
  float sb = sin(angle)*begin;
  float cb = cos(angle)*begin;
  vec2 p2 = vec2(0.5,0.5) * iResolution.xy + vec2(sb,cb) * iResolution.yy;;
  return distanceToLineSegment(p1, p2, fragCoord.xy);
}

void drawLine(float d, float lineWidth, float borderWidth)
{
  if (d <= lineWidth)
  {
	float m = clamp(d-(lineWidth-1.0), 0.0, 1.0);

    fragColor = mix(vec4(0.5,0.2,0.0,2.0), fragColor, m);

    if (d <= (lineWidth-borderWidth))
  	{
		float m = clamp(d-(lineWidth-borderWidth-1.0), 0.0, 1.0);
	
		fragColor = mix(vec4(0.5,0.2,0.0,1.0), texture(iChannel0, fragCoord.xy / iResolution.xy), 1.0-m);
    }
  }
}

void mainImage( out vec4 oFragColor, in vec2 iFragCoord )
{
  fragCoord = iFragCoord;
  float angleSeconds = ((mod(iDate.a,60.0)) * 3.14159265) / 30.0;
  float angleMinutes = ((iDate.a / 60.0) * 3.14159265) / 30.0;
  float angleHours   = ((iDate.a / 60.0 / 12.0) * 3.14159265) / 30.0;
	
  float dSecond = distanceToLine(angleSeconds, 0.40);
  float dMinute = distanceToLine(angleMinutes, 0.40);
  float dHours  = distanceToLine(angleHours, 0.20);

  fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);//  vec4(1.0,1.0,1.0,1.0);

  for (float minute = 0.0; minute < 60.0; minute += 1.0)
  {
	  float angle = (minute * 3.14159265) / 30.0;
	  if (mod(minute, 5.0)!=0.0)
	  {
	    float dDot = distanceToLine(angle, 0.475, 0.460);
	  	drawLine(dDot, 4.0, 1.5);
	  }
	  else
	  {
	    float dDot = distanceToLine(angle, 0.475, 0.450);
	  	drawLine(dDot, 4.0, 1.5);
	  }
  }
	
  drawLine(dHours, 20.0, 2.0);
  drawLine(dMinute, 15.0, 2.0);
  drawLine(dSecond, 10.0, 1.5);
  oFragColor = fragColor;
}