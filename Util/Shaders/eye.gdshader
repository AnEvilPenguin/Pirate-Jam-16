shader_type canvas_item;

uniform vec2 resolution;
uniform vec2 pupil_position;

uniform float pupil_size = 0.5;

void fragment() {
	vec2 position = pupil_position.xy / resolution.xy;
	vec4 color = texture(TEXTURE, UV);
	
	if (distance(UV, position) < pupil_size) {
		COLOR = vec4(vec3(0.0), color.a);
	} else {
		COLOR = color;
	}
}
