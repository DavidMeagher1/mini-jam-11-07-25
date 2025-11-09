extends Node2D

var knife_item: ItemData = preload("uid://006mkxspmx88")
var meat_item: ItemData = preload("uid://c6m4thtcc8p1k")
@onready var dog_sprite_group: CanvasGroup = $dog
@onready var point_light: PointLight2D = $PointLight2D

var hostile: bool = true

func _ready() -> void:
    if Game.has_item(meat_item):
        hostile = false
        show_dog()
    point_light.visible = false

func _on_interactable_clicked(button: int) -> void:
    if hostile:
        attack()
        return
    if Game.active_item == meat_item:
        queue_free()
        Game.consume_active_item()
        Game.active_item = load("uid://dcr0oiel6gb4a") # key item
    else:
        attack()

func show_dog() -> void:
    for child in dog_sprite_group.get_children():
        if child.has_method("set_visible"):
            child.set_visible(true)

func attack() -> void:
    show_dog()
    point_light.visible = true
    dog_sprite_group.scale = Vector2(1.2, 1.2)
    var timer = get_tree().create_timer(0.2)
    await timer.timeout
    Game.die(Game.DeathCauses.DOG)