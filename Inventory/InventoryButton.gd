extends TextureButton

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
    if data is Item:
        return true
    return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
    if data is Item:
        Game.inventory.add_item(data)
