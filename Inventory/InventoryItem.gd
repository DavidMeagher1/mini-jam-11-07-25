extends TextureRect

@export var item_data: ItemData

func make_drag_preview() -> TextureRect:
    var preview = CenterContainer.new()
    var texture_container = TextureRect.new()
    preview.add_child(texture_container)
    texture_container.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
    texture_container.texture = item_data.icon
    return preview

func _get_drag_data(_at_position: Vector2) -> Variant:
    set_drag_preview(make_drag_preview())
    Game.inventory.remove_item.call_deferred(item_data)
    return item_data