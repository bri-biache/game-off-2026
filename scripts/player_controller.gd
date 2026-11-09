extends Node

const SPEED: int = 200

@onready var character: CharacterBody2D = get_parent()

func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	character.velocity = input_direction * SPEED
	character.move_and_slide()

func update_character():
	character = get_parent()
