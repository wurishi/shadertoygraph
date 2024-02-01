    const float T = 20.;

    float freqs[4];

    vec3 grid( in vec2 p )
    {
        float t0 = iTime;
    	float f = texture( iChannel0, vec2(0.2,0.25) ).x;
		float f2 = texture( iChannel0, vec2(0.7,0.25) ).x;
		
		// move over time
		t0 = iTime + 2.*f;
		if (t0 > T) t0 = T+10. + mod(t0, 10.);
        float v = 0.0;
		
		// primary squares cos & sin FM applied over time
        if (floor(mod(cos(t0*cos(sin(t0*3.)*t0*.01))*(.1+p.x)*10., 2.)) == 0.0) {
          v = 1.0;
        }
        if (floor(mod(t0*2.+p.y*10., 2.)) == 0.0) {
          v = 1.0;
        }
		
		// small background triangles
        float l = .02*sin(t0+.1*f2)/2.;
        if ((mod(p.y, .025) + mod(p.x, .025)) < l) {
          v = 0.0;
        }
        
		// the final color is either black or white
        return vec3(v,v,v);
    }

	// plane deformation, learned from the original shader toy :D
    vec3 deform( in vec2 p )
    {
        float t0 = max(iTime - 2., 0.);
		float f = texture( iChannel0, vec2(0.9,0.25) ).x;
		
		// this is a hack to make the shader toy preview look better
		if (f > .02 && f < .03) 
			f = .3;
		
        if ((t0-20.) > T) t0 = T + mod(t0,T); 
        vec2 uv;

		// apply deformation with a little FM
        vec2 q = vec2( sin(sin(t0*.1)*1.1*t0+p.x),
                       sin(sin(t0*.1)*1.2*t0+p.y) );
		//q = vec2(f, f);

        float r = dot(q,q);

        uv.x = sin(0.0+1.0*t0)+p.x*sqrt(r+1.0);
        uv.y = sin(0.6+1.1*t0)+p.y*sqrt(r+1.0);

		// tone down the deformation for the vignette
		float rm = r * .5;
		
		// create a bloomy vignette, mix in the deformation parameter
		float vin = 3.3/(4.0+dot(rm*p*p,rm*p*p));

		// apply a vignette to both grid input uv 
		// and to the final resuls
		return vin*grid(vin*uv*.5 * (3. * sin(f))); 
    }

    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        float t0 = iTime+5.;
        if (t0 > T) t0 = T + mod(t0, 10.);;

		// setup some coords
        vec2 p = -1.0 + 2.0 * fragCoord.xy / iResolution.xy;
		vec2 uv = fragCoord.xy / iResolution.xy;
        vec2 s = p;

		// accumulator for blur
        vec3 total = vec3(0.0);
		
		// two different blur factors
        vec2 d1 = (vec2(0.0,0.0)-p)/240.0;
        vec2 d2 = (p-vec2(0.0,0.0))/240.0;

		// lerp between the blur factors based on low-end frequency
		float f = texture( iChannel0, vec2(0.99,0.25) ).x;
        vec2 d = mix(d1,d2, f*3.);
		
		// this was the old FM effect, with no music input
		//.5+.5*sin(sin(sin(t0)*t0)*t0));

		// apply the radial blur to the result of the plane deformation
        float w = 1.5;
        for( int i=0; i<40; i++ )
        {
            vec3 res = deform(s);
            res = smoothstep(0.1,1.0,res*res);
            total += w*res;
            w *= .99;
            s += d;
        }
		
        total /= 40.0;
		
		// used to apply a vignette here, but because it was static
		// it looked too obvious
        float r = 1.0; //1.5/(1.0+dot(p,p));
        vec4 c = vec4( total*r,1.0);
		
		// grab high, mid and low freqs and shift the output color
		float fr = texture( iChannel0, vec2(0.99,0.25) ).x;		
		float fg = texture( iChannel0, vec2(0.5,0.25) ).x;
		float fb = texture( iChannel0, vec2(0.1,0.25) ).x;
		c.rgb += .5* vec3(fr,fg,fb);
		
		// bam!
		fragColor = c;
    }
