class_name PlayableCharacter
extends CharacterBody2D

const RAYCAST_LENGTH: int = 90

@export var stats: Stats

var party: Array[PlayableCharacter] = [self]

@onready var ray_cast: RayCast2D = $RayCast

func set_direction(direction: Vector2) -> void:
	ray_cast.target_position = direction * RAYCAST_LENGTH

func add_party_member(new_member: PlayableCharacter) -> void:
	party.append(new_member)

func remove_party_member(leaving_member: PlayableCharacter) -> void:
	party.erase(leaving_member)

func join_party(new_party: Array[PlayableCharacter]) -> void:
	party.append_array(new_party)

func leave_party() -> void:
	var party_members: Array[PlayableCharacter] = party.duplicate()
	for character in party_members:
		character.remove_party_member(self)
	party = [self]
