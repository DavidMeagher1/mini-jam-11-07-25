extends Node2D

var knife_item:ItemData = preload("uid://006mkxspmx88")
var meat_item:ItemData = preload("uid://c6m4thtcc8p1k")
@onready var dog_sprite_group:CanvasGroup = $dog

var hostile: bool = true

func _ready() -> void:
	if Game.has_item(meat_item):
		hostile = false
	if not hostile:
		for child in dog_sprite_group.get_children():
			if child.has_method("set_visible"):
				child.set_visible(true)

func _on_interactable_clicked(button: int) -> void:
	if hostile:
		Game.die(Game.DeathCauses.DOG)
		return
	if Game.active_item ==  null or Game.active_item == knife_item:
		Game.die(Game.DeathCauses.DOG)
	elif Game.active_item == meat_item:
		queue_free()
		Game.consume_active_item()
		Game.active_item = load("uid://dcr0oiel6gb4a") #key item
