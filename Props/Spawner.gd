class_name Spawner extends Node2D

@export_group("Requirements", "required_")
@export var required_items: Array[ItemData] = []
@export var required_deaths: int = 0
@export_group("Restrictions", "restricted_")
@export var restricted_items: Array[ItemData] = []
@export var restricted_deaths: int = 0

func _ready() -> void:
    if Game.deaths > restricted_deaths:
        queue_free()
        return
    if Game.deaths < required_deaths:
        queue_free()
        return

    for item in restricted_items:
        if Game.has_item(item):
            queue_free()
            return
    for item in required_items:
        if not Game.has_item(item):
            queue_free()
            return