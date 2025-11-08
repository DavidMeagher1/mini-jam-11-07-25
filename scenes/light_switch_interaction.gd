extends Interactable

signal state_changed(new_state: int)

var click_direction:int = 0
var click_state:int = 0

func _on_clicked(button: int) -> void:
	if button != MouseButton.MOUSE_BUTTON_LEFT:
		return

	if click_state == 0:
		click_direction = 1
	elif click_state == 3:
		click_direction = -1
	click_state += click_direction
	click_state = clamp(click_state, 0, 3)
	state_changed.emit(click_state)
