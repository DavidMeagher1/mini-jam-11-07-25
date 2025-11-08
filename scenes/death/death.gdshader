shader_type canvas_item;

uniform float speed = 0.3;
uniform float amplitude = 0.01;
uniform float frequency = 30.0;
uniform float alpha = 1.0;

void fragment() {
    vec2 uv = UV - vec2(0.5);
    float dist = length(uv);
    
    float ripple = sin(dist * frequency - TIME * speed) * amplitude;
    vec2 ripple_uv = UV + normalize(uv) * ripple;
    
    COLOR = texture(TEXTURE, ripple_uv);
	COLOR.a = COLOR.a * alpha;
}