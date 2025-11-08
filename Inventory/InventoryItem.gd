extends TextureRect

@export var item_data: ItemData: set = set_item_data

func make_drag_preview() -> Control:
	var preview = CenterContainer.new()
	preview.size = Vector2.ZERO
	var texture_container = TextureRect.new()
	preview.add_child(texture_container)
	texture_container.stretch_mode = TextureRect.STRETCH_KEEP
	texture_container.texture = item_data.icon
	return preview

func set_item_data(data: ItemData) -> void:
	item_data = data
	if item_data:
		texture = item_data.icon
	else:
		texture = null

func _get_drag_data(_at_position: Vector2) -> Variant:
	Game.inventory.remove_item(item_data)
	set_drag_preview(make_drag_preview())
	return item_data
