shader_type canvas_item;

uniform sampler2D noise: repeat_enable;
uniform vec4 color: source_color = vec4(1.0, 1.0, 0.0, 0.25);

uniform vec3 grass_mask: source_color = vec3(0.0, 1.0, 0.0);
uniform float grass_threshold = 0.5;
uniform float grass_threshold_margin = 0.05;

uniform float noise_scale_1 = 1000;
uniform float noise_Scale_2 = 1000;

varying vec2 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec4 front = texture(TEXTURE, UV);
	vec4 noise_tex_1 = texture(noise, world_position / noise_scale_1);
	vec4 noise_tex_2 = texture(noise, world_position / noise_Scale_2);
	float grassness = dot(front.xyz, grass_mask);

	//float is_grass = grassness >= grass_threshold ? 0.0 : 1.0;
	float is_grass = 1.0 - smoothstep(
		grass_threshold - grass_threshold_margin,
		grass_threshold + grass_threshold_margin,
		grassness);

	vec4 noise_tex = mix(noise_tex_1, noise_tex_2, 0.25);

	//COLOR = vec4(is_grass, is_grass, is_grass, COLOR.a);
	COLOR = mix(front, vec4(color.rgb, front.a), color.a * noise_tex.r * is_grass);
	//COLOR = noise_tex;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
