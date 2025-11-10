class_name ItemContainer extends Interactable

signal item_grabbed(item: ItemData)

@export var items: Array[ItemData] = []
@export var random: bool = false

func _ready() -> void:
	clicked.connect(_on_clicked)

func _on_clicked(_button: int) -> void:
	if Game.active_item:
		return
	if not random:
		var item = items.pop_front()
		if item:
			item_grabbed.emit(item)
			Game.grab_item(item, true)
	else:
		var index = randi_range(0, items.size() - 1)
		var item = items[index]
		items.remove_at(index)
		if item:
			Game.grab_item(item, true)
			item_grabbed.emit(item)
