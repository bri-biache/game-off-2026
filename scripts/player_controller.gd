extends Node

const SPEED: int = 200

var character_manager: Node

@onready var character: CharacterBody2D = get_parent()
@onready var tab_menu: PanelContainer = %TabMenu

func _ready() -> void:
	tab_menu.equipped_weapon = character.weapon
	tab_menu.charms = character.charms
	tab_menu.items = character.items
	tab_menu.load_panels()
	tab_menu.item_action.connect(on_tab_menu_interaction)
	tab_menu.give_item.connect(on_give_item)
	update_party_context_menu()

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
		print(character.stats.current_stats[Stats.Type.ATTACK])
	elif event.is_action_pressed("quick_party"):
		var collider: Node = character.ray_cast.get_collider()
		if collider and collider.is_in_group("playable_characters"):
			character_manager.add_party_member(character, collider)
	elif event.is_action_pressed("remove_party"):
		character_manager.remove_from_parties(character)
	elif event.is_action_pressed("tab"):
		if tab_menu.visible:
			hide_tab_manu()
		else:
			show_tab_menu()

func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	character.velocity = input_direction * SPEED
	character.move_and_slide()
	if character.velocity != Vector2.ZERO:
		character.position_tracker.pop_back()
		character.position_tracker.push_front(character.position)
		if character.party.size() > 1:
			character.party[1].position = character.position_tracker[32]
		if character.party.size() > 2:
			character.party[2].position = character.position_tracker[63]

func update_character():
	character = get_parent()

func update_party_context_menu() -> void:
	for member: PlayableCharacter in character.party:
		if member != character:
			tab_menu.add_party_member(member)

func reload_tab_menu():
	tab_menu.update_weapon(character.weapon)
	tab_menu.update_charms(character.charms)
	tab_menu.update_items(character.items)
	tab_menu.clear_party_members()
	update_party_context_menu()

func show_tab_menu() -> void:
	reload_tab_menu()
	set_physics_process(false)
	tab_menu.show()

func hide_tab_manu() -> void:
	set_physics_process(true)
	tab_menu.hide()

func on_tab_menu_interaction(item: Item, id: TabMenu.ContextMenuOptions):
	if id == TabMenu.ContextMenuOptions.WEAPON_EQUIP:
		character.equip_weapon(item)
		tab_menu.update_weapon(character.weapon)
		tab_menu.update_items(character.items)
	elif id == TabMenu.ContextMenuOptions.WEAPON_UNEQUIP:
		character.unequip_weapon()
		tab_menu.update_weapon(character.weapon)
		tab_menu.update_items(character.items)
	elif id == TabMenu.ContextMenuOptions.WEAPON_DROP:
		pass
	elif id == TabMenu.ContextMenuOptions.CHARM_EQUIP:
		character.equip_charm(item)
		tab_menu.update_charms(character.charms)
		tab_menu.update_items(character.items)
	elif id == TabMenu.ContextMenuOptions.CHARM_UNEQUIP:
		character.unequip_charm(item)
		tab_menu.update_charms(character.charms)
		tab_menu.update_items(character.items)
	elif id == TabMenu.ContextMenuOptions.CHARM_DROP:
		pass
	elif id == TabMenu.ContextMenuOptions.ITEM_USE:
		pass
	elif id == TabMenu.ContextMenuOptions.ITEM_DROP:
		pass

func on_give_item(item: Item, party_member: PlayableCharacter) -> void:
	character.remove_item(item)
	party_member.add_item(item)
	tab_menu.update_items(character.items)
