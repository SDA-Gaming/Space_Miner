extends RigidBody3D


var Target
var top_speed = 2.0
var speed = 0
var acceleration = 0.2

var t = 0.0
var Station
var on_the_job = false



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
		#$Target_look.rotation.y = lerp_angle($Target_look.rotation_degrees.y, atan2(Target.global_transform.origin.x, Target.global_transform.origin.z) ,AtanV) 
		#print(str("Rotation ") + str($Target_look.rotation.y) + str(" rot + rot to Target: ") + str(lerp_angle($Target_look.rotation_degrees.y, atan2(Target.global_transform.origin.x, Target.global_transform.origin.z) ,AtanV)) + str(" rotation to target: ") + str($Target_look.rotation_degrees.y, atan2(Target.global_transform.origin.x, Target.global_transform.origin.z)) )
		#print(str(Target.global_transform.origin.x) + str(" ") + str(Target.global_transform.origin.y))
		
		
		
		#aligning with target lock
		if rotation_degrees.y != $Target_look.rotation_degrees.y:
			
			var _target_angle = $Target_look.rotation_degrees.y
			rotation.y = lerp_angle(rotation.y, _target_angle, delta * _rotation_amount)
			#print(lerp_angle(rotation.y, _target_angle, delta * _rotation_amount))
			
		
		#speed control
		if speed < top_speed:
			speed += (0.2 * delta)
		print(speed)
		apply_force(Vector3(speed,0.0,0.0))
		#apply_central_force(Vector3(speed,0.0,0.0))
		
	
	
