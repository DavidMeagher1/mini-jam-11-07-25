extends TextureButton

@export var item_data: ItemData: set = set_item_data

func _ready() -> void:
	pressed.connect(_on_pressed)

func set_item_data(data: ItemData) -> void:
	item_data = data
	if item_data:
		texture_normal = item_data.icon
	else:
		texture_normal = null

func _on_pressed() -> void:
	print_debug(Game.active_item)
	if Game.active_item == null:
		Game.grab_item(item_data, true)
		print_debug("Grabbed %s from inventory" % item_data.name)
		accept_event()
	else:
		print_debug("Trying to craft %s with %s" % [Game.active_item.name, item_data.name])
		var recipe_output = Game.active_item.get_crafted_item(item_data)
		if recipe_output:
			Game.consume_active_item()
			Game.inventory.remove_item(item_data)
			Game.inventory.add_item(recipe_output)
		accept_event()
