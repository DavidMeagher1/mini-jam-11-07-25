extends Area2D

var current_item: ItemData = null: set = set_current_item

func set_current_item(item: ItemData) -> void:
	current_item = item
	if item:
		$Sprite.texture = item.icon
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		visible = true
	else:
		$Sprite.texture = null
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		visible = false

func _process(_delta: float) -> void:
	global_position = get_viewport().get_mouse_position()