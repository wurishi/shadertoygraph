#define INF 7.0

float marched = 0.0;
const float PI = 3.14159265359;
const float DEG_TO_RAD = PI / 180.0;
// camera rotation : pitch, yaw
mat3 rotationXY( vec2 angle ) {
	vec2 c = cos( angle );
	vec2 s = sin( angle );
	
	return mat3(
		c.y      ,  0.0, -s.y,
		s.y * s.x,  c.x,  c.y * s.x,
		s.y * c.x, -s.x,  c.y * c.x
	);
}

float sdSphere( vec3 p, float size)
{
  return length(p)-1.2;
}
/*
float sdBox( vec3 p, vec3 b )
{
  vec3 d = abs(p) - b;
  return min(max(d.x,max(d.y,d.z)),0.0) +
         length(max(d,0.0));
}
*/
float sdBox( vec3 p, vec3 b )
{
 vec3 moi;
	vec3 d ;
  d.x = abs(p.x) - b.x;
  d.y = abs(p.y) - b.y;
  d.z = abs(p.z) - b.z;
  moi.x = max(d.x,0.0);
	moi.y = max(d.y,0.0);
	moi.z = max(d.z,0.0);
	return min(max(d.x,max(d.y,d.z)),0.0) +
         sqrt(moi.x*moi.x+moi.y*moi.y+moi.z*moi.z);
}

float sdCross( in vec3 p )
{
  float da = sdBox(p.xyz,vec3(INF,1.0,1.0));
  float db = sdBox(p.yzx,vec3(1.0,INF,1.0));
  float dc = sdBox(p.zxy,vec3(1.0,1.0,INF));
  return min(da,min(db,dc));
}



	
float map( vec3 p )
{
   vec3 pui;
   pui.x = 1.0;
   pui.y = 1.0;
   pui.z = 1.0;
   float d = sdBox(p,pui);
   int m;
   float s = 1.0;
   for( int m=0; m<3; m++ )
   {
   	  vec3 a;
   	  vec3 q;
   	  q.x = p.x*s;
   	  q.y = p.y*s;
   	  q.z = p.z*s;
      a.x = mod( q.x, 1.0 )-1.0;
      a.y = mod( q.y, 1.0 )-1.0;
      a.z = mod( q.z, 1.0 )-1.0;
      s *= 3.0;
      vec3 r;
      r.x = 3.0 - 6.0*abs(a.x);
      r.y = 3.0 - 6.0*abs(a.y);
      r.z = 3.0 - 6.0*abs(a.z);
      
      float c = sdCross(r)/s;
      d = max(d,-c);
   }

   return d;
}
float rm(vec3 origin, vec3 ray, float min_distance, float max_distance) {
	int i;
	float distance_marched = min_distance;
	for (int i=0; i<240; i++) {
		float indiX = ray.x*distance_marched;
		float indiY = ray.y*distance_marched;
		float indiZ = ray.z*distance_marched;
		vec3 moi;
		moi.x = indiX + origin.x;
		moi.y = indiY + origin.y;
		moi.z = indiZ + origin.z;
		float step_distance = map(moi);
		if (abs(step_distance) < 0.0001) {
			return distance_marched/(max_distance-min_distance);
		}
		distance_marched += step_distance;
		marched=distance_marched;
		if (distance_marched > max_distance) {
			return -1.0;
		}
	}
	return -1.0;
}
	vec3 render(vec2 q) {
	vec3 dir;
	vec3 screen;
	vec3 ray;
    vec2 moro = vec2 (iTime);

	dir.x = 0.0;
	dir.y = 0.0;
	dir.z = -2.8;
	mat3 rot = rotationXY(moro);
	screen.x = q.x;
	screen.y = q.y;
	screen.z = -2.0;
	ray.x = screen.x - dir.x;
	ray.y = screen.y - dir.y;
	ray.z = screen.z - dir.z;
	
	float s = rm(rot*dir, rot*ray, 1.0, 4.0);
	
	vec3 col;
	
	if (s == -1.0) {
				col.x = 0.0;
				col.y = 0.0;
				col.z = 0.0;

	} else {
	
      //  float f = 1.0-(it/float(MAX_RAY_STEPS));

	  
		col = vec3(s-.8*.8+0.4*q.y *sin(q.x))*marched/1.76;
		col.rg *= marched*.4;
	}
	
	return col;
	
	}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 q = (2.0*fragCoord.xy - iResolution.xy)/iResolution.x;
	
	vec3 col = render(q);
	fragColor = vec4(col.xyz, 1.0);
}
