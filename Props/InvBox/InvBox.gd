extends Node2D

@export var item: ItemData

func _on_interactable_clicked() -> void:
    Game.grab_item(item)