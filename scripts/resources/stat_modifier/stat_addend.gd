class_name StatAddend
extends StatModifier


func _init(stat_type: Stats.Type = Stats.Type.MAX_HP, addend_value: int = 0) -> void:
	self.modified_stat = stat_type
	self.value = addend_value

func _to_string() -> String:
	if value < 0:
		return str(value) + " " + Stats.TYPE_NAMES[modified_stat]
	return "+" + str(value) + " " + Stats.TYPE_NAMES[modified_stat]
