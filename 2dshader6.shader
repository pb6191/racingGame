// standalone border dbl

shader_type canvas_item;

uniform float line_thickness : hint_range(0, 20) = 40.0;    // thickness of the line
uniform float sin_frequency : hint_range(0.1, 2.0) = 1.9;  // frequency of the rainbow
uniform float sin_offset : hint_range(0.0, 360.0) = 0.0;   // offset of the rainbow, useful to differentiate objects using the same shader
uniform float light_offset : hint_range(0.0, 1.0) = 0;   // this offsets all color channels; if set to 0 only red green and blue colors will be shown.
uniform float line_thickness2 : hint_range(0, 20) = 30.0;
uniform float line_thickness3 : hint_range(0, 20) = 15.0;

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	
	float outline = texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	outline = min(outline, 1.0);
	
//	vec4 animated_line_color = vec4(light_offset + sin(2.0*3.14*sin_frequency*TIME),
//							   light_offset + sin(2.0*3.14*sin_frequency*TIME + radians(120.0)),
//							   light_offset + sin(2.0*3.14*sin_frequency*TIME + radians(240.0)),
//							   1.0);

	vec4 animated_line_color = vec4(0, 0, 0, 1);

    vec2 size2 = TEXTURE_PIXEL_SIZE * line_thickness2;
	
	float outline2 = texture(TEXTURE, UV + vec2(-size2.x, size2.y)).a;
	outline2 += texture(TEXTURE, UV + vec2(size2.x, size2.y)).a;
	outline2 += texture(TEXTURE, UV + vec2(-size2.x, -size2.y)).a;
	outline2 += texture(TEXTURE, UV + vec2(size2.x, -size2.y)).a;

    vec2 size3 = TEXTURE_PIXEL_SIZE * line_thickness3;
	
	float outline3 = texture(TEXTURE, UV + vec2(-size3.x, size3.y)).a;
	outline3 += texture(TEXTURE, UV + vec2(size3.x, size3.y)).a;
	outline3 += texture(TEXTURE, UV + vec2(-size3.x, -size3.y)).a;
	outline3 += texture(TEXTURE, UV + vec2(size3.x, -size3.y)).a;
    outline3 = min(outline3, 1.0);

	vec4 color = texture(TEXTURE, UV);
	COLOR = mix(color, animated_line_color, outline - outline2 + outline3 - color.a);
}