class_name Stats
extends Resource

signal hp_depleted
signal hp_changed

enum Type {MAX_HP, ATTACK, DEFENSE, SPEED}
const TYPE_NAMES: Array[String] = ["HP", "ATK", "DEF", "SPD"]

@export var level: int = 1

@export var base_max_hp: int = 20
@export var base_attack: int = 5
@export var base_defense: int = 5
@export var base_speed: int = 3

@export var stat_curve: Curve = preload("uid://d0ie7apkpv6n")

@export var current_hp: int = -1: set = _set_current_hp

var base_stats: Array[int]
var current_stats: Array[int]
var stat_addends: Array[StatAddendList]
var stat_multipliers: Array[StatMultiplierList]

func _init() -> void:
	resource_local_to_scene = true
	fill_stat_modifier_arrays()

func fill_stat_modifier_arrays():
	current_stats.resize(Type.size())
	stat_addends.resize(Type.size())
	stat_multipliers.resize(Type.size())
	for i in Type.size():
		stat_addends[i] = StatAddendList.new()
		stat_multipliers[i] = StatMultiplierList.new()

func _setup_local_to_scene() -> void:
	base_stats = [base_max_hp, base_attack, base_defense, base_speed]
	calculate_stats()
	if current_hp == -1:
		current_hp = base_max_hp

func clear() -> void:
	stat_addends.clear()
	stat_multipliers.clear()
	fill_stat_modifier_arrays()
	
func calculate_stats() -> void:
	var stat_curve_multiplyer: float = stat_curve.sample(float(level))
	for i in base_stats.size():
		var curved_stat: int = int(base_stats[i] * stat_curve_multiplyer)
		current_stats[i] = int(curved_stat * (1 + (stat_multipliers[i].total/100))) + stat_addends[i].total

func _to_string() -> String:
	var stat_list: String = ""
	for prop in get_script().get_script_property_list():
		var stat_name: String = prop.name
		stat_list += str(stat_name) + ": " + str(get(stat_name)) + "\n"
	return stat_list

func _set_current_hp(new_hp: int) -> void:
	current_hp = new_hp
	if current_hp <= 0:
		hp_depleted.emit()
	hp_changed.emit(current_hp, current_stats[Type.MAX_HP])

func add_addend(stat_type: Type, new_addend: StatAddend) -> void:
	stat_addends[stat_type].add(new_addend)

func add_multiplier(stat_type: Type, new_multiplier: StatMultiplier) -> void:
	stat_multipliers[stat_type].add(new_multiplier)
