extends Spawner

@onready var timer: Timer = $Timer
var held: bool = false

const knife_item = preload("uid://006mkxspmx88")

func _ready() -> void:
	super._ready()
	Game.too_loud.connect(_on_too_loud)
	set_physics_process(false)
	hide()

func _on_mouse_entered() -> void:
	timer.start()

func _physics_process(delta: float) -> void:
	if held:
		shake(delta)
	else:
		var mouse_position = get_global_mouse_position()
		global_position = global_position.move_toward(mouse_position, 100 * delta)
		global_position.x = clamp(global_position.x, 23, 255 - 23) #HARD CODED BOUNDS FOR ROOM
		global_position.y = clamp(global_position.y, 23, 255 - 23) #HARD CODED BOUNDS FOR ROOM


func shake(delta: float) -> void:
	var tween = create_tween()
	var original_position = global_position
	var shake_magnitude = 5.0
	var shake_duration = 0.1
	tween.tween_property(self, "global_position", original_position + Vector2(randf_range(-shake_magnitude, shake_magnitude), randf_range(-shake_magnitude, shake_magnitude)), shake_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", original_position, shake_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished

func _on_face_clicked(button: int) -> void:
	pass # Replace with function body.


func _on_face_held(button: int) -> void:
	held = true
	timer.stop()


func _on_face_released(button: int) -> void:
	held = false


func _on_timer_timeout() -> void:
	Game.die()

func _on_too_loud() -> void:
	if Game.has_item(knife_item):
		queue_free()
	show()
	set_physics_process(true)