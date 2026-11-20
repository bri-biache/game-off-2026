class_name PlayableCharacter
extends CharacterBody2D

const RAYCAST_LENGTH: int = 90

@export var stats: Stats
@export var weapon: Weapon
@export var charms: Array[Charm]
@export var items: Array[Item]

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
	if weapon:
		stats.add_addend(Stats.Type.ATTACK, weapon.attack_modifier)
	stats.calculate_stats()

func unequip_weapon() -> void:
	items.append(weapon)
	weapon = null

func equip_weapon(new_weapon: Weapon) -> void:
	if weapon:
		items.append(weapon)
	weapon = new_weapon
	items.erase(new_weapon)

func equip_charm(charm: Charm) -> void:
	charms.append(charm)
	items.erase(charm)

func unequip_charm(charm: Charm) -> void:
	charms.erase(charm)
	items.append(charm)
