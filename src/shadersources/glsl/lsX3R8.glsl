precision mediump float;

float ballsCloseness(vec2 p)
{
  	float sumCloseness = 0.0;
  
  	float increment = 1.0 / 40.0;
	for (float i = 0.0; i < 39.0; i += 1.0)
    {
	  	vec2 aspectRatio = iResolution.xy / iResolution.x;
  		vec2 ballPos = vec2(increment + i * increment, 0.5 + 0.5 * cos((i + 1.0) * iTime * 0.05));
  		float distance = distance(p * aspectRatio, ballPos * aspectRatio);
  		float nonZeroDistance = max(0.0001, distance);
  		float closeness = (1.0 / nonZeroDistance);
     	sumCloseness += closeness / 400.0;
    }
  
  	return sumCloseness;
}

float spike(float center, float width, float val)
{
	float left = smoothstep(center, center - width / 2.0, val);
  	float right = smoothstep(center - width / 2.0, center, val);
  	return left * right;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
  vec2 p = fragCoord.xy / iResolution.xy;
  
  float closeness = ballsCloseness(p);
  float spike1 = spike(0.39, 0.02, closeness);
  float spike2 = spike(0.4, 0.02, closeness);  
  float spike3 = spike(0.41, 0.02, closeness);
  float spike4 = spike(0.42, 0.02, closeness);
  float spike5 = spike(0.43, 0.02, closeness);
  float spike6 = spike(0.44, 0.02, closeness);
  float spike7 = spike(0.45, 0.02, closeness);

  float spikes = 2.0 * (spike1 * 0.8 + spike2 * 0.2 + spike3 * 0.9 + spike4 * 0.35 + spike5 * 0.9 + spike6 * 0.39 + spike7 * 0.5);
  
//  fragColor.r = 2.0 * (spike1 * 0.4 + spike2 * 0.5 + spike6 * 0.3 + spike7 * 0.8);
//  fragColor.g = 2.0 * (spike2 * 0.5 + spike3 * 0.65 + spike4 * 0.3 + spike5 * 0.1 + spike6 * 0.8);
//  fragColor.b = 2.0 * (spike1 * 0.8 + spike2 * 0.2 + spike3 * 0.9 + spike4 * 0.35 + spike5 * 0.9 + spike6 * 0.39 + spike7 * 0.5);

  float background = smoothstep(0.3, 0.5, closeness);
  
  fragColor.r = sin(iTime) * background + spikes;
  fragColor.g = cos(iTime / 25.0) * background + spikes;
  fragColor.b = cos(iTime / 100.0) * background + spikes;
  fragColor.a = 1.0;
}