extends Node

@export var player_controller: Node

@onready var characters: Array[Node] = get_tree().get_nodes_in_group("playable_characters")
@onready var shift_menu: Control = $ShiftMenu
@onready var item_list: VBoxContainer = $ShiftMenu/PanelContainer/VBoxContainer

func _ready() -> void:
	hide_shift_menu()
	for character in characters:
		var button: Button = Button.new()
		button.text = character.name
		item_list.add_child(button)
		button.pressed.connect(func() -> void:
			swap_character(character)
			)

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
