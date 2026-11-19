extends PanelContainer

func load_charms(charms: Array[Charm]):
	for charm in charms:
		var charm_panel: PanelContainer = load("uid://bwicy4t8cpw1t").instantiate()
		charm_panel.load_charm(charm)
		var charms_list: VBoxContainer = $CharmsPanelContents/CharmsScrollableArea/CharmsList
		charms_list.add_child(charm_panel)
