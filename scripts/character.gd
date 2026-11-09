extends CharacterBody2D

const RAYCAST_LENGTH: int = 90

@export var stats: Stats

@onready var ray_cast: RayCast2D = $RayCast

func set_direction(direction: Vector2) -> void:
	ray_cast.target_position = direction * RAYCAST_LENGTH
