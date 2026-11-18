class_name Weapon
extends Equipment

var attack_modifier: StatAddend = StatAddend.new(Stats.Type.ATTACK, 3)

@export var attack: int = 0

func _setup_local_to_scene() -> void:
	attack_modifier = StatAddend.new(Stats.Type.ATTACK, attack)
