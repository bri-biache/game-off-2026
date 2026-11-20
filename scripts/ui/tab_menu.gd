extends PanelContainer

var hp: int = 90
var stats: Array[int] = [100, 20, 35, 15]

var equipped_weapon: Weapon = load("res://resources/items/weapons/test_weapon2.tres")

var charms: Array[Charm] = [load("res://resources/items/charms/test_charm1.tres"), 
load("res://resources/items/charms/test_charm2.tres"), load("res://resources/items/charms/test_charm1.tres")]

var items: Array[Item] = [load("res://resources/items/weapons/test_weapon2.tres"),
load("res://resources/items/weapons/test_weapon.tres"), load("res://resources/items/charms/test_charm1.tres"),
load("res://resources/items/charms/test_charm2.tres"), load("res://resources/items/test_item.tres")]

@onready var stats_panel: PanelContainer = %StatsPanel
@onready var weapon_panel: PanelContainer = %WeaponPanel
@onready var charms_panel: PanelContainer = %CharmsPanel
@onready var items_panel: PanelContainer = %ItemsPanel

func _ready() -> void:
	stats_panel.load_stats(hp, stats)
	weapon_panel.load_weapon(equipped_weapon)
	weapon_panel.equipped_weapon_pressed.connect(on_equipped_weapon_press)
	charms_panel.load_charms(charms)
	charms_panel.equipped_charm_pressed.connect(on_equipped_charm_press)
	items_panel.load_items(items)
	items_panel.unequipped_weapon_pressed.connect(on_unequipped_weapon_press)
	items_panel.unequipped_charm_pressed.connect(on_unequipped_charm_press)
	items_panel.item_pressed.connect(on_item_press)

func on_equipped_weapon_press(weapon: Weapon) -> void:
	print(weapon.name)

func on_equipped_charm_press(charm: Charm) -> void:
	print(charm.name)

func on_unequipped_weapon_press(weapon: Weapon) -> void:
	print(weapon.name)

func on_unequipped_charm_press(charm: Charm) -> void:
	print(charm.name)

func on_item_press(item: Item) -> void:
	print(item.name)
