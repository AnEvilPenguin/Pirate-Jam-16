shader_type canvas_item;

/** Color used towards 0% complete */
uniform vec3 bar_color0 : source_color = vec3(1.0, 0.5, 0.0);
/** Color used towards 100% complete */
uniform vec3 bar_color1 : source_color = vec3(0.0, 1.0, 0.5);
/** How complete the circle should be.
0.0 = 0% 
1.0 = 100% */
uniform float percent_complete : hint_range(0.0, 1.0);

vec3 rgb2hsv(in vec3 c) {
	vec4 K = vec4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
	
	vec4 p = mix(
		vec4(c.bg, K.wz),
		vec4(c.gb, K.xy), 
		step(c.b, c.g)
	);
	
	vec4 q = mix(
		vec4(p.xyw, c.r),
		vec4(c.r, p.yzx),
		step(p.x, c.r)
	);
	
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	
	return vec3(
		abs(q.z + (q.w-q.y) / (6.0*d + e)),
		d / (q.x+e),
		q.x
	);
}

vec3 hsv2rgb(in vec3 c) {
	vec3 rgb = clamp(
		abs(mod(c.x*6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0)-1.0,
		0.0,
		1.0
	);
	
	rgb = rgb*rgb*(3.0-2.0*rgb);
	
	return c.z * mix(vec3(1.0), rgb, c.y);
}

void fragment() {

	vec3 h0 = rgb2hsv(bar_color0);
	vec3 h1 = rgb2hsv(bar_color1);
	
	vec3 hueMix = mix(h0, h1, vec3(percent_complete, 0.0, 0.0));
	
	vec3 color = hsv2rgb(hueMix);

	float alpha = 1.0;
	
	if (UV.x > percent_complete) {
		alpha = 0.0;
	}
	
	COLOR = vec4(color, alpha);
}

