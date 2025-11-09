extends Sprite2D


func _on_interactable_clicked(button: int) -> void:
    if Game.active_item == null:
        return
    if Game.active_item.name == "StrangeSeed":
        Game.consume_active_item()
        pass # TODO PLANT SEED
