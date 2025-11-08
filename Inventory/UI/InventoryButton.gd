extends TextureButton

func _gui_input(event: InputEvent) -> void:
    if event.is_pressed() and Game.has_active_item():
        Game.drop_item()
        accept_event()
