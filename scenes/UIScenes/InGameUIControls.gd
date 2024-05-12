extends Control


var tweening = false

var initial_button_pos = Vector2.ZERO;

var up_tween;
var down_tween;

@export var button_float_amount = 10;
@export var button_float_duration = 0.5;

func _ready():
	initial_button_pos = $Button.position;
	get_node("3DUI/Goober/AnimationPlayer").play("Idle")

func _on_button_pressed():
	$AnimationPlayer.play("SlideOutTransition")

func down():
	if tweening:
		down_tween = create_tween()
		down_tween.tween_property($Button, "position", Vector2(0, -button_float_amount), button_float_duration).as_relative().set_trans(Tween.TRANS_SINE);
		down_tween.tween_callback(up);

func up():
	if tweening:
		up_tween = create_tween()
		up_tween.tween_property($Button, "position", Vector2(0, button_float_amount), button_float_duration).as_relative().set_trans(Tween.TRANS_SINE);
		up_tween.tween_callback(down);

func _on_button_mouse_entered():
	tweening = true;
	up();
	
func _on_button_mouse_exited():
	tweening = false;
	if (down_tween != null):
		down_tween.kill();
	if (up_tween != null):
		up_tween.kill();
	$Button.position = initial_button_pos;
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "SlideOutTransition":
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
