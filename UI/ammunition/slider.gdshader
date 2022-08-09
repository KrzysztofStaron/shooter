shader_type canvas_item;

uniform float persent : hint_range(0, 100);

void fragment() {
	vec4 text = texture(TEXTURE, UV);
	
	if (1.0 - persent/100.0 < UV.y) {
		COLOR = text;
	} else {
		COLOR = vec4(0);
	}
}
