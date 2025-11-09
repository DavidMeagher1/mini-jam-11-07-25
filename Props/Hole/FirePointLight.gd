extends PointLight2D

var time_passed:float = 0.0

var flicker:bool = false
var flicker_range:float = 0.4

func _process(delta: float) -> void:
    if flicker:
        scale = Vector2(4, 4)
    else:
        scale = Vector2(3.5, 3.5)
    time_passed += delta
    if time_passed >= randf_range(0, flicker_range):
        time_passed = 0.0
        flicker = !flicker