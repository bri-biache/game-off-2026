extends PanelContainer

signal charm_pressed(charm: Charm)

var charm: Charm

func _ready() -> void:
	%Button.pressed.connect(on_press)

func load_charm(_charm: Charm) -> void:
	charm = _charm
	create_charm_name_display(_charm.name)
	create_stat_mods_display(_charm.stat_mods)
	create_charm_description_display(_charm.description)

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

func on_press() -> void:
	charm_pressed.emit(charm)
