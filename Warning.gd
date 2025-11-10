extends Label

func _ready() -> void:
    await get_tree().create_timer(4.0).timeout
    get_tree().change_scene_to_file("uid://chg1yu6730ef1")