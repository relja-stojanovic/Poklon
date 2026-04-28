shader_type canvas_item;

uniform float stripe_count = 40.0;
uniform float effect = 0.0;
uniform float speed = 10;
uniform float stripe_thickness = 0.1;
uniform float alpha = 1.0;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	
	vec4 bottom_color = vec4(1.0 - tex.rgb, tex.a);
	float vertical_pos = (UV.y - REGION_RECT.y) / REGION_RECT.w;
	float transition = pow(vertical_pos, 2.0);
	vec4 final_color_swapped = mix(tex, bottom_color, transition);
	
	float time_scroll = TIME * speed;
	float stripe_logic = sin((vertical_pos + time_scroll) - ((vertical_pos * vertical_pos) * stripe_count));
	float stripe_mask = smoothstep(0.4, 0.9, vertical_pos);
	float stripe_active = step(stripe_thickness, stripe_logic);
	
	float target_alpha = tex.a * mix(1.0, (1.0 - stripe_mask), stripe_active);
	
	vec4 result = vec4(final_color_swapped.rgb, target_alpha*alpha);
	COLOR = mix(tex, result, effect*1.75);
}