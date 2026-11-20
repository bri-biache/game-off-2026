extends PanelContainer

signal equipped_weapon_pressed(weapon: Weapon)

@onready var weapon_info: VBoxContainer = %WeaponInfo

func load_weapon(weapon: Weapon) -> void:
	if weapon:
		var weapon_panel: PanelContainer = load("uid://b1xapopufqbgt").instantiate()
		weapon_panel.load_weapon(weapon)
		weapon_panel.weapon_pressed.connect(on_weapon_pressed)
		weapon_info.add_child(weapon_panel)

func clear() -> void:
	if weapon_info.get_child_count() == 0:
		return
	for child_node in weapon_info.get_children():
		child_node.queue_free()

func on_weapon_pressed(weapon: Weapon) -> void:
	equipped_weapon_pressed.emit(weapon)
