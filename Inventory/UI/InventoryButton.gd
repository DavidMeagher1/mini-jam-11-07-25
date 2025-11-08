extends TextureButton

func _gui_input(event: InputEvent) -> void:
    if Game.cursor.current_item and event.is_pressed():
        Game.inventory.add_item(Game.cursor.current_item)
        Game.cursor.current_item = null
        accept_event()
