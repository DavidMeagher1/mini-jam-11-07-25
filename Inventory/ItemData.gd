class_name ItemData extends Resource

@export var name: String = ""
@export var icon: Texture2D
# we are input a, input b -> output
@export var recipes: Dictionary[ItemData,ItemData]

func can_craft_with(item: ItemData) -> bool:
    return recipes.has(item)

func get_crafted_item(item: ItemData) -> ItemData:
    return recipes[item] if can_craft_with(item) else null