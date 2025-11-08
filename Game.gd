extends Control

var inventory: InventoryData = InventoryData.new()

func _ready() -> void:
	inventory.add_item(load("uid://o1t7t4wuynpc"))

func make_drag_preview(item_data: ItemData) -> Control:
	var preview = CenterContainer.new()
	preview.size = Vector2.ZERO
	var texture_container = TextureRect.new()
	preview.add_child(texture_container)
	texture_container.stretch_mode = TextureRect.STRETCH_KEEP
	texture_container.texture = item_data.icon
	return preview

func force_drag_item(item: ItemData) -> void:
	var drag_preiew = make_drag_preview(item)
	force_drag(item, drag_preiew)
