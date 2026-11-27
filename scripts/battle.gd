extends Control

@onready var text_box: PanelContainer = %TextBox
@onready var player_input: HBoxContainer = %PlayerInput

func _ready() -> void:
	player_input.disable_actions()
	start_battle()

func start_battle() -> void:
	text_box.display_text("A battle begins")
	await text_box.text_displayed
	collect_player_input()

func collect_player_input() -> void:
	player_input.enable_actions()
	await player_input.all_actions_selected
	print("Done")
