extends Node

var is_running = false

func _ready():
	$Pivot/Gardener/AnimationPlayer.play("idle")

func _physics_process(delta):
	if get_parent().velocity.length() > 0 and !is_running:
		$AnimationPlayer.play("run")
		is_running = true
	elif get_parent().velocity.length() == 0 and is_running:
		$AnimationPlayer.play("idle")
		is_running = false
		
