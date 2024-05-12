extends Control

signal advance_dialog_signal;
var current_text_string = ""
var done_text = false;
var text_position = 0;

var text_box;

@export var time_per_letter = 0.05;

var time_since_last_letter_add = 0;

func _ready():
	text_box = get_node("DialogBoxRoot/Panel/DialogText");
	

func _process(delta):
	
	if !done_text:
		time_since_last_letter_add += delta
		if (time_since_last_letter_add > time_per_letter):
			text_box.text = current_text_string.substr(0, text_position);
			text_position += 1;
			if (text_box.text.length() == current_text_string.length()):
				done_text = true;
			time_since_last_letter_add = 0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		advance_dialog_signal.emit();

func display_dialog_list(dialog_list, speaker_name, callback):
	
	get_node("DialogBoxRoot/SpeakerTitlePanel/SpeakerTitle").text = speaker_name;
	
	$AnimationPlayer.play("SlideIn")
	
	for i in range(dialog_list.size()):
		current_text_string = dialog_list[i]
		done_text = false;
		text_position = 0;
		text_box.text = "";
		await advance_dialog_signal;
		
	$AnimationPlayer.play("SlideOut")
	
	callback.call();
		
	
