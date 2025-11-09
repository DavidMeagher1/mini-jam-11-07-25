extends Node2D

@onready var puff_sprite: AnimatedSprite2D = $puff

func _on_puff_animation_finished() -> void:
    queue_free()