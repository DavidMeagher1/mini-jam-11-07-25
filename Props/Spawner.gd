class_name Spawner extends Node2D

@export_group("Requirements", "required_")
@export var required_items: Array[ItemData] = []
@export var required_deaths: int = 0
@export var required_deaths_by: Dictionary[Game.DeathCauses, int] = {}
@export_group("Restrictions", "restricted_")
@export var restricted_items: Array[ItemData] = []
@export var restricted_deaths: int = 0
@export var restricted_deaths_by: Dictionary[Game.DeathCauses, int] = {}

func _ready() -> void:
    test()

func test() -> void:
    if restricted_deaths > 0 and Game.deaths > restricted_deaths:
        queue_free()
        return
    if required_deaths > 0 and Game.deaths < required_deaths:
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
    
    for death_cause in required_deaths_by.keys():
        var count = required_deaths_by[death_cause]
        if not Game.deaths_by.has(death_cause) or Game.deaths_by[death_cause] < count:
            queue_free()
            return

    for death_cause in restricted_deaths_by.keys():
        var count = restricted_deaths_by[death_cause]
        if Game.deaths_by.has(death_cause) and Game.deaths_by[death_cause] >= count:
            queue_free()
            return

    if not visible:
        visible = true