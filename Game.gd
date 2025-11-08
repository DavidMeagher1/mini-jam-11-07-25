extends Node

var inventory: InventoryData = InventoryData.new()
@onready var cursor: Area2D = %Cursor

func _ready() -> void:
	inventory.add_item(load("uid://o1t7t4wuynpc"))