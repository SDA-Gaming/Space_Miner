extends CharacterBody3D

const RAY_LENGTH = 50
var SPEED = 3.0

var zoom_in_limit = 5
var zoom_out_limit = 40
var in_control = true


var Target = null

var Target_list = []

func _ready() -> void:
	Target_list.resize(100)
	
	



func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Scroll_up"):
		if transform.origin.y > zoom_in_limit:
			transform.origin.y -= .2
	if event.is_action_pressed("Scroll_down"):
		if transform.origin.y < zoom_out_limit:
			transform.origin.y += .2
	
	
	if event.is_action_pressed("Left_click_action"):
		if Target != null:
			print(Target)
			
			Target.Highlight(true)
			if Target_list.find(Target) == -1:
				Target_list[Target_list.find(null)] = Target
			print(Target_list)
	
	if event.is_action_pressed("Right_click_action"):
		
		for g in Target_list.find(null):
			Target_list[g].Highlight(false)
		
		Target_list.fill(null)
		
		
		
	
	if event.is_action_pressed("Space_bar"):
		
		OverlordScript.Players_station.Job_posted(Target_list[0])
		
		
	
	
	
	$Label.text = str(transform.origin.y)
	

func _physics_process(delta):
	
	
	#ray cast
	var space_state = get_world_3d().direct_space_state
	var cam = $Camera3D
	var mousepos = get_viewport().get_mouse_position()
	
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	
	
	if result.size() > 0:
		Target = result.collider
		
	
	
	
	if in_control == true:
		var input_dir = Input.get_vector("Move_left", "Move_right", "Move_up", "Move_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	
	
	
	move_and_slide()
