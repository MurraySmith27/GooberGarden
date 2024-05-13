extends Node

var full_item_registry;

var current_inventory = {};

var player_root_node = get_parent();

func _ready():
	var file = "res://json/item_registry.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	full_item_registry = JSON.parse_string(json_as_text)["items"];
	for item in full_item_registry:
		current_inventory[item] = 0;

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		#first check if we're interacting with goober
		if !player_root_node.interacting:
			#pickup nearby item
			var items = get_tree().get_nodes_in_group("Item");
			for item in items:
				var item_name = item.item_name;
				current_inventory[item_name] = current_inventory[item_name] + 1;
				
