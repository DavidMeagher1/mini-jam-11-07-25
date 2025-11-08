extends Node2D

const Key: ItemData = preload("uid://dcr0oiel6gb4a")

var is_open: bool = false

func _on_clicked(_button: int) -> void:
    if is_open:
        # TODO end game?
        return

    if Game.active_item == Key:
        is_open = true
        %SyncingAnimationPlayer.play("Open")
    else:
        %SyncingAnimationPlayer.play("Locked")