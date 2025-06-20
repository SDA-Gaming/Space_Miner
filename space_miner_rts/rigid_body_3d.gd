extends RigidBody3D

var resource



func  _ready() -> void:
	
	var random_resource = randi_range(1,5)
	match random_resource:
		1:
			resource = "Iron"
		2:
			resource = "Platinum"
		3:
			resource = "Nickel"
		4:
			resource = "Gold"
		5:
			resource = "Silicon"
	
	


func Highlight(v):
	
	if v == true:
		$Highlight.visible = true
		print(global_transform.origin)
	else:
		$Highlight.visible = false
