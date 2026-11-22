extends PanelContainer

var label_settings: LabelSettings = load("uid://gyk7v33e0s4l")

@onready var stat_values: VBoxContainer = %StatValues

func load_stats(current_hp, stats) -> void:
	for i in range(Stats.Type.size()):
		if i == Stats.Type.MAX_HP:
			create_hp_display(current_hp, stats)
		else:
			create_label(str(stats[i]))

func clear() -> void:
	for child_node in %StatValues.get_children():
		child_node.queue_free()

func create_hp_display(hp: int, stats: Array[int]) -> void:
	var hp_display: String = str(hp) + "/" + str(stats[Stats.Type.MAX_HP])
	create_label(hp_display)

func create_label(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.label_settings = label_settings
	stat_values.add_child(label)
