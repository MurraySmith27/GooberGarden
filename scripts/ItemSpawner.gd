extends Node

@export var noise_threshold = 0.9f;

func ready():
	var texture = NoiseTexture2D.new()
	texture.noise = FastNoiseLite.new()
	await texture.changed
	var image = texture.get_image();
	var noise = image.get_data();
	
