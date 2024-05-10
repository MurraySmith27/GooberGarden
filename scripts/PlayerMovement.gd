extends CharacterBody3D

@export var move_speed = 14.0
@export var acceleration = 5.0
@export var rotation_speed = 1.0;

var fall_acceleration = ProjectSettings.get_setting("physics/3d/default_gravity")

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	var dir = Vector3(input.x, 0, input.y)
	
	if dir != Vector3.ZERO:
		dir = dir.normalized()
		var scale = $Armature.scale
		$Armature.basis = Basis.looking_at(Vector3(dir.x,0,dir.z))
		$Armature.rotation = lerp($Armature.rotation, Vector3(dir.x, 0, dir.z), rotation_speed * delta)
		$Armature.scale = scale
		
	velocity = lerp(velocity, dir * move_speed, acceleration * delta)
	
	var vl = velocity * $Armature.transform.basis
	$AnimationTree.set("parameters/IdleToRun/blend_position", Vector2(vl.x, -vl.z).normalized())
	
	if not is_on_floor():
		velocity.y = velocity.y - (fall_acceleration * delta)

	move_and_slide()	
