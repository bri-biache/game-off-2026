class_name StatAddend
extends StatMod

@export var value: int = 0

func _init(stat_type: Stats.Type = Stats.Type.MAX_HP, addend_value: int = 0) -> void:
	self.modified_stat = stat_type
	self.value = addend_value
