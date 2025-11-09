extends Node2D

@export var item: ItemData

func _on_interactable_clicked(_button:int) -> void:
    Game.grab_item(item)