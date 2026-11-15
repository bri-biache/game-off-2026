class_name StatAddendList
extends Resource

var list: Array[StatAddend]
var total: int = 0

func add(new_addend: StatAddend) -> void:
	list.append(new_addend)
	calculate()

func calculate() -> int:
	var new_total: int = 0
	for addend in list:
		new_total += addend.value
	total = new_total
	return new_total
