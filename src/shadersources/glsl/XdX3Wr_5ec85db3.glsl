vec4 tex(vec2 uv){
  return texture(iChannel0,uv);	
}
float border(float b){
  return mix(b/0.25,1.0,step(0.25,b));	 
}
vec2 map2d(vec2 uv,vec2 focus){
  float ml=min(border(uv.x),border(1.0-uv.x))*min(border(uv.y),border(1.0-uv.y));
  vec2 newuv=uv-focus;
  float l=length(newuv);
  return (newuv*mix(l/ml,1.0,step(ml,l)))+focus;	
}
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	vec2 focus=vec2(0.5+(sin(iTime+cos(iTime*2.126))*0.375),0.5+(cos(iTime+sin(iTime*1.33))*0.375));
	vec2 newuv=map2d(uv,focus);
	vec4 c=tex(newuv);
	fragColor = c;
}