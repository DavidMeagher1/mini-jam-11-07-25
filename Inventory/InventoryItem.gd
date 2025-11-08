extends TextureRect

@export var item_data: ItemData: set = set_item_data


func set_item_data(data: ItemData) -> void:
	item_data = data
	if item_data:
		texture = item_data.icon
	else:
		texture = null

func _get_drag_data(_at_position: Vector2) -> Variant:
	Game.inventory.remove_item(item_data)
	set_drag_preview(Game.make_drag_preview(item_data))
	return item_data
