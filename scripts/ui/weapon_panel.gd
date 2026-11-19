extends PanelContainer

#var subtitle_label_settings: LabelSettings = load("uid://tivvtnxhftbw")
#var simple_label_settings: LabelSettings = load("uid://gyk7v33e0s4l")
#
#var weapon: Weapon = null
#
#@onready var weapon_info: VBoxContainer = $WeaponPanelContents/WeaponInfo

func load_weapon(weapon: Weapon) -> void:
	if weapon:
		var weapon_info: VBoxContainer = $WeaponPanelContents/WeaponInfo
		var weapon_panel: PanelContainer = load("uid://b1xapopufqbgt").instantiate()
		weapon_panel.load_weapon(weapon)
		weapon_info.add_child(weapon_panel)

#func load_weapon(_weapon: Weapon) -> void:
	#weapon = _weapon
	#if weapon:
		#load_weapon_data()

#func load_weapon_data() -> void:
	#create_weapon_name_display(weapon.name)
	#create_weapon_attack_display(weapon.attack)
	#create_weapon_description_display(weapon.description)
#
#func create_weapon_name_display(weapon_name: String) -> void:
	#var label: Label = Label.new()
	#label.text = weapon_name
	#label.label_settings = subtitle_label_settings
	#label.autowrap_mode = TextServer.AUTOWRAP_WORD
	#label.custom_minimum_size.x = 10.0
	#weapon_info.add_child(label)
#
#func create_weapon_attack_display(attack: int) -> void:
	#var label: Label = Label.new()
	#label.text = "Attack: " + str(attack)
	#label.label_settings = subtitle_label_settings
	#weapon_info.add_child(label)
#
#func create_weapon_description_display(description: String) -> void:
	#var label: Label = Label.new()
	#label.text = description
	#label.label_settings = simple_label_settings
	#label.autowrap_mode = TextServer.AUTOWRAP_WORD
	#label.custom_minimum_size.x = 10.0
	#weapon_info.add_child(label)
