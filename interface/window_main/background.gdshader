shader_type canvas_item;

uniform float line_thickness : hint_range(0.0, 0.2) = 0.02;
uniform float grid_size = 10.0;
uniform float speed = 1.0;
uniform vec4 background_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 line_color : source_color = vec4(0.0, 1.0, 1.0, 1.0);

void fragment() {
    float x_distort = (UV.x - 0.5) / (UV.y + 0.2);
    vec2 distorted_uv = vec2(x_distort + 0.5, 1.0 / (UV.y + 0.1));

    distorted_uv.y -= TIME * speed;

    vec2 grid_uv = fract(distorted_uv * grid_size);
    float vertical_line = step(grid_uv.x, line_thickness);
    float horizontal_line = step(grid_uv.y, line_thickness);
    float grid_mask = max(vertical_line, horizontal_line);
    
    grid_mask *= smoothstep(0.1, 0.5, UV.y);

    COLOR = mix(background_color, line_color, grid_mask);
}