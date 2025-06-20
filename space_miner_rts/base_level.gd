extends Node3D


var Load_astroid = load("res://astroid_obj.tscn")
var Astroid_number = 20
var astroid_limit = 20

func _ready() -> void:
	
	for i in Astroid_number:
		var b = Load_astroid.instantiate()
		add_child(b)
		
		b.transform.origin = Vector3(randf_range(astroid_limit * -1,astroid_limit),0,randf_range(astroid_limit * -1,astroid_limit))
		b.set_name(str("Astroid_") + str(i))
		
	
	
