const int nSamples = 64;


vec2 rotate(vec2 v,float t)
{
	float ct = cos(t);
	float st = sin(t);
	return vec2(ct*v.x-st*v.y,st*v.x+ct*v.y);
}
		
vec2 transform(float time, vec2 offset)
{
	vec2 mid = vec2(0.5, 0.5);
	return rotate(vec2(cos(time*1.07)*0.2, sin(time)*0.2) + offset - mid, sin(time/10.0)*5.00)*(cos(time*0.87)/2.0+1.0) + mid;
}

const float TIMESHIFT = 1.0;
	
const float TIME0 = 0.0/60.0;
const float TIME1 = 3.0/60.0;
const float TIME2 = 6.0/60.0;
const float TIME3 = 9.0/60.0;
const float TIME4 = 12.0/60.0;

const float WEIGHT01 = 2.0;
const float WEIGHT12 = 3.0;
const float WEIGHT23 = 2.0;
const float WEIGHT34 = 1.0;

const vec3 LUMINANCE = vec3(0.213, 0.715, 0.072);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 offset = fragCoord.xy / iResolution.xy;

	vec3 timeTex = texture(iChannel1,offset).xyz;
	float timeOffset = iTime+dot(LUMINANCE,timeTex)*TIMESHIFT;

	offset.y -= 0.5;
	offset.y *= iResolution.y / iResolution.x;
	offset.y += 0.5;
	
	// time offsets 
	vec2 uv0 = transform(timeOffset-TIME0, offset);
	vec2 uv1 = transform(timeOffset-TIME1, offset);
	vec2 uv2 = transform(timeOffset-TIME2, offset);
	vec2 uv3 = transform(timeOffset-TIME3, offset);
	vec2 uv4 = transform(timeOffset-TIME4, offset);
	vec2	delta01 = uv1-uv0;
	vec2	delta12 = uv2-uv1;
	vec2	delta23 = uv3-uv2;
	vec2	delta34 = uv4-uv3;

	delta01 /= float(nSamples/4);
	delta12 /= float(nSamples/4);
	delta23 /= float(nSamples/4);
	delta34 /= float(nSamples/4);
	
	vec3 col01 = texture(iChannel0,uv0).xyz;
	for(int i=1; i<nSamples/4; i++)
	{
		uv0 += delta01;
		col01 += texture(iChannel0,uv0).xyz;
	}

	vec3 col12 = texture(iChannel0,uv1).xyz;
	for(int i=1; i<nSamples/4; i++)
	{
		uv1 += delta12;
		col12 += texture(iChannel0,uv1).xyz;
	}

	vec3 col23 = texture(iChannel0,uv2).xyz;
	for(int i=1; i<nSamples/4; i++)
	{
		uv2 += delta23;
		col23 += texture(iChannel0,uv2).xyz;
	}
	
	vec3 col34 = texture(iChannel0,uv3).xyz;
	for(int i=1; i<nSamples/4; i++)
	{
		uv3 += delta34;
		col34 += texture(iChannel0,uv3).xyz;
	}

	vec3 col = col01*WEIGHT01 + col12*WEIGHT12 + col23*WEIGHT23 + col34*WEIGHT34;
	col /= (WEIGHT01+WEIGHT12+WEIGHT23+WEIGHT34)*float(nSamples/4);
	
	fragColor = vec4(mix(col,timeTex,dot(LUMINANCE,col)),1.0);
}
