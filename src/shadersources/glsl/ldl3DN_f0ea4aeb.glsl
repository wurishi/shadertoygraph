void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	fragColor = vec4(0.0);
	float time = radians(45.0) + cos(iTime * 12.0) / 40.0;
	float time1 = radians(45.0) + cos(iTime * 22.0) / 30.0;
	vec2 uv = fragCoord.xy / iResolution.xy * 2.0 - vec2(1.0, 1.0);
	if (uv.y < 0.0) {
		vec2 tex;
		vec2 rot = vec2(cos(time), sin(time));
		vec2 mat;
		mat.x = (uv.x * rot.x + (uv.y - 1.0) * rot.y);
		mat.y = ((uv.y - 1.0) * rot.x - uv.x * rot.y);
		tex.x = mat.x * time1 / uv.y + iTime * 2.0;
		tex.y = mat.y * time1 / uv.y + iTime * 2.0;
		fragColor = texture(iChannel0, tex * 2.0) * (-uv.y);
	}
}