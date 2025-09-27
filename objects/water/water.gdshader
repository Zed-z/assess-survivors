shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D NOISE_TEXTURE : repeat_enable;

uniform float shine_intensity = 0.2;
uniform float speed = 0.25;
uniform float shine_speed = 0.25;
uniform float scale = 1.0;

void fragment() {
	vec2 uv = UV * scale;

    float init_alpha = texture(TEXTURE, uv).a;

    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);

    vec3 water_tint = vec3(0.1, 1.0, 1.2);
    color.rgb = mix(color.rgb, water_tint, 0.55);

	vec2 water_uv = uv + vec2(
		sin(TIME + uv.y) * 0.1 * speed,
		cos(TIME + uv.x) * 0.1 * speed);

	vec2 water_uv_2 = uv / 2.0 + vec2(
		cos(TIME + uv.x) * 0.25 * speed,
		sin(TIME + uv.y) * 0.25 * speed);

    float noise_value = texture(NOISE_TEXTURE, water_uv).r * 0.75;
    noise_value += texture(NOISE_TEXTURE, water_uv_2).r * 0.25;

	float a = sin(TIME * shine_speed + (uv.x * sin(TIME * shine_speed) + uv.y * cos(TIME * shine_speed)) * noise_value * scale / 20.0);
    float shine = noise_value * (5.0 + ((a + 1.0) / 2.0) * 5.0);

    color.rgb -= shine * shine_intensity;
    color.a *= init_alpha;
    COLOR = color;
}
