extends TextureButton

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
    if data is ItemData:
        return true
    return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
    if data is ItemData:
        Game.inventory.add_item(data)
