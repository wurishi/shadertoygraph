void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	float da, db, dm, r, left, middle, right, width, len;
	float leftv, middlev, rightv;
	float mf1, mf2, mf3, mf4;
	float xInMiddle;
	float onlen, onofflen, aawidth;
	vec2 a,p,b;
	
	// Constants from input
	onofflen = 60.0;
	onlen = 30.0;
	aawidth = 3.0;
	
	// Uncomment these to have some fun
	// onlen = sin(iTime)* sin(iTime) * onofflen;
	// aawidth = sin(iTime)* sin(iTime)* 25.0; // change to zero to see non-antialiased jagged lines
	
	width = iResolution.x;
	
	
	p.x = fragCoord.x;
	p.y = fragCoord.y;
	r = iResolution.y/2.0;
	
	// distance between the two semi-cirlces. Also the line length
	len = width - r*2.0;
	
	// Center of left semi-circle
	a.x = r;
	a.y = iResolution.y/2.0;
	
	// Center of right semi-circle
	b.x = iResolution.x - r;
	b.y = iResolution.y/2.0;
	
	// Distance of this point from center of the semi circles
	da = distance(a,p);
	db = distance(b,p);
	
	// Vertical distance from center axis
	dm = abs(fragCoord.y - r);
	
	// regions: left middle right
	left = 1.0 - step(r,fragCoord.x);
	middle = 1.0 - step(r+len,fragCoord.x) - left;
	right = 1.0 - step(width, fragCoord.x) - left - middle;
		
	/// left semi circle
	leftv = (r - da)/aawidth;
	clamp(leftv, 0.0, 1.0);
	
	/// right semi circle
	rightv = (r - db)/aawidth;
	clamp(rightv, 0.0, 1.0);
	
	/// middle part
	
	// antialias top & bottom
	mf1 = (r - dm)/aawidth;
	mf1 = clamp(mf1, 0.0, 1.0);

	// Stippling
	xInMiddle = fragCoord.x - r;
	mf2 = 1.0 - step(onlen, mod(xInMiddle,onofflen));
	
	// anti-alias left edge of stipple
	mf3 = mod(xInMiddle,onofflen)/aawidth;
	// eliminate left anti-alias for first stipple
	mf3 = mf3 + 1.0 - step(aawidth, xInMiddle);
	
	// anti-alias right edge of stipple
	mf4 = (onlen - mod(xInMiddle,onofflen))/aawidth;
	
	
	// Clamp all values
	mf2 = clamp(mf2,0.0,1.0);
	mf3 = clamp(mf3,0.0,1.0);
	mf4 = clamp(mf4,0.0,1.0);
	
	// Combine values for middle part
	middlev = mf1 * mf2 * mf3 * mf4; // middle part
	
	fragColor = vec4(
		// Combine values for entire line
		left * leftv + middle * middlev + right * rightv,
		0.0, 0.0, 1.0); 
	// in real life use the computed value for alpha instead of Red channel


	// Uncomment the following to see the regioning logic
	/*
	fragColor = vec4(
		left * leftv,
		middle * middlev,
		right * rightv,
		1.0);
	*/
	
}