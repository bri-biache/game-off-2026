extends PanelContainer

signal item_pressed(item: Item)

var item: Item

func load_item(_item: Item) -> void:
	item = _item
	var name_label: Label = %ItemName
	name_label.text = _item.name
	var description_label: Label = %ItemDescription
	description_label.text = _item.description
	%Button.pressed.connect(on_press)

func on_press() -> void:
	item_pressed.emit(item)
