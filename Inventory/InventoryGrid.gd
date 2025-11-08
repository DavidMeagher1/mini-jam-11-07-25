extends GridContainer

var item_template

func _ready() -> void:
    item_template = get_child(0)
    remove_child(item_template)
    Game.inventory.changed.connect(_on_inventory_changed)
    _on_inventory_changed()

func _on_inventory_changed() -> void:
    for child in get_children():
        child.queue_free()

    for item in Game.inventory.items:
        var item_instance = item_template.duplicate()
        item_instance.item_data = item
        add_child(item_instance)

func _gui_input(event: InputEvent) -> void:
    if event.is_pressed() and Game.cursor.current_item:
        Game.inventory.add_item(Game.cursor.current_item)
        Game.cursor.current_item = null
        accept_event()

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        hide()