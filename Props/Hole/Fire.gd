extends AnimatedSprite2D


func _on_interactable_clicked(button: int) -> void:
    if Game.active_item == null:
        return
    if Game.active_item.name == "Meat":
        Game.consume_active_item()
        ## TODO COOK MEAT
        Game.active_item = load("uid://bxbgq0ca182w2")
        Game.active_item_changed.emit(Game.active_item)
    else:
        if Game.active_item.name == "Head":
            Game.consume_active_item()
            Game.die(Game.DeathCauses.SUICIDE_FIRE_HOLE)
        Game.consume_active_item()
