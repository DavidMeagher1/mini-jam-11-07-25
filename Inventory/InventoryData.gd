class_name InventoryData extends Resource

var items: Array[ItemData] = []

# Making basic inventory management functions
# These are separate from the array to allow for future logic
func add_item(item: ItemData) -> void:
    items.append(item)
    emit_changed()

func remove_item(item: ItemData) -> void:
    items.erase(item)
    emit_changed()

func has_item(item: ItemData) -> bool:
    return items.has(item)
