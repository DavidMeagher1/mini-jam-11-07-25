extends ProgressBar

const NOISE_FALLOFF: float = 5.0
const BASIC_NOISE: float = 20.0

var noise_level: float = 0.0: set = set_noise_level
var react_timer: float = 0.0
var was_too_loud: bool = false

func set_noise_level(noise: float) -> void:
	if noise > noise_level:
		react_timer = 0.3
	noise_level = noise
	Game.noise_changed.emit(noise_level)
	if noise_level >= max_value and not was_too_loud:
		print("Player made too much noise!")
		was_too_loud = true
		Game.too_loud.emit()

func _ready() -> void:
	set_process_input(false)
	hide()
	Game.impact.connect(_on_impact)
	Game.start.connect(reset)
	Game.end.connect(_on_end)

func _on_impact(noise: float) -> void:
	if not visible:
		show()
	noise_level += noise
	var tween = create_tween()
	# Shake the bar to indicate noise impact
	tween.tween_property(self, "position", Vector2(1, 0), 0.05)
	tween.tween_property(self, "position", Vector2(-1, 0), 0.1)
	tween.tween_property(self, "position", Vector2(0, 0), 0.05)

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		_on_impact(BASIC_NOISE)

func _process(delta: float) -> void:
	if int(noise_level) != int(self.value):
		if noise_level > self.value:
			set_process(false)
			var tween = create_tween()
			tween.tween_property(self, "value", noise_level, 0.2).set_trans(Tween.TRANS_SINE)
			await tween.finished
			set_process(true)
		else:
			self.value = noise_level

	if noise_level >= max_value:
		set_process(false)
		# Fill the bar to max before stopping
		var tween = create_tween()
		tween.tween_property(self, "value", max_value, 0.2).set_trans(Tween.TRANS_SINE)
		return
	
	if react_timer > 0:
		react_timer -= delta
		return
	
	if noise_level > 0:
		noise_level = clamp(noise_level - NOISE_FALLOFF * delta, min_value, max_value)

func _on_end(_ending: int) -> void:
	hide()
	set_process(false)
	set_process_input(false)

func reset() -> void:
	if was_too_loud:
		show()
	print("Resetting Noise Bar on game end")
	noise_level = 0
	self.value = 0
	was_too_loud = false
	react_timer = 0.0
	set_process(true)
	set_process_input(true)
