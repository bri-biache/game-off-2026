extends PanelContainer

func load_item(item: Item) -> void:
	var name_label: Label = $ItemInfo/ItemName
	name_label.text = item.name
	var description_label: Label = $ItemInfo/ItemDescription
	description_label.text = item.description
