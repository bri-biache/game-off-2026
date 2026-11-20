extends PanelContainer

signal equipped_weapon_pressed(weapon: Weapon)

func load_weapon(weapon: Weapon) -> void:
	if weapon:
		var weapon_info: VBoxContainer = $WeaponPanelContents/WeaponInfo
		var weapon_panel: PanelContainer = load("uid://b1xapopufqbgt").instantiate()
		weapon_panel.load_weapon(weapon)
		weapon_panel.weapon_pressed.connect(on_weapon_pressed)
		weapon_info.add_child(weapon_panel)

func on_weapon_pressed(weapon: Weapon) -> void:
	equipped_weapon_pressed.emit(weapon)
