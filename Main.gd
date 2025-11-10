extends Node2D

func _ready():
	Game.start.emit()
	Game.get_node("HUD").show()
