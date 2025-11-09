extends Node2D

func _on_dresser_item_grabbed(_item: ItemData) -> void:
	%dresser.play("Open")