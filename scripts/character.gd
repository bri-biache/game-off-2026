class_name PlayableCharacter
extends CharacterBody2D

const RAYCAST_LENGTH: int = 90
const TRACKER_LENGTH: int = 32

@export var stats: Stats
@export var weapon: Weapon
@export var charms: Array[Charm]
@export var items: Array[Item]

var party: Array[PlayableCharacter] = [self]
var position_tracker: Array[Vector2]
var direction_tracker: Array[Vector2]

var direction: Vector2 = Vector2.DOWN: set = set_direction
var is_idle: bool = true: set = set_idle

@onready var ray_cast: RayCast2D = $RayCast
@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	position_tracker.resize(TRACKER_LENGTH)
	position_tracker.fill(position)
	direction_tracker.resize(TRACKER_LENGTH)
	direction_tracker.fill(direction)
	update_stats()

func set_idle(idle: bool) -> void:
	is_idle = idle
	if idle:
		animation_tree.set("parameters/conditions/walk", false)
		animation_tree.set("parameters/conditions/idle", true)
	else:
		animation_tree.set("parameters/conditions/idle", false)
		animation_tree.set("parameters/conditions/walk", true)

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	ray_cast.target_position = direction * RAYCAST_LENGTH
	animation_tree.set("parameters/Walk/blend_position", direction)
	animation_tree.set("parameters/Idle/blend_position", direction)

func update_trackers() -> void:
	position_tracker.pop_back()
	position_tracker.push_front(position)
	direction_tracker.pop_back()
	direction_tracker.push_front(direction)

func add_party_member(new_member: PlayableCharacter) -> void:
	party.append(new_member)

func remove_party_member(leaving_member: PlayableCharacter) -> void:
	party.erase(leaving_member)

func add_party(new_party: Array[PlayableCharacter]) -> void:
	party.append_array(new_party)
	
func leave_party():
	set_idle(true)
	reset_party()
	
func reset_party() -> void:
	party = [self]

func update_stats() -> void:
	stats.clear()
	if weapon:
		stats.add_addend(Stats.Type.ATTACK, weapon.attack_modifier)
	for charm: Charm in charms:
		for stat_mod in charm.stat_mods:
			if stat_mod is StatAddend:
				stats.add_addend(stat_mod.modified_stat, stat_mod)
			elif stat_mod is StatMultiplier:
				stats.add_multiplier(stat_mod.modified_stat, stat_mod)
	stats.calculate_stats()

func unequip_weapon() -> void:
	items.append(weapon)
	weapon = null
	update_stats()

func equip_weapon(new_weapon: Weapon) -> void:
	if weapon:
		items.append(weapon)
	weapon = new_weapon
	items.erase(new_weapon)
	update_stats()

func equip_charm(charm: Charm) -> void:
	charms.append(charm)
	items.erase(charm)
	update_stats()

func unequip_charm(charm: Charm) -> void:
	charms.erase(charm)
	items.append(charm)
	update_stats()

func add_item(item: Item) -> void:
	items.append(item)
	update_stats()

func remove_item(item: Item) -> void:
	items.erase(item)
	update_stats()
