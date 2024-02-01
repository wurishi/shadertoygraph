
// BEGIN CODE PASTED FROM: https://github.com/ashima/webgl-noise/blob/master/src/noise2D.glsl
// -------------

//
// Description : Array and textureless GLSL 2D simplex noise function.
//      Author : Ian McEwan, Ashima Arts.
//  Maintainer : ijm
//     Lastmod : 20110822 (ijm)
//     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//               Distributed under the MIT License. See LICENSE file.
//               https://github.com/ashima/webgl-noise
// 

vec3 mod289(vec3 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec2 mod289(vec2 x) {
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec3 permute(vec3 x) {
  return mod289(((x*34.0)+1.0)*x);
}

float snoise(vec2 v)
  {
  const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                      0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                     -0.577350269189626,  // -1.0 + 2.0 * C.x
                      0.024390243902439); // 1.0 / 41.0
// First corner
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);

// Other corners
  vec2 i1;
  //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
  //i1.y = 1.0 - i1.x;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  // x0 = x0 - 0.0 + 0.0 * C.xx ;
  // x1 = x0 - i1 + 1.0 * C.xx ;
  // x2 = x0 - 1.0 + 2.0 * C.xx ;
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;

// Permutations
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
		+ i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;

// Gradients: 41 points uniformly over a line, mapped onto a diamond.
// The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;

// Normalise gradients implicitly by scaling m
// Approximation of: m *= inversesqrt( a0*a0 + h*h );
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );

// Compute final noise value at P
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}

// -------------
// END CODE PASTED FROM: https://github.com/ashima/webgl-noise/blob/master/src/noise2D.glsl


// Natural Variation Test - 2013
// Daniel "Asteropaeus" Dresser


// 1D noise using ashima's simplex noise
// Calculates derivatives using brute force forward differencing
// Return value is ( noise, first derivative, second derivative )
vec3 snoise_1D_with_deriv(float t)
{
	float delta = 0.01;
	float samplev = snoise( vec2( t, 0.2 ) );
	float sampleStep = snoise( vec2( t + delta, 0.2 ) );
	float sampleStep2 = snoise( vec2( t + delta * 2.0, 0.2 ) );
	return vec3( samplev, (sampleStep - samplev) / delta, -(sampleStep * 2.0 - (samplev + sampleStep2)) / ( delta * delta) );
}



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// A pile of parameters, all of these could also be randomly driven to add changes
	// in overall texture
	float noiseFreq1 = 1.0;
	float noiseFreq2 = 2.5234;
	float noiseFreq3 = 5.37;
	float noiseFreq4 = 9.38;
	
	float noiseMult1 = 1.0;
	float noiseMult2 = 0.2;
	float noiseMult3 = 0.05;
	float noiseMult4 = 0.05;
	float noiseClamp4 = 1.5;
	
	// Uncomment to try driving various things with the mouse
	/*
	noiseMult1 = 0.0 + 0.002 * iMouse.x;
	//noiseMult2 = 0.0 + 0.001 * iMouse.x;
	//noiseMult3 = 0.0 + 0.0001 * iMouse.x;
	//noiseMult4 = 0.0 + 0.0001 * iMouse.x;
	//noiseClamp4 = 0.0 + 0.01 * iMouse.x;
	*/
	
	
	
	
	vec2 uv = fragCoord.yx / iResolution.yx;
	
	
	float time = iTime * 0.5 + uv.y * 5.0;

	
	
	vec3 noise1 = snoise_1D_with_deriv(time * noiseFreq1);
	noise1.y *= noiseFreq1;
	
	
	vec3 noise2 = snoise_1D_with_deriv(time * noiseFreq2);
	noise2.y *= noiseFreq2;
	
	
	vec3 noise3 = snoise_1D_with_deriv(time * noiseFreq3);
	noise3.y *= noiseFreq3;
	
	
	vec3 noise4 = snoise_1D_with_deriv(time * noiseFreq4);
	noise4.y *= noiseFreq4;
	
	// Set the weight on the second octave to the derivative of the first octave
	vec2 weight2 = noise1.yz * noiseMult2;
	//weight2.y = 0.0;
	
	// Calculate the combination of the first and second octaves, including their derivatives,
	vec2 combined2 = noiseMult1 * noise1.xy + vec2( weight2.x * noise2.x, weight2.x * noise2.y + weight2.y * noise2.x );
	
	// Set the weight on the third octave to the derivative of the first and second octaves combined
	// Note that the second component, representing the first derivative, is left 0 here
	// To compute it, we would need the third derivative of the noise - might increase quality if we did
	vec2 weight3 = vec2( combined2.y * noiseMult3, 0.0);
	
	vec2 combined3 = combined2 + vec2( noise3.x * weight3.x, noise3.y * weight3.x);
	
	// Set the weight on the fourth octave to the derivative of the previous octaves
	vec2 weight4 = vec2( max( 0.0, abs(combined3.y) - noiseClamp4) * noiseMult4, 0.0);
	
	vec2 combined4 = combined3 + vec2( noise4.x * weight4.x, noise4.y * weight4.x);
    
    float final = max( combined4.x * 0.5 + 0.2, 0.0 );
	
	float x0 = 0.5 + combined4.x * 0.2;
	
	fragColor = vec4(
		vec3(1.0 - (abs(uv.x - x0) / (0.003 + abs(dFdx( x0 ) ) * 1.0))),
		1.0);

}