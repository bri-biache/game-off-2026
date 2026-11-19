extends PanelContainer

var hp: int = 90
var stats: Array[int] = [100, 20, 35, 15]

var weapon: Weapon = load("res://resources/items/weapons/test_weapon2.tres")

var charms: Array[Charm] = [load("res://resources/items/charms/test_charm1.tres"), 
load("res://resources/items/charms/test_charm2.tres"), load("res://resources/items/charms/test_charm1.tres")]

var items: Array[Item] = [load("res://resources/items/weapons/test_weapon2.tres"),
load("res://resources/items/weapons/test_weapon.tres"), load("res://resources/items/charms/test_charm1.tres"),
load("res://resources/items/charms/test_charm2.tres"), load("res://resources/items/test_item.tres")]

@onready var stats_panel: PanelContainer = $HBoxContainer/VBoxContainer/StatsPanel
@onready var weapon_panel: PanelContainer = $HBoxContainer/VBoxContainer/WeaponPanel
@onready var charms_panel: PanelContainer = $HBoxContainer/CharmsPanel
@onready var items_panel: PanelContainer = $HBoxContainer/ItemsPanel

func _ready() -> void:
	stats_panel.load_stats(hp, stats)
	weapon_panel.load_weapon(weapon)
	charms_panel.load_charms(charms)
	items_panel.load_items(items)
