extends PanelContainer

signal text_displayed
signal text_advanced

const DISPLAY_RATE: float = 0.1

var time_elapsed: float = 0.0

@onready var label: Label = %Text

#func _ready() -> void:
	#display_text("Hello, world!")
	#await text_advanced
	#display_text("This is the next sentence")

func display_text(msg: String) -> void:
	label.visible_ratio = 0.0
	label.visible_characters = 0
	label.text = msg
	set_process(true)
	await text_displayed
	set_process(false)

func clear() -> void:
	label.text = ""

func _process(delta: float) -> void:
	time_elapsed += delta
	if label.visible_ratio != 1.0:
		if time_elapsed >= DISPLAY_RATE:
			time_elapsed -= DISPLAY_RATE
			label.visible_characters += 1
	else:
		text_displayed.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if label.visible_ratio < 1.0:
			label.visible_ratio = 1.0
			text_displayed.emit()
		else:
			text_advanced.emit()
