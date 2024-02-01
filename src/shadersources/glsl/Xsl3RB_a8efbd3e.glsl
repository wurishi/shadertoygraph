precision mediump float;

const int Rows       = 5;
const int Cols       = Rows;
const float Height = 1./float(Rows);
const float Radius = Height/2.;

// return 0.5 if interects
// p is the point to shade
// d is the dot location
float d2(vec2 p, vec2 d){
  if (distance(p,d) <= Radius)
  {
	return 0.5;
  }
  else
  {
	return 0.0;
  }
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 p =  fragCoord.xy / iResolution.xy;
  float intensity = 0.;
  for(int row = 0;  row < 5; row++){
	for(int col = 0; col < 5; col++){
		vec2 dot_loc = vec2(Radius+float(row)*Height, Radius+float(col)*Height);
	
		intensity += d2(p, dot_loc); 
	}
  }	
  vec3 c = vec3(1.0, 1.0, 1.);
  c = c * intensity ;
  
  fragColor    = vec4(c , 1.0);
}
