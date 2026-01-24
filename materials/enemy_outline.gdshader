// https://godotshaders.com/shader/canvas-group-outline/
shader_type canvas_item;

uniform vec3 line_colour: source_color = vec3(1.0);
uniform int line_thickness: hint_range(0, 10) = 1;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

varying vec2 global_scale;
varying vec2 screen_scale;

void vertex() {
    float x = length(MODEL_MATRIX[0].xy);
    float y = length(MODEL_MATRIX[1].xy);
    global_scale = vec2(x, y);
    
    x = length(CANVAS_MATRIX[0].xy);
    y = length(CANVAS_MATRIX[1].xy);
    screen_scale = vec2(x, y);
}

void fragment() {
    vec2 size = SCREEN_PIXEL_SIZE * float(line_thickness) * global_scale * screen_scale;
    float line_alpha = 0.0;
    for (float i = -size.x; i <= size.x; i += SCREEN_PIXEL_SIZE.x) {
        for (float j = -size.y; j <= size.y; j += SCREEN_PIXEL_SIZE.y) {
            line_alpha += texture(screen_texture, SCREEN_UV + vec2(i, j)).a;
        }
    }
    vec4 colour = texture(screen_texture, SCREEN_UV);
    vec4 outline = vec4(line_colour, min(line_alpha, 1.0));
    COLOR *= mix(outline, colour, colour.a);
    
}
