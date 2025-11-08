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
	Game.inventory.remove_item(item_data)
	Game.cursor.current_item = item_data
