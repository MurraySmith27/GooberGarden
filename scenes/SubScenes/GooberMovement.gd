extends CharacterBody3D

var is_wandering = false
var is_walking = false
var is_rotating_right = false
var is_rotating_left = false

@export var rotation_speed = 14
@export var move_speed = 5

var random = RandomNumberGenerator.new()

var was_walking = false

var is_talking_to_player = false
var current_player_position = Vector3.ZERO;

func _ready():
	random.randomize()

func _physics_process(delta):
	if (!is_wandering && !is_talking_to_player):
		wander()
	
	if (is_rotating_right):
		$Armature.rotate(Vector3.UP, rotation_speed * delta)
		was_walking = false
		
	if (is_rotating_left):
		$Armature.rotate(Vector3.UP, -rotation_speed * delta)
		was_walking = false
	
	if(is_walking):
		var forward = -$Armature.get_global_transform().basis.z
		velocity = move_speed * forward
		if (!was_walking):
			if (velocity != Vector3.ZERO):
				look_at(get_global_transform().origin + velocity)
				was_walking = true
		move_and_slide()
		
	$AnimationTree.set("parameters/IdleToWalk/IdleToWalk/blend_amount", min(velocity.length(), 1))
	
	if is_talking_to_player:
		var dir = current_player_position - position;
		var current_angle = Vector3(0,0,1).signed_angle_to($Armature.get_global_transform().basis.z, Vector3(0,1,0))
		var angle = Vector3(0,0,1).signed_angle_to(Vector3(-dir.x, 0, -dir.z), Vector3(0, 1, 0))
		var lerped_angle = lerp_angle(current_angle, angle, rotation_speed * delta);
		$Armature.rotation = Vector3(0, lerped_angle, 0);
		
	
func wander():
	var rotate_time = random.randi_range(1, 3)
	var rotate_wait = random.randi_range(1, 4)
	var rotate_left_or_right = random.randi_range(1,2)
	var walk_wait = random.randi_range(1, 5)
	var walk_time = random.randi_range(1, 6)
	
	is_wandering = true
	
	var tree = get_tree()
	
	await tree.create_timer(walk_wait).timeout
	is_walking = true
	await tree.create_timer(walk_time).timeout
	is_walking = false
	await tree.create_timer(rotate_wait).timeout
	
	if (rotate_left_or_right == 1):
		is_rotating_right = true
		await tree.create_timer(rotate_time).timeout
		is_rotating_right = false
	elif (rotate_left_or_right == 2):
		is_rotating_left = true
		await tree.create_timer(rotate_time).timeout
		is_rotating_left = false
		
	is_wandering = false
	
func start_dialog(player_position):
	is_wandering = false;
	
	is_talking_to_player = true;
	current_player_position = position
	
func stop_dialog():
	is_talking_to_player = false;
	current_player_position = null;
	
	
	
