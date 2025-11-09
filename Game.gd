extends Node

var puff_scene: PackedScene = preload("res://Props/Puff/Puff.tscn")

signal impact(noise: float) # Will add noise to the noise bar
signal noise_changed(noise_level: float) # Emitted when the noise level changes
signal too_loud() # Emitted when the player makes too much noise


var deaths: int = 0
var inventory: InventoryData = InventoryData.new()
var active_item: ItemData = null:
	get:
		if cursor:
			return cursor.current_item
		return null
	set(value):
		if cursor:
			grab_item(value)

@onready var cursor: Area2D = %Cursor


func _ready() -> void:
	# For testing purposes, give the player a key at start
	inventory.add_item(load("uid://dcr0oiel6gb4a"))
	inventory.add_item(load("uid://dcr0oiel6gb4a"))
	inventory.add_item(load("uid://cr4vs30alatux"))

func has_item(item: ItemData) -> bool:
	return inventory.has_item(item)

func grab_item(item: ItemData, from_inventory: bool = false) -> void:
	if active_item:
		drop_item()
	cursor.current_item = item
	if item and from_inventory:
		inventory.remove_item(item)

func drop_item() -> void:
	if cursor.current_item:
		inventory.add_item(cursor.current_item)
		cursor.current_item = null

func craft_with_active_item(item: ItemData) -> ItemData:
	var recipe_output = active_item.get_crafted_item(item)
	if recipe_output:
		consume_active_item()
		inventory.remove_item(item)
		inventory.add_item(recipe_output)
	return recipe_output

func consume_active_item() -> void:
	if cursor.current_item:
		cursor.current_item = null

func spawn_puff(parent: Node, position: Vector2) -> void:
	var puff_instance = puff_scene.instantiate()
	if puff_instance:
		puff_instance.global_position = position
		parent.add_child(puff_instance)
