extends Resource
class_name Stats

signal hp_depleted
signal hp_changed

@export var level: int = 1

@export var base_max_hp: int = 20
@export var base_attack: int = 5
@export var base_defense: int = 5
@export var base_speed: int = 3

@export var current_hp: int = 0: set = set_current_hp

@export var stat_curve: Curve = preload("uid://d0ie7apkpv6n")

var current_max_hp: int
var current_attack: int
var current_defense: int
var current_speed: int

func _init() -> void:
	resource_local_to_scene = true

func _setup_local_to_scene() -> void:
	calculate_stats()
	if current_hp == 0:
		current_hp = base_max_hp
	
func calculate_stats() -> void:
	var stat_curve_multiplyer: float = stat_curve.sample(float(level))
	current_max_hp = int(base_max_hp * stat_curve_multiplyer)
	current_attack = int(base_attack * stat_curve_multiplyer)
	current_defense = int(base_defense * stat_curve_multiplyer)
	current_speed = int(base_speed * stat_curve_multiplyer)

func _to_string() -> String:
	var stat_list: String = ""
	for prop in get_script().get_script_property_list():
		var stat_name: String = prop.name
		stat_list += str(stat_name) + ": " + str(get(stat_name)) + "\n"
	return stat_list

func set_current_hp(new_hp: int) -> void:
	current_hp = new_hp
	if current_hp <= 0:
		hp_depleted.emit()
	hp_changed.emit(current_hp, current_max_hp)
