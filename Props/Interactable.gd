class_name Interactable extends Area2D

signal clicked(button: int)
signal pressed(button: int)
signal released(button: int)
signal held(button: int)


@export var disabled: bool = false
@export var button_pressed: bool = false

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var inputs: Dictionary[int, bool] = {}

func _ready():
	input_pickable = true
	mouse_exited.connect(reset_inputs)

func _process(_delta: float) -> void:
	for button in inputs.keys():
		if is_pressed(button):
			held.emit(button)

func _input_event(viewport, event, shape_idx):
	if disabled:
		return
	if event is InputEventMouseButton:
		if event.pressed:
			inputs[event.button_index] = true
			pressed.emit(event.button_index)

			if button_pressed:
				clicked.emit(event.button_index)
		
		elif is_pressed(event.button_index):
			inputs[event.button_index] = false
			released.emit(event.button_index)

			if not button_pressed:
				clicked.emit(event.button_index)

func is_pressed(button: int) -> bool:
	return inputs.has(button) and inputs[button]

func reset_inputs() -> void:
	inputs.clear()
	released.emit(-1)
