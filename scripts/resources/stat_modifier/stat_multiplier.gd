class_name StatMultiplier
extends StatModifier

var stat_type: Stats.Type

func _init(_stat_type: Stats.Type = Stats.Type.MAX_HP, multiplier_value: int = 0) -> void:
	self.modified_stat = _stat_type
	self.value = multiplier_value

func _to_string() -> String:
	if value < 0:
		return str(value) + " " + Stats.TYPE_NAMES[modified_stat]
	return "+" + str(value) + "% " + Stats.TYPE_NAMES[modified_stat]
