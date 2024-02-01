const vec3 camera_location = vec3(0.0, 0.0, -1.8);
vec3 light_direction = normalize(vec3(-0.2, 0.5, -1.0));
vec3 ambient_light = vec3(0.3, 0.3, 0.35);
float zoom = 1.5;
float perspective = 0.45;
float march_step = 1.0;
float minimum_distance = 0.001;
float camera_distance = length(camera_location);
float shadow_bias = 0.1;
float shadow_penumbra_factor = 256.0;

float cube(vec3 v, vec3 size, vec3 position) {
	vec3 distance = abs(v + position) - size;
	vec3 distance_clamped = max(distance, 0.0);
	return length(distance_clamped) - 0.05;
}

float sphere(vec3 v, float radius, vec3 position) {
	return length(v + position) - radius;
}

float scene(vec3 v) {
	float distance = camera_distance * 100.0;
	distance = min(distance, cube(v, vec3(2.0, 2.0, 0.3), vec3(0.0, 0.0, -1.0)));
	
	distance = min(distance, cube(v, vec3(0.35, 0.35, 0.35), vec3(0.0, 0.0, 0.7)));
	
	distance = max(distance, -sphere(v, 0.50, vec3(0.0, 0.0, 0.7)));
	
	distance = min(distance, sphere(v, 0.25, vec3(sin(iTime) * 0.6, 0.0, 0.7)));
	distance = min(distance, sphere(v, 0.25, vec3(0.0, cos(iTime) * 0.6, 0.7)));
	
	return distance;
}


mat3 axis_x_rotation_matrix(float angle) {
	return mat3(1.0, 0.0, 0.0,
				0.0, cos(angle), -sin(angle),
				0.0, sin(angle), cos(angle));
}

mat3 axis_y_rotation_matrix(float angle) {
	return mat3(cos(angle), 0.0, sin(angle),
				0.0,        1.0, 0.0,
				-sin(angle), 0.0, cos(angle));
}

vec3 raymarch(vec3 ray, vec3 view_direction, float cube_size) {
	
	vec3 output_color = vec3(0.0, 0.0, 0.0);
	float distance = minimum_distance * 2.0;
	
	for (int iteration = 0; iteration < 100; ++iteration) {
		distance = scene(ray);
		if (distance < minimum_distance) {
			break;
		}
		ray += view_direction * march_step * distance;
	}
	
	if (distance < minimum_distance) {
		vec3 epsilon = vec3(0.01,0.0,0.0);
		vec3 normal = normalize(vec3(
			scene(ray + epsilon.xyy) - scene(ray - epsilon.xyy),
			scene(ray + epsilon.yxy) - scene(ray - epsilon.yxy),
			scene(ray + epsilon.yyx) - scene(ray - epsilon.yyx)
		));
		
		float shadow_value = 1.0;
		
		ray += light_direction * march_step * shadow_bias;
		for (int iteration = 0; iteration < 100; ++iteration) {
			distance = scene(ray);
			if (distance < minimum_distance) {
				shadow_value = 0.0;
				break;
			}
			shadow_value = min( shadow_value, shadow_penumbra_factor * distance / float(iteration) );
			ray += light_direction * march_step * distance;
		}
		
		float light_contribution = max(0.0, dot(normal, light_direction)) * shadow_value;
		float specular_light_contribution = pow(max(0.0, dot(reflect(view_direction, normal), light_direction)), 64.0) * shadow_value;
		output_color = vec3(1.0, 1.0, 1.0) * light_contribution + ambient_light + specular_light_contribution;
	}
	
	return output_color;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec4 bass_sound_sample = texture(iChannel0, vec2(0.1,0.1));
	vec4 mid_sound_sample = texture(iChannel0, vec2(0.5,0.1));
	vec4 treble_sound_sample = texture(iChannel0, vec2(0.9,0.1));
	vec2 screen_space_coords = (fragCoord.xy / iResolution.xy) * 2.0 - 1.0;
	float aspect_ratio = iResolution.x / iResolution.y;
	screen_space_coords.x *= aspect_ratio;
	screen_space_coords.xy /= zoom;
	
	vec2 screen_space_mouse_coords = (iMouse.xy / iResolution.xy) * 2.0 - 1.0;
	screen_space_mouse_coords.x *= aspect_ratio;
	screen_space_mouse_coords.y = -screen_space_mouse_coords.y;

	vec3 ray = vec3(screen_space_coords.xy, 0.0) + camera_location;
	mat3 rotation = axis_y_rotation_matrix(screen_space_mouse_coords.x);
	rotation *= axis_x_rotation_matrix(screen_space_mouse_coords.y);
	vec3 view_direction = normalize(vec3(screen_space_coords.x * perspective, screen_space_coords.y * perspective, 1.0));
	light_direction *= rotation;
	ray *= rotation;
	view_direction *= rotation;
	
	vec3 light_contribution = raymarch(ray, view_direction, 0.50);
	vec3 output_color = vec3(bass_sound_sample.r, mid_sound_sample.r, treble_sound_sample.r) * light_contribution;
    fragColor = vec4(output_color, 1.0);
}