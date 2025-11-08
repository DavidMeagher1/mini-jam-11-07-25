extends TextureButton

func _gui_input(event: InputEvent) -> void:
    if Game.cursor.current_item and event.is_pressed():
        var temp_item = Game.cursor.current_item
        Game.cursor.current_item = null
        Game.inventory.add_item(temp_item)
        accept_event()
