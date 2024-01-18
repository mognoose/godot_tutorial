shader_type spatial;

uniform sampler2D heightmap;
uniform float height_ratio = 1.0;

void vertex() {
	VERTEX.y += 0.1
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
