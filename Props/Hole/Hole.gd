extends Node2D

@export var junk_needed:int = 1
var junk_amount:int = 0
@onready var interactable:Interactable = $Interactable
@onready var junk_hole_sprite:Sprite2D = $JunkHoleSprite
func _on_interactable_clicked(_button:int) -> void:
    if Game.active_item.name == "Junk":
        junk_amount += 1
        Game.consume_active_item()
        if junk_amount >= junk_needed:
            interactable.disabled = true
            junk_hole_sprite.visible = true
            junk_hole_sprite.get_node("Interactable").disabled = false