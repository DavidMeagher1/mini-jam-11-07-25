extends Node2D

func _unhandled_input(event: InputEvent) -> void:
    if event.is_pressed():
        get_tree().change_scene_to_file("uid://cmd74jp3cixlg")