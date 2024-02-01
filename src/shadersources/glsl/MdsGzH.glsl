// a test shader to understand the iDate input
float smoothbump(float center, float width, float x) {
  float w2 = width/2.0;
  float cp = center+w2;
  float cm = center-w2;
  float c = smoothstep(cm, center, x) * (1.0-smoothstep(center, cp, x));
  return c;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
  vec2  uv = (fragCoord.xy / iResolution.xy);
  float y = 1.0 - uv.y;
  float scaled_year   = (iDate.x - 2000.0)/100.0; // good for 100 years :)
  float scaled_month  = iDate.y/11.0;
  float scaled_day    = iDate.z/31.0;
  float scaled_second = iDate.w/(60.0*60.0*24.0);
  float c = 0.0;
  c = smoothbump(scaled_year,0.05,uv.x)    * smoothbump(0.125,0.25,y);
  c += smoothbump(scaled_month,0.05,uv.x)  * smoothbump(0.375,0.25,y);
  c += smoothbump(scaled_day,0.05,uv.x)    * smoothbump(0.625,0.25,y);
  c += smoothbump(scaled_second,0.05,uv.x) * smoothbump(0.875,0.25,y);
  fragColor = vec4(c,c,c,1.0); 
}
