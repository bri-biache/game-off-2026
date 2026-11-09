extends Node

const SPEED: int = 200

@onready var character: CharacterBody2D = get_parent()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up") and character.velocity.x == 0:
		character.set_direction(Vector2.UP)
	elif event.is_action_pressed("move_down") and character.velocity.x == 0:
		character.set_direction(Vector2.DOWN)
	elif event.is_action_pressed("move_left") and character.velocity.y == 0:
		character.set_direction(Vector2.LEFT)
	elif event.is_action_pressed("move_right") and character.velocity.y == 0:
		character.set_direction(Vector2.RIGHT)
	elif event.is_action_released("move_up") or event.is_action_released("move_down"):
		if Input.get_action_strength("move_left") > 0:
			character.set_direction(Vector2.LEFT)
		elif Input.get_action_strength("move_right") > 0:
			character.set_direction(Vector2.RIGHT)
	elif event.is_action_released("move_left") or event.is_action_released("move_right"):
		if Input.get_action_strength("move_up"):
			character.set_direction(Vector2.UP)
		elif Input.get_action_strength("move_down"):
			character.set_direction(Vector2.DOWN)
	
	elif event.is_action_pressed("interact"):
		print(character.ray_cast.is_colliding())

func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	character.velocity = input_direction * SPEED
	character.move_and_slide()

func update_character():
	character = get_parent()
