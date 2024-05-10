shader_type spatial;
render_mode world_vertex_coords;

void vertex() {
	
	float bendAmount = 1.0;
	
	// Called for every vertex the material is visible on.
	vec4 cameraPos = INV_VIEW_MATRIX * vec4(0,0,0,1);
	
	vec3 result = vec3(
		cameraPos.r / cameraPos.a, 
		cameraPos.g / cameraPos.a, 
		cameraPos.b / cameraPos.a) - VERTEX;
	
	float y = pow(result.g, 2) * -bendAmount;
	
	
	VERTEX = vec3(VERTEX.x, y, VERTEX.z);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
