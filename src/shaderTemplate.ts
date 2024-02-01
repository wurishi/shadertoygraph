export const vertex = `#version 300 es
in vec4 a_position;

void main() {
  gl_Position = a_position;
}
`

export const newVertex = `#version 300 es
layout(location = 0) in vec2 pos;
void main() {
  gl_Position = vec4(pos.xy, 0.0, 1.0);
}
`

export const fragment = `#version 300 es
#ifdef GL_ES
precision {PRECISION} float;
precision {PRECISION} int;
precision mediump sampler3D;
#endif

#define HW_PERFORMANCE 1;

uniform vec3    iResolution;
uniform float   iTime;

// uniform float iChannelTime[4];

uniform vec4    iMouse;
uniform vec4    iDate;
// uniform float iSampleRate;
// uniform vec3 iChannelResolution[4];

uniform int     iFrame;
uniform float   iTimeDelta;

// uniform float iFrameRate;


uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;

{COMMON}

{USER_FRAGMENT}

out vec4 shadertoy_out_color;

void main() {
  shadertoy_out_color = vec4(1.0,1.0,1.0,1.0);
  vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
  mainImage(color, gl_FragCoord.xy);
  if(shadertoy_out_color.x < 0.0) color = vec4(1.0, 0.0, 0.0, 1.0);
  if(shadertoy_out_color.y < 0.0) color = vec4(0.0, 1.0, 0.0, 1.0);
  if(shadertoy_out_color.z < 0.0) color = vec4(0.0, 0.0, 1.0, 1.0);
  if(shadertoy_out_color.w < 0.0) color = vec4(1.0, 1.0, 0.0, 1.0);
  shadertoy_out_color = vec4(color.xyz, 1.0);
}
`

export const buffFragment = `#version 300 es
#ifdef GL_ES
precision {PRECISION} float;
precision {PRECISION} int;
precision mediump sampler3D;
#endif

#define HW_PERFORMANCE 1;

uniform vec3    iResolution;
uniform float   iTime;

// uniform float iChannelTime[4];

uniform vec4    iMouse;
uniform vec4    iDate;
// uniform float iSampleRate;
// uniform vec3 iChannelResolution[4];

uniform int     iFrame;
uniform float   iTimeDelta;

// uniform float iFrameRate;


uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;

{COMMON}

{USER_FRAGMENT}

out vec4 outColor;

void main() {
  vec4 color = vec4(0.0, 0.0, 0.0, 1.0);
  mainImage(color, gl_FragCoord.xy);
  outColor = color;
}
`

export const COPY_FRAGMENT1 = `#version 300 es
#ifdef GL_ES
precision {PRECISION} float;
precision {PRECISION} int;
precision mediump sampler3D;
#endif

uniform vec4 v;
uniform sampler2D t;
out vec4 outColor;
void main() {
  vec2 uv = gl_FragCoord.xy / v.zw;
  outColor = texture(t, vec2(uv.x, 1.0 - uv.y));
}
`

export const COPY_FRAGMENT = `#version 300 es
#ifdef GL_ES
precision {PRECISION} float;
precision {PRECISION} int;
precision mediump sampler3D;
#endif

uniform vec4 v;
uniform sampler2D t;
out vec4 outColor;
void main() {
  outColor = textureLod(t, gl_FragCoord.xy / v.zw, 0.0);
}
`

export const DEFAULT_SOUND = `
vec2 mainSound( int samp, float time )
{
    // A 440 Hz wave that attenuates quickly overt time
    return vec2( sin(6.2831*440.0*time)*exp(-3.0*time) );
}
`
