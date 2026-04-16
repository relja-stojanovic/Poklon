shader_type canvas_item;

uniform vec4 color_1 : source_color = vec4(0.561, 0.004, 0.467, 1.0);
uniform vec4 color_2 : source_color = vec4(0.212, 0.004, 0.522, 1.0);
uniform float speed = 1.0;
uniform float wave_scale = 400.0;

void fragment() {
    float t = (FRAGCOORD.x + FRAGCOORD.y) / wave_scale + TIME * speed;
    float wave = (sin(t) + 1.0) * 0.5;
    vec4 gradient = mix(color_1, color_2, wave);
    COLOR = gradient;
}