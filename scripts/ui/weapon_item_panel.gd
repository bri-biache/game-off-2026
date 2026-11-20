extends PanelContainer

signal weapon_pressed(weapon: Weapon)

var weapon: Weapon

func load_weapon(_weapon: Weapon) -> void:
	weapon = _weapon
	var name_label: Label = $PanelContents/WeaponName
	name_label.text = _weapon.name
	var attack_label: Label = $PanelContents/WeaponAttack
	attack_label.text = "Attack: " + str(_weapon.attack)
	var description_label: Label = $PanelContents/WeaponDescription
	description_label.text = _weapon.description
	%Button.pressed.connect(on_press)

func on_press() -> void:
	weapon_pressed.emit(weapon)
