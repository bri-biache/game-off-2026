class_name Stats
extends Resource

signal hp_depleted
signal hp_changed

const NUMBER_OF_STATS: int = 4
enum Type {MAX_HP, ATTACK, DEFENSE, SPEED}

@export var level: int = 1

@export var base_max_hp: int = 20
@export var base_attack: int = 5
@export var base_defense: int = 5
@export var base_speed: int = 3

@export var stat_curve: Curve = preload("uid://d0ie7apkpv6n")

@export var current_hp: int = 0: set = _set_current_hp

var base_stats: Array[int]
var current_stats: Array[int]
#var stat_modifiers: Array[StatModifiers]
var stat_addends: Array[StatAddendList]
var stat_multipliers: Array[StatMultiplierList]

#var stat_addend_totals: Array[int]
#var stat_multiplier_totals: Array[float]

func _init() -> void:
	resource_local_to_scene = true
	current_stats.resize(NUMBER_OF_STATS)
	#stat_modifiers.resize(NUMBER_OF_STATS)
	stat_addends.resize(NUMBER_OF_STATS)
	#stat_addends.fill(StatAddendList.new())
	stat_multipliers.resize(NUMBER_OF_STATS)
	#stat_multipliers.fill(StatMultiplierList.new())
	for i in NUMBER_OF_STATS:
		stat_addends[i] = StatAddendList.new()
		stat_multipliers[i] = StatMultiplierList.new()
	#stat_addend_totals.resize(NUMBER_OF_STATS)
	#stat_addend_totals.fill(0)
	#stat_multiplier_totals.resize(NUMBER_OF_STATS)
	#stat_addend_totals.fill(1.0)
	#for i in range(NUMBER_OF_STATS):
	#	stat_modifiers[i] = StatModifiers.new()

func _setup_local_to_scene() -> void:
	base_stats = [base_max_hp, base_attack, base_defense, base_speed]
	calculate_stats()
	if current_hp == 0:
		current_hp = base_max_hp
	
func calculate_stats() -> void:
	var stat_curve_multiplyer: float = stat_curve.sample(float(level))
	for i in base_stats.size():
		var curved_stat: int = int(base_stats[i] * stat_curve_multiplyer)
		current_stats[i] = int(curved_stat + stat_addends[i].total)
		#current_stats[i] = int((curved_stat + stat_modifiers[i].addend) * stat_modifiers[i].multiplier)

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
