extends PanelContainer

enum ContextMenuOptions {WEAPON_EQUIP, WEAPON_UNEQUIP, WEAPON_GIVE, WEAPON_DROP,
	CHARM_EQUIP, CHARM_UNEQUIP, CHARM_GIVE, CHARM_DROP, ITEM_USE, ITEM_GIVE, ITEM_DROP}

var hp: int = 90
var stats: Array[int] = [100, 20, 35, 15]

var equipped_weapon: Weapon

var charms: Array[Charm]

var items: Array[Item]

var selected_item: Item

@onready var stats_panel: PanelContainer = %StatsPanel
@onready var weapon_panel: PanelContainer = %WeaponPanel
@onready var charms_panel: PanelContainer = %CharmsPanel
@onready var items_panel: PanelContainer = %ItemsPanel

@onready var context_menu: PopupMenu = %ContextMenu

func _ready() -> void:
	context_menu.id_pressed.connect(on_context_menu_press)
	context_menu.popup_hide.connect(on_context_menu_hide)

func load_panels() -> void:
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
	selected_item = weapon
	context_menu.add_item("Unequip", ContextMenuOptions.WEAPON_UNEQUIP)
	display_context_menu()

func on_equipped_charm_press(charm: Charm) -> void:
	selected_item = charm
	context_menu.add_item("Unequip", ContextMenuOptions.CHARM_UNEQUIP)
	display_context_menu()

func on_unequipped_weapon_press(weapon: Weapon) -> void:
	selected_item = weapon
	context_menu.add_item("Equip", ContextMenuOptions.WEAPON_EQUIP)
	context_menu.add_item("Give", ContextMenuOptions.WEAPON_GIVE)
	context_menu.add_item("Drop", ContextMenuOptions.WEAPON_DROP)
	display_context_menu()

func on_unequipped_charm_press(charm: Charm) -> void:
	selected_item = charm
	context_menu.add_item("Equip", ContextMenuOptions.CHARM_EQUIP)
	context_menu.add_item("Give", ContextMenuOptions.CHARM_GIVE)
	context_menu.add_item("Drop", ContextMenuOptions.CHARM_DROP)
	display_context_menu()

func on_item_press(item: Item) -> void:
	selected_item = item
	context_menu.add_item("Use", ContextMenuOptions.ITEM_USE)
	context_menu.add_item("Give", ContextMenuOptions.ITEM_GIVE)
	context_menu.add_item("Drop", ContextMenuOptions.ITEM_DROP)
	display_context_menu()

func display_context_menu() -> void:
	context_menu.popup(Rect2(get_global_mouse_position(), context_menu.size))

func on_context_menu_press(id: int) -> void:
	pass

func on_context_menu_hide() -> void:
	context_menu.clear()
