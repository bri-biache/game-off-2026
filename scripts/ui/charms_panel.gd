extends PanelContainer

signal equipped_charm_pressed(charm: Charm)

func load_charms(charms: Array[Charm]):
	for charm in charms:
		var charm_panel: PanelContainer = load("uid://bwicy4t8cpw1t").instantiate()
		charm_panel.load_charm(charm)
		charm_panel.charm_pressed.connect(on_charm_press)
		var charms_list: VBoxContainer = %CharmsList
		charms_list.add_child(charm_panel)

func on_charm_press(charm: Charm) -> void:
	equipped_charm_pressed.emit(charm)
