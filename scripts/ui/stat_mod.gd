extends PanelContainer

func set_modifier(stat_mod: StatModifier):
	var label: Label = $Info
	label.text = str(stat_mod)
