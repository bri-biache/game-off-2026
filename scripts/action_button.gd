class_name ActionButton
extends Button

signal action_pressed(action: ActionButton)
signal action_unpressed(action: ActionButton)

func _toggled(toggled_on: bool) -> void:
	if toggled_on:
		action_pressed.emit(self)
	else:
		action_unpressed.emit(self)
