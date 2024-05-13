extends Node


var current_quest_items = [];
var is_quest_active = false;
var quest_goober_id;

func create_quest(required_items, goober_id):
	current_quest_items = required_items;
	quest_goober_id = goober_id;
	is_quest_active = true;
	
func complete_current_quest():
	current_quest_items = [];
	quest_goober_id = null;
	is_quest_active = false;
