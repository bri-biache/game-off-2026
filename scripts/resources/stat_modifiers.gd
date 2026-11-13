class_name StatModifiers
extends Resource

var addend_list: Array[int] = []
var multiplier_list: Array[float] = []

var addend: int = 0
var multiplier: float = 1.0

func combine_addends() -> int:
	var total_addend: int = 0
	for n in addend_list:
		total_addend += n
	addend = total_addend
	return total_addend

func combine_multipliers() -> float:
	var total_multipliers: float = 1.0
	for n in multiplier_list:
		total_multipliers += n
	multiplier = total_multipliers
	return total_multipliers

func reset_addends() -> void:
	addend_list = []

func reset_multipliers() -> void:
	multiplier_list = []

func add_addend(new_addend: int) -> void:
	addend_list.append(new_addend)
	combine_addends()

func add_multiplier(new_multiplier: float) -> void:
	multiplier_list.append(new_multiplier)
	combine_multipliers()
