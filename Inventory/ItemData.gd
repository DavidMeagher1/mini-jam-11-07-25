class_name ItemData extends Resource

@export var name: String = ""
@export var icon: Texture2D
# we are input a, input b -> output
@export var recipes: Dictionary[ItemData, ItemData]

func get_crafted_item(item: ItemData) -> ItemData:
    return recipes.get(item, item.recipes.get(self, null))