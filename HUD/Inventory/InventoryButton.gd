extends TextureButton

func _ready() -> void:
    Game.active_item_changed.connect(_on_active_item_changed)

func _on_active_item_changed(item: ItemData) -> void:
    if not visible:
        visible = true

func _gui_input(event: InputEvent) -> void:
    if event.is_pressed() and Game.active_item:
        Game.drop_item()
        accept_event()
