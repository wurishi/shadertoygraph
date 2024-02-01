float smoothbump(float center, float width, float x) {
  float w2 = width/2.0;
  float cp = center+w2;
  float cm = center-w2;
  float c = smoothstep(cm, center, x) * (1.0-smoothstep(center, cp, x));
  return c;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy/iResolution.xy;
    uv.y = 1.0 - uv.y; // +Y is now "up"
    float freq = texture(iChannel0,vec2(uv.x,0.25)).x;
    float wave = texture(iChannel0,vec2(uv.x,0.75)).x;
    float freqc = smoothstep(0.0,(1.0/iResolution.y)* iTime, freq + uv.y - 0.5);
    float wavec = smoothbump(0.0,(4.0/iResolution.y)* iTime, wave + uv.y - 0.5);
    fragColor = vec4(freqc *iTime, wavec, 0.25,1.0);
}