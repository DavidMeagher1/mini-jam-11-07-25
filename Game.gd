extends Node

var inventory: InventoryData = InventoryData.new()
@onready var cursor: Area2D = %Cursor

func _ready() -> void:
	inventory.add_item(load("uid://o1t7t4wuynpc"))

func grab_item(item: ItemData, from_inventory: bool = false) -> void:
	if has_active_item():
		drop_item()
	if from_inventory:
		inventory.remove_item(item)
	cursor.current_item = item

func drop_item() -> void:
	if cursor.current_item:
		inventory.add_item(cursor.current_item)
		cursor.current_item = null

func has_active_item() -> bool:
	return cursor.current_item != null