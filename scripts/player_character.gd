extends CharacterBody2D

@export var stats: Stats

const SPEED: int = 200

func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	move_and_slide()
