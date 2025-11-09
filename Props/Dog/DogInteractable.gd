extends Node2D

enum DogState {
	HOSTILE,
	FRIENDLY,
	FED
}

const knife_item: ItemData = preload("uid://006mkxspmx88")
const meat_item: ItemData = preload("uid://c6m4thtcc8p1k")
const dog_toy_item: ItemData = preload("uid://e7n2xso3b2rc")
const poop_item: ItemData = preload("uid://deuh5tpgie1jl")

@onready var dog_sprite_group: CanvasGroup = $dog
@onready var point_light: PointLight2D = $PointLight2D

var state: DogState = DogState.HOSTILE

func _ready() -> void:
	if Game.has_item(meat_item):
		state = DogState.FRIENDLY
	if Game.has_item(dog_toy_item):
		state = DogState.FED
	
	if state != DogState.HOSTILE:
		show_dog()
	point_light.visible = false
	Game.end.connect(_on_game_end)

func _on_game_end(ending: int) -> void:
	if ending == Game.Endings.LOSS:
		show_dog()
		point_light.visible = true
		dog_sprite_group.scale = Vector2(1.2, 1.2)

func _on_interactable_clicked(button: int) -> void:
	if Game.active_item == meat_item:
		if state == DogState.FED:
			Game.consume_active_item()
			Game.grab_item(poop_item, true)
			Game.impact.emit(30.0)
			return
		else:
			Game.consume_active_item()
			state = DogState.FED
	
	if Game.active_item == knife_item || state != DogState.FED:
		attack()
		return
	
	if Game.active_item == dog_toy_item:
		Game.consume_active_item()
		Game.impact.emit(50.0)
	else:
		Game.grab_item(dog_toy_item, true)
		Game.impact.emit(30.0)
		

func attack() -> void:
	show_dog()
	point_light.visible = true
	dog_sprite_group.scale = Vector2(1.2, 1.2)
	var timer = get_tree().create_timer(0.2)
	await timer.timeout
	Game.die(Game.DeathCauses.DOG)

func show_dog() -> void:
	$dog/body.visible = true
