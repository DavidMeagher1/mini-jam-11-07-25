extends Sprite2D

var flowers_item: ItemData = load("uid://c60inoqd4l6c") # Flowers
@onready var flowers: Interactable = $Flowers
func _on_interactable_clicked(button: int) -> void:
    if Game.active_item == null:
        return
    if Game.active_item.name == "StrangeSeed":
        Game.consume_active_item()
        flowers.show()
        flowers.disabled = false


func _on_flowers_clicked(button: int) -> void:
    if not Game.active_item == null:
        return
    Game.grab_item(flowers_item)
    flowers.hide()
    flowers.disabled = true
    
