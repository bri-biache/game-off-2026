class_name PlayableCharacter
extends CharacterBody2D

const RAYCAST_LENGTH: int = 90

@export var stats: Stats
@export var weapon: Weapon

var party: Array[PlayableCharacter] = [self]
var position_tracker: Array[Vector2]

@onready var ray_cast: RayCast2D = $RayCast

func _ready() -> void:
	position_tracker.resize(64)
	position_tracker.fill(position)
	update_stats()

func set_direction(direction: Vector2) -> void:
	ray_cast.target_position = direction * RAYCAST_LENGTH

func add_party_member(new_member: PlayableCharacter) -> void:
	party.append(new_member)

func remove_party_member(leaving_member: PlayableCharacter) -> void:
	party.erase(leaving_member)

func add_party(new_party: Array[PlayableCharacter]) -> void:
	party.append_array(new_party)

func reset_party() -> void:
	party = [self]

func update_stats() -> void:
	for modifier in stats.stat_modifiers:
		modifier.reset_addends()
		modifier.reset_multipliers()
	if weapon:
		stats.stat_modifiers[Stats.ATTACK].add_addend(weapon.attack)
	stats.calculate_stats()
