extends Node

var inventory: InventoryData = InventoryData.new()

func _ready() -> void:
    var test_item = load("uid://o1t7t4wuynpc")
    inventory.add_item(test_item)
    pass