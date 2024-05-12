extends Node

var dialog_dict;
var goober_name;

var random = RandomNumberGenerator.new()

func _ready():
	var file = "res://json/dialogue.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	dialog_dict = JSON.parse_string(json_as_text)

	goober_name = generate_name();

func generate_name():
	var prefix_options = ["BLA", "GO", "PRE"];
	var suffix_options = ["BLER", "GLEB", "PREEB"];
	
	return (prefix_options[random.randi_range(0, prefix_options.size()-1)] + 
	suffix_options[random.randi_range(0, suffix_options.size()-1)])


func get_dialog():
	return dialog_dict["default"]

func get_goober_name():
	return goober_name;
