extends Node

@export var player_controller: Node
@export var initial_character: CharacterBody2D

@onready var characters: Array[Node] = get_tree().get_nodes_in_group("playable_characters")
@onready var shift_menu: Control = $ShiftMenu
@onready var item_list: VBoxContainer = $ShiftMenu/PanelContainer/VBoxContainer

func _ready() -> void:
	hide_shift_menu()
	setup_shift_menu()
	player_controller.character_manager = self
	swap_character(initial_character)
	#update_character_collision_layers()

func setup_shift_menu() -> void:
	for character in characters:
		var button: Button = Button.new()
		button.text = character.name
		item_list.add_child(button)
		button.pressed.connect( func() -> void: swap_character(character) )

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shift"):
		show_shift_menu()
	if event.is_action_released("shift"):
		hide_shift_menu()

func show_shift_menu():
	player_controller.set_physics_process(false)
	shift_menu.show()

func hide_shift_menu():
	player_controller.set_physics_process(true)
	shift_menu.hide()

func swap_character(character: Node) -> void:
	player_controller.reparent(character)
	player_controller.update_character()
	update_character_collision_layers()

func update_character_collision_layers() -> void:
	for character in characters:
		if character in player_controller.character.party:
			character.set_collision_layer_value(3, false)
		else:
			character.set_collision_layer_value(3, true)

func add_party_member(leader: PlayableCharacter, new_member: PlayableCharacter) -> void:
	new_member.leave_party()
	new_member.join_party(leader.party)
	leader.add_party_member(new_member)
