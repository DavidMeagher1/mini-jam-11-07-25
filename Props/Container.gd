class_name Container extends Interactable

@export var items: Array[ItemData] = []

func _ready() -> void:
    clicked.connect(_on_clicked)

func _on_clicked() -> void:
    if Game.active_item:
        return
    var item = items.pop_front()
    if item:
        Game.grab_item(item)