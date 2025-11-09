extends Node2D

enum DogState {
	HOSTILE,
	FRIENDLY,
	FED
}

const knife_item: ItemData = preload("uid://006mkxspmx88")
const meat_item: ItemData = preload("uid://c6m4thtcc8p1k")
const dog_toy_item: ItemData = preload("uid://e7n2xso3b2rc")

@onready var dog_sprite_group: CanvasGroup = $dog
@onready var point_light: PointLight2D = $PointLight2D

var state: DogState = DogState.HOSTILE

func _ready() -> void:
	if Game.has_item(meat_item):
		state = DogState.FRIENDLY
	elif Game.has_item(dog_toy_item):
		state = DogState.FED
	
	if state != DogState.HOSTILE:
		show_dog()
	point_light.visible = false

func _on_interactable_clicked(button: int) -> void:
	if Game.active_item == meat_item:
		Game.consume_active_item()
		state = DogState.FED
	
	if state != DogState.FED:
		attack()
	elif Game.active_item == dog_toy_item:
		Game.consume_active_item()
		Game.impact.emit(40.0)
	else:
		Game.grab_item(dog_toy_item)
		Game.impact.emit(20.0)
		

func attack() -> void:
	show_dog()
	point_light.visible = true
	dog_sprite_group.scale = Vector2(1.2, 1.2)
	var timer = get_tree().create_timer(0.2)
	await timer.timeout
	Game.die(Game.DeathCauses.DOG)

func show_dog() -> void:
	$dog/body.visible = true
