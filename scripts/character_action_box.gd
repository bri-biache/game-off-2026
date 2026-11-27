extends PanelContainer

signal action_selected

var selected_action: ActionButton = null

@onready var buttons: Array[Node] = %ActionButtons.get_children()

func _ready() -> void:
	for button in buttons:
		button.action_pressed.connect(button_pressed)
		button.action_unpressed.connect(button_unpressed)

func button_pressed(action: ActionButton) -> void:
	selected_action = action
	action_selected.emit()
	for button in buttons:
		if button != action:
			button.disabled = true

func button_unpressed(_action: ActionButton) -> void:
	selected_action = null
	for button in buttons:
		button.disabled = false

func enable_all() -> void:
	for button in buttons:
		button.disabled = false

func disable_all() -> void:
	for button in buttons:
		button.disabled = true
