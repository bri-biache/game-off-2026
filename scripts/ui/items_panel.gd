extends PanelContainer

func load_items(items: Array[Item]):
	var items_list: VBoxContainer = $ItemPanelContents/ItemsScrollableArea/ItemsList
	for item in items:
		if item is Charm:
			var charm_panel: PanelContainer = load("uid://bwicy4t8cpw1t").instantiate()
			charm_panel.load_charm(item)
			items_list.add_child(charm_panel)
		elif item is Weapon:
			var weapon_panel: PanelContainer = load("uid://b1xapopufqbgt").instantiate()
			weapon_panel.load_weapon(item)
			items_list.add_child(weapon_panel)
		else:
			var item_panel: PanelContainer = load("uid://f78vlaulgj5y").instantiate()
			item_panel.load_item(item)
			items_list.add_child(item_panel)
