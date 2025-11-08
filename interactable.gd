class_name Interactable extends Area2D

enum MouseFilter {
	MOUSE_FILTER_IGNORE = 0,
	MOUSE_FILTER_PASS = 1,
	MOUSE_FILTER_STOP = 2,
}

signal clicked(button: int)
signal pressed(button: int)
signal released(button: int)
signal held(button: int)


@export_group("Mouse", "mouse_")
@export var mouse_filter: MouseFilter = MouseFilter.MOUSE_FILTER_PASS
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
	var _hole = shape_idx
	if event is InputEventMouse and mouse_filter == MouseFilter.MOUSE_FILTER_IGNORE:
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
	
	var parent = get_parent()
	if event is InputEventMouse:
		if mouse_filter == MouseFilter.MOUSE_FILTER_STOP:
			viewport.set_input_as_handled()
		elif mouse_filter == MouseFilter.MOUSE_FILTER_PASS and parent is Interactable:
			parent._input_event(viewport, event, shape_idx)

func is_pressed(button: int) -> bool:
	return inputs.has(button) and inputs[button]

func reset_inputs() -> void:
	inputs.clear()

@warning_ignore("unused_parameter")
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return false
