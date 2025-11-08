extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
signal state_changed(new_state: int)

func _on_area_2d_state_changed(new_state: int) -> void:
	state_changed.emit(new_state)
	animation_player.play("switch_pulled")
