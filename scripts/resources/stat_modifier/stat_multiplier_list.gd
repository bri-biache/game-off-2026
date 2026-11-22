class_name StatMultiplierList
extends Resource

var list: Array[StatMultiplier]
var total: float = 1.0

func add(new_multiplier: StatMultiplier) -> void:
	list.append(new_multiplier)
	calculate()

func calculate() -> float:
	var new_total: int = 0
	for multiplier in list:
		new_total += multiplier.value
	total = new_total
	return new_total
