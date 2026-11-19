extends PanelContainer

func load_weapon(weapon: Weapon) -> void:
	var name_label: Label = $PanelContents/WeaponName
	name_label.text = weapon.name
	var attack_label: Label = $PanelContents/WeaponAttack
	attack_label.text = "Attack: " + str(weapon.attack)
	var description_label: Label = $PanelContents/WeaponDescription
	description_label.text = weapon.description
