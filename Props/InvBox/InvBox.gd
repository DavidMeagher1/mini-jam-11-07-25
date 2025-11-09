extends Node2D

@export var item: ItemData

func _on_interactable_clicked(_button:int) -> void:
    if !Game.has_item(item):
        Game.grab_item(item)