shader_type spatial;
uniform sampler2D albedo_texture;

void vertex() {
	float bendAmount = .005;
	
	// Called for every vertex the material is visible on.
	vec3 cameraPos = CAMERA_POSITION_WORLD;
	vec4 worldSpacePos = (MODEL_MATRIX * vec4(VERTEX, 1));
	vec3 result = worldSpacePos.xyz - cameraPos;
	
	float y = pow(result.z, 2) * (-bendAmount);
	
	worldSpacePos.y += y;
	
	vec4 final = inverse(MODEL_MATRIX) * vec4(worldSpacePos.xyz, 1);
	//vec4 final = vec4(worldSpacePos.xyz, 1);
	VERTEX = final.xyz / final.w;
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	ALBEDO = texture(albedo_texture, UV).rgb;
	
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
