class_name InventoryData extends Resource

var items: Array[Item] = []

# Making basic inventory management functions
# These are separate from the array to allow for future logic
func add_item(item: Item) -> void:
    items.append(item)

func remove_item(item: Item) -> void:
    items.erase(item)

func has_item(item: Item) -> bool:
    return items.has(item)
