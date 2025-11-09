extends Sprite2D

@onready var interactable:Interactable = $Interactable
@onready var fire:AnimatedSprite2D = $"../fire"
func _on_interactable_clicked(button: int) -> void:
	if Game.active_item == null:
		return
	if Game.active_item.name == "Match":
		Game.consume_active_item()
		interactable.disabled = true
		hide()
		fire.visible = true
		fire.get_node("Interactable").disabled = false
