extends RigidBody3D


var Target
var top_speed = 0.5
var speed = 0
var acceleration = 0.01

var t = 0.0
var Station
var on_the_job = false

var orbit_range = 3.0
var is_orbiting = false



func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Debug"):
		$Camera_POS/Camera3D.make_current()
		
	
	



func Job_sent(T):
	
	print("Job Got")
	
	
	if on_the_job == false:
		on_the_job = true
		Target = T
		print("Job accepted")
		print(Target)
	
	


func _physics_process(delta: float) -> void:
	
	
	const _rotation_amount = 1.0

	
	if Target != null and on_the_job == true:
		
		var AtanV = 1.9
		
		#angling the "target_look" tword the target
		$Target_look.look_at(Target.global_transform.origin,Vector3.MODEL_FRONT)
		
		
		
		#aligning with target lock
		if rotation_degrees.y != $Target_look.rotation_degrees.y:
			
			var _target_angle = $Target_look.rotation_degrees.y
			rotation.y = lerp_angle(rotation.y, _target_angle, delta * _rotation_amount)
			#print(lerp_angle(rotation.y, _target_angle, delta * _rotation_amount))
			
		
		#speed control
		if speed < top_speed:
			if speed + (acceleration * delta) <= top_speed:
				speed += (acceleration * delta)
		print(speed)
		
		#apply_central_force(Vector3(speed,0.0,0.0))
		
		
		# Check if close enough to orbit
		
		var distance = (Target.global_transform.origin - global_transform.origin).length()
		
		if distance < orbit_range:
			is_orbiting = true
		else:
			is_orbiting = false
		
		var orbit_speed = speed / 2
		
		if is_orbiting:
			rotate_around_point(Target.global_transform.origin, Vector3.UP, orbit_speed * delta)
		else:
			# Calculate direction vector
			var dir = Target.global_transform.origin - global_transform.origin
			dir.y = 0 #Make sure we're moving in the same plane as the astroid
			
			# Smoothly move towards target
			var smooth_speed = speed * 0.1 # adjust this value to control how quickly the ship reaches its target
			translate(dir.normalized() * smooth_speed)
			# Move towards target
			move_and_collide(dir.normalized() * speed)
		
		
		
	
	


func rotate_around_point(center: Vector3, axis: Vector3, delta: float) -> void:
	
	# Calculate the direction vector from the center to the current position
	
	var dir = global_transform.origin - center
	# Calculate distance from center point
	
	var distance = dir.length()
	
	# Calculate desired orbital period in seconds (adjust as needed)
	const _orbital_period = 2.0
	
	# Calculate angular velocity based on distance and desired orbital period
	
	var angular_velocity = 2 * PI / (_orbital_period * distance)
	# Rotate around the specified axis by the calculated angle per frame
	rotate(axis.normalized(), angular_velocity * delta)
	# Translate back to maintain position relative to the center point
	translate(dir)
