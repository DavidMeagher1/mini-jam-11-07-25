extends Node2D

signal opened()

const Key: ItemData = preload("uid://dcr0oiel6gb4a")

var is_open: bool = false

func _on_clicked(_button: int) -> void:
	if is_open:
		# TODO end game?
		return

	if Game.active_item == Key:
		is_open = true
		Game.consume_active_item()
		%SyncingAnimationPlayer.play("Open")
		opened.emit()
	else:
		%SyncingAnimationPlayer.play("Locked")
		Game.impact.emit(70)