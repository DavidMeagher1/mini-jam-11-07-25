extends Area2D

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    area_exited.connect(_on_area_exited)

func _on_area_entered(_area: Area2D) -> void:
    %SyncingAnimationPlayer.play("Close")

func _on_area_exited(_area: Area2D) -> void:
    %SyncingAnimationPlayer.play("Open")