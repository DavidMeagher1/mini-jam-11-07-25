extends Node2D

@onready var timer: Timer = $Timer
var held: bool = false

const knife_item = preload("uid://006mkxspmx88")
const flowers_item = preload("uid://c60inoqd4l6c")
const dog_toy_item = preload("uid://e7n2xso3b2rc")

func _ready() -> void:
	Game.too_loud.connect(_on_too_loud)
	set_physics_process(false)
	hide()

func _physics_process(delta: float) -> void:
	if held:
		shake(delta)
	else:
		var mouse_position = get_global_mouse_position()
		global_position = global_position.move_toward(mouse_position, 100 * delta)
		global_position.x = clamp(global_position.x, 23, 255 - 23) # HARD CODED BOUNDS FOR ROOM
		global_position.y = clamp(global_position.y, 23, 255 - 23) # HARD CODED BOUNDS FOR ROOM
	

func shake(_delta: float) -> void:
	var tween = create_tween()
	var original_position = global_position
	var shake_magnitude = 5.0
	var shake_duration = 0.1
	tween.tween_property(self, "global_position", original_position + Vector2(randf_range(-shake_magnitude, shake_magnitude), randf_range(-shake_magnitude, shake_magnitude)), shake_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", original_position, shake_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished

func _on_face_clicked(_button: int) -> void:
	if Game.has_item(dog_toy_item) and Game.active_item == flowers_item:
		Game.end.emit(Game.Endings.LOVE)
	

func _on_face_held(_button: int) -> void:
	held = true
	if timer:
		timer.stop()


func _on_face_released(_button: int) -> void:
	held = false


func _on_timer_timeout() -> void:
	if Game.has_item(dog_toy_item):
		Game.end.emit(Game.Endings.LOSS)
		set_physics_process(false)
	else:
		%murderer.scale = Vector2(1.2, 1.2)
		Game.die(Game.DeathCauses.MURDERER)

func _on_too_loud() -> void:
	print("Player made too much noise! Murderer activated")
	show()
	set_physics_process(true)
	if Game.has_item(knife_item) || Game.active_item == flowers_item:
		%Knife.queue_free()
	if Game.active_item == flowers_item:
		timer.queue_free()
		%murderer.play("Love")


func _on_face_area_entered(_area: Area2D) -> void:
	if is_visible_in_tree() and timer:
		timer.start()
