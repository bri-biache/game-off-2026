extends HBoxContainer

signal all_actions_selected

@onready var actions: PanelContainer = $CharacterActionBox

func _ready() -> void:
	actions.action_selected.connect(on_action_selection)

func on_action_selection() -> void:
	all_actions_selected.emit()

func disable_actions() -> void:
	actions.disable_all()

func enable_actions() -> void:
	actions.enable_all()
