extends PanelContainer

signal unequipped_weapon_pressed(weapon: Weapon)
signal unequipped_charm_pressed(charm: Charm)
signal item_pressed(item: Item)

func load_items(items: Array[Item]):
	var items_list: VBoxContainer = %ItemsList
	for item in items:
		if item is Charm:
			var charm_panel: PanelContainer = load("uid://bwicy4t8cpw1t").instantiate()
			charm_panel.load_charm(item)
			charm_panel.charm_pressed.connect(on_charm_press)
			items_list.add_child(charm_panel)
		elif item is Weapon:
			var weapon_panel: PanelContainer = load("uid://b1xapopufqbgt").instantiate()
			weapon_panel.load_weapon(item)
			weapon_panel.weapon_pressed.connect(on_weapon_press)
			items_list.add_child(weapon_panel)
		else:
			var item_panel: PanelContainer = load("uid://f78vlaulgj5y").instantiate()
			item_panel.load_item(item)
			item_panel.item_pressed.connect(on_item_press)
			items_list.add_child(item_panel)

func on_weapon_press(weapon: Weapon) -> void:
	unequipped_weapon_pressed.emit(weapon)

func on_charm_press(charm: Charm) -> void:
	unequipped_charm_pressed.emit(charm)

func on_item_press(item: Item) -> void:
	item_pressed.emit(item)
