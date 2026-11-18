class_name Item
extends Resource

@export var name: String = ""
@export var description: String = ""

func _init() -> void:
	resource_local_to_scene = true
