extends Node

var inventory: InventoryData = InventoryData.new()

func _ready() -> void:
    inventory.add_item(load("uid://o1t7t4wuynpc"))
    inventory.add_item(load("uid://bfnq3rjfl7phv"))