extends Node3D

var Mining_ships = 0
var base_mine_ship = load("res://mining_ship.tscn")
var Mining_ship_list = []



func _ready() -> void:
	
	
	OverlordScript.Players_station = self
	
	
	Mining_ship_list.resize(50)
	
	
	
	var MS = base_mine_ship.instantiate()
	add_child(MS)
	MS.Station = self
	Mining_ship_list[Mining_ship_list.find(null)] = MS

func Job_posted(JP):
	
	for JL in Mining_ship_list.size():
		if Mining_ship_list[JL] != null:
			Mining_ship_list[JL].Job_sent(JP)
	
	
	
	








func Highlight(v):
	
	if v == true:
		$Highlight.visible = true
	else:
		$Highlight.visible = false
	
	
