extends PanelContainer

var label_settings: LabelSettings = load("uid://gyk7v33e0s4l")

var current_hp: int
var stats: Array[int]

@onready var stat_values: VBoxContainer = $StatsPanelContents/StatsTable/StatValues

func load_stats(_current_hp, _stats) -> void:
	current_hp = _current_hp
	stats = _stats
	for i in range(Stats.Type.size()):
		if i == Stats.Type.MAX_HP:
			create_hp_display()
		else:
			create_label(str(stats[i]))

func create_hp_display() -> void:
	var hp_display: String = str(current_hp) + "/" + str(stats[Stats.Type.MAX_HP])
	create_label(hp_display)

func create_label(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.label_settings = label_settings
	stat_values.add_child(label)
