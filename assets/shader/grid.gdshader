shader_type canvas_item;

uniform float grid_size : hint_range(0.0, 100.0, 1.0) = 9.0;
uniform float line_thickness : hint_range(0.0, 1.0) = 0.1;
uniform vec4 color : source_color = vec4(0.008, 0.082, 0.149, 1.0);
uniform bool invert_grid = false;

const vec4 empty = vec4(0.0, 0.0, 0.0, 0.0);

void fragment() {
	vec2 grid_uv = fract(UV * grid_size + line_thickness * 0.5);
	
	float s_width = 0.01; 
	float line_x = smoothstep(line_thickness + s_width, line_thickness, grid_uv.x);
	float line_y = smoothstep(line_thickness + s_width, line_thickness, grid_uv.y);
	
	float grid_mask = max(line_x, line_y);
	vec4 base = invert_grid ? color : empty;
	vec4 target = invert_grid ? empty : color;
	COLOR = mix(base, target, grid_mask);
}