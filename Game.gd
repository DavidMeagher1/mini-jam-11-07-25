extends Node

enum DeathCauses {
	UNKNOWN,
	MURDERER,
	DOG,
	SUICIDE_KNIFE_HEAD,
	SUICIDE_HOLE,
	SUICIDE_FIRE_HOLE
}

enum Endings {
	LOVE,
	LOSS,
	DEATH,

}

var puff_scene: PackedScene = preload("res://Props/Puff/Puff.tscn")
var head_item: ItemData = preload("uid://cr4vs30alatux")

signal start()
signal end(ending: Endings)
signal active_item_changed(item: ItemData) # Emitted when the active item changes
signal impact(noise: float) # Will add noise to the noise bar
signal noise_changed(noise_level: float) # Emitted when the noise level changes
signal too_loud() # Emitted when the player makes too much noise
signal died() # Emitted when the player dies
signal item_crafted(itemA: ItemData, itemB: ItemData, result: ItemData) # Emitted when an item is crafted


var is_dead: bool = false
var deaths: int = 0
var deaths_by: Dictionary[DeathCauses, int] = {}
var inventory: InventoryData = InventoryData.new()
var active_item: ItemData = null:
	get:
		if cursor:
			return cursor.current_item
		return null
	set(value):
		if cursor:
			grab_item(value)

var game_state: Dictionary = {}

@onready var cursor: Area2D = %Cursor


func _ready() -> void:
	inventory.add_item(head_item) # Head

func has_item(item: ItemData) -> bool:
	return inventory.has_item(item) or (active_item == item)

func grab_item(item: ItemData, from_inventory: bool = false) -> void:
	if active_item:
		drop_item()
	cursor.current_item = item
	active_item_changed.emit(item)
	if item and from_inventory:
		inventory.remove_item(item)

func drop_item() -> void:
	if cursor.current_item:
		inventory.add_item(cursor.current_item)
		cursor.current_item = null

func craft_with_active_item(item: ItemData) -> ItemData:
	var recipe_output = active_item.get_crafted_item(item)
	var last_active_item = active_item
	if recipe_output:
		consume_active_item()
		inventory.remove_item(item)
		inventory.add_item(recipe_output)
		Game.item_crafted.emit(last_active_item, item, recipe_output)
	return recipe_output

func consume_active_item() -> void:
	if cursor.current_item:
		cursor.current_item = null

func spawn_puff(parent: Node, position: Vector2) -> void:
	var puff_instance = puff_scene.instantiate()
	if puff_instance:
		puff_instance.global_position = position
		parent.add_child(puff_instance)

func die(from: DeathCauses = DeathCauses.UNKNOWN) -> void:
	if is_dead:
		return
	is_dead = true
	deaths += 1
	if not deaths_by.has(from):
		deaths_by[from] = 0
	deaths_by[from] += 1
	if not Game.has_item(head_item):
		inventory.add_item(head_item)
	died.emit()
	end.emit(Endings.DEATH)

func reload() -> void:
	is_dead = false
	get_tree().reload_current_scene()

func _on_item_crafted(itemA: ItemData, itemB: ItemData, result: ItemData) -> void:
	if itemA.name == "Knife" or itemB.name == "Knife":
		if itemA.name == "Head" or itemB.name == "Head":
			die.call_deferred(DeathCauses.SUICIDE_KNIFE_HEAD)
