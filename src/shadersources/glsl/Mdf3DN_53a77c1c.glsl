void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
// Texture coordinate
vec2 uv = fragCoord.xy / iResolution.xy;

// Lower frequency noise
float val1 = texture(iChannel0, (uv+vec2(iTime / 100.0, 0.0)) * .3).r;
float val2 = texture(iChannel0, (uv+vec2(0.0, iTime / 100.0)) * .3).r;

// Higher frequency noise
float val3 = texture(iChannel0, (uv+vec2(iTime / 100.0, 0.0)) ).r;
float val4 = texture(iChannel0, (uv+vec2(0.0, iTime / 100.0)) ).r;

float val = (val1 * val2) * (.5 + val3 * val4);
fragColor = vec4(val, val, val, 1.0);
}