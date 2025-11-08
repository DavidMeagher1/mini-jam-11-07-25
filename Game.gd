extends Node

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

func consume_active_item() -> void:
	if cursor.current_item:
		cursor.current_item = null
