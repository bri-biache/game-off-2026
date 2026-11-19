extends PanelContainer

var subtitle_label_setttings: LabelSettings = load("uid://tivvtnxhftbw")
var simple_label_settings: LabelSettings = load("uid://gyk7v33e0s4l")

#@onready var stat_mods_container: FlowContainer = $CharmInfo/StatModsContainer

func load_charm(charm: Charm) -> void:
	create_charm_name_display(charm.name)
	create_stat_mods_display(charm.stat_mods)
	create_charm_description_display(charm.description)

func create_charm_name_display(charm_name: String) -> void:
	var label = $CharmInfo/CharmName
	label.text = charm_name

func create_stat_mods_display(stat_mods: Array[StatModifier]) -> void:
	for mod in stat_mods:
		var stat_mod_panel: PanelContainer = load("uid://b1kexmc56ie5v").instantiate()
		stat_mod_panel.set_modifier(mod)
		var stat_mods_container: FlowContainer = $CharmInfo/StatModsContainer
		stat_mods_container.add_child(stat_mod_panel)

func create_charm_description_display(charm_description: String) -> void:
	var label = $CharmInfo/CharmDescription
	label.text = charm_description
