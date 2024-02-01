// Shoots a ray through screen pixel (with screen plane being at z=f)
// and intersects with plane at y=h
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	// Calculate normalized screen space (lower left is (-0.5,-0.5))
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv -= vec2(0.5, 0.5);
	
	float f = 1.0; // Focal distance
	float h = -1.0; // Height of plane
	
	// Intersect with plane at y=h
	// a is the factor that makes the direction vector
	// from the camera (origin) to the pixel point intersect
	// with a point in the plane at height h
	float a = h / uv.y;
	if(a > 0.0) {
	  vec3 plane_point = vec3(uv.x * a, uv.y * a, f * a);
	  plane_point.z += iTime; // Move forward
	  vec2 tex_index = plane_point.xz;
 	  fragColor = texture(iChannel0, tex_index);
	} else {
	  // not a useful intersection (behind origin)
      // hack: hand pick texture color
	  fragColor = vec4(0.63, 0.5, 0.45, 1.0);
	}
	
}