class_name Spawner extends Node2D

@export_group("Requirements", "required_")
@export var required_items: Array[ItemData] = []
@export var required_deaths: int = 0

func _ready() -> void:
    if Game.deaths < required_deaths:
        queue_free()
        return

    for item in required_items:
        if not Game.has_item(item):
            queue_free()
            return