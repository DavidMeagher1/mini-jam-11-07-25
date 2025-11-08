extends Node

var inventory: InventoryData = InventoryData.new()
var active_item: ItemData = null:
	get:
		if cursor:
			return cursor.current_item
		return null
	set(value):
		if cursor:
			grab_item(value)
@onready var cursor: Area2D = %Cursor

func _ready() -> void:
	inventory.add_item(load("uid://o1t7t4wuynpc"))

func grab_item(item: ItemData, from_inventory: bool = false) -> void:
	if active_item:
		drop_item()
	cursor.current_item = item
	if item and from_inventory:
		inventory.remove_item(item)

func drop_item() -> void:
	if cursor.current_item:
		inventory.add_item(cursor.current_item)
		cursor.current_item = null

func consume_active_item() -> void:
	if cursor.current_item:
		cursor.current_item = null
