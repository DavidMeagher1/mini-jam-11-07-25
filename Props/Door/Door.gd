extends Node2D

signal opened()

const Key: ItemData = preload("uid://dcr0oiel6gb4a")

var is_open: bool = false

func _on_clicked(_button: int) -> void:
	activate()

func open():
	is_open = true
	%SyncingAnimationPlayer.play("Open")
	opened.emit()

func activate() -> void:
	if is_open:
		return
	if Game.active_item == Key:
		Game.consume_active_item()
		open()
	else:
		%SyncingAnimationPlayer.play("Locked")
		Game.impact.emit(70)