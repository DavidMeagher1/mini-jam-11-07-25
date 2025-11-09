extends Node2D

func _ready() -> void:
	hide()
	Game.end.connect(_on_end)

func _on_end(ending: int) -> void:
	if ending == Game.Endings.DEATH:
		show()
		await get_tree().create_timer(3).timeout
		hide()
		Game.reload()
