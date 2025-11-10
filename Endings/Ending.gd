extends Node2D

func _ready() -> void:
    var timer = get_tree().create_timer(10.0)
    await timer.timeout
    get_tree().change_scene_to_file("uid://chg1yu6730ef1")