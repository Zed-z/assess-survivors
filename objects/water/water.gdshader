shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D NOISE_TEXTURE : repeat_enable; 

uniform float shine_intensity = 0.125;
uniform float speed = 0.8;
uniform float shine_speed = 0.8;
uniform float freq_x = 10.0;
uniform float freq_y = 10.0;
uniform float scale = 1.0;

void fragment() {
	vec2 uv = UV * scale;
    float init_alpha = texture(TEXTURE, uv).a;
    vec4 bg_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    vec3 water_tint = vec3(0.1, 1.0, 1.2);
    bg_color.rgb = mix(bg_color.rgb, water_tint, 0.55);
	vec2 offset = uv + vec2(sin(TIME+uv.y)*0.1*speed,cos(TIME+uv.x)*0.1*speed);
    float noise_value = texture(NOISE_TEXTURE, offset).r;
    float shine = sin(shine_speed * TIME * 3.0 + noise_value * 10.0) * 0.5 + 0.5;

    bg_color.rgb += shine * shine_intensity;
    bg_color.a *= init_alpha;
    COLOR = bg_color;
}
