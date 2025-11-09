extends Node2D

signal opened()

const Key: ItemData = preload("uid://dcr0oiel6gb4a")
const flowers_item: ItemData = preload("uid://c60inoqd4l6c")

var is_open: bool = false

func _ready() -> void:
	%CanvasModulate.show()
	%CanvasModulate.color = Color.BLACK
	Game.end.connect(_on_end)

func _on_clicked(_button: int) -> void:
	activate()

func _on_end(ending: Game.Endings) -> void:
	%CanvasModulate.show()
	match ending:
		Game.Endings.LOVE:
			open()
			%CanvasModulate.color = Color.PINK
			
		Game.Endings.LOSS:
			open()
			%CanvasModulate.color = Color.WHITE
			
		Game.Endings.DEATH:
			%CanvasModulate.color = Color.RED
		_:
			%CanvasModulate.color = Color.BLACK


func open():
	if is_open:
		return
	is_open = true
	%SyncingAnimationPlayer.play("Open")
	opened.emit()

func activate() -> void:
	if is_open:
		#TODO: Escape through the door
		if Game.has_item(flowers_item):
			# TODO: Go to LOVE ending
			Game.reload()
		else:
			# TODO: Go to escape ending
			Game.reload()
		return
	if Game.active_item == Key:
		Game.consume_active_item()
		open()
	else:
		%SyncingAnimationPlayer.play("Locked")
		Game.impact.emit(70)