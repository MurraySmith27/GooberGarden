extends CharacterBody3D

@export var move_speed = 14.0
@export var acceleration = 5.0
@export var rotation_speed = 1.0;

@export var goober_interact_radius = 5.0;

var interacting = false;

var current_interacting_goober;

var fall_acceleration = ProjectSettings.get_setting("physics/3d/default_gravity")

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if !interacting:
		if Input.is_action_just_pressed("interact"):
			#check if there are any nearby goobers
			var goobers = get_tree().get_nodes_in_group("Goober");
			for goober in goobers:
				if goober.position.distance_to(position) < goober_interact_radius:
					#interact with this goober
					current_interacting_goober = goober;
					interacting = true;
					var callback = Callable(self, "dialog_finished");
					var goober_state = goober.get_node("GooberState")
					$DialogBox.display_dialog_list(goober_state.get_dialog(), goober_state.get_goober_name(), callback);
					goober.start_dialog(position);
					$AnimationTree.set("parameters/IdleToRun/IdleOrRun/blend_amount", 0);
					break;
	
	if !interacting:
		var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		
		var dir = Vector3(input.x, 0, input.y)
		
		if dir != Vector3.ZERO:
			dir = dir.normalized()
			var scale = $Armature.scale
			#$Armature.basis = Basis.looking_at(Vector3(dir.x,0,dir.z))
			var current_angle = Vector3(0,0,1).signed_angle_to($Armature.get_global_transform().basis.z, Vector3(0,1,0))
			var angle = Vector3(0,0,1).signed_angle_to(Vector3(-dir.x, 0, -dir.z), Vector3(0, 1, 0))
			var lerped_angle = lerp_angle(current_angle, angle, rotation_speed * delta);
			
			$Armature.rotation = Vector3(0, lerped_angle, 0)
			$Armature.scale = scale
			
		velocity = lerp(velocity, dir * move_speed, acceleration * delta)
		
		var vl = velocity * $Armature.transform.basis
		$AnimationTree.set("parameters/IdleToRun/IdleOrRun/blend_amount", min(Vector2(vl.x, -vl.z).length(), 1))
		
		if not is_on_floor():
			velocity.y = velocity.y - (fall_acceleration * delta)

		move_and_slide()	

func dialog_finished():
	interacting = false;
	current_winteracting_goober.stop_dialog();
	current_interacting_goober = null;
	
