extends Polygon2D

var base_polygon: PackedVector2Array

var x_strength: float = 0.0

@export var tilt_strength: float = 0.5
@export var response_speed: float = 8.0

func _ready() -> void:
	base_polygon = polygon.duplicate()

func reset_skew() -> void:
	polygon = base_polygon.duplicate()

func apply_skew(strength: float) -> void:
	reset_skew()
	var p = polygon

	for i in range(p.size()):
		var point = p[i]

		point.x += point.y * -strength

		p[i] = point

	polygon = p


func _process(delta: float) -> void:
	var inputVector = Input.get_vector("left", "right", "up", "down").normalized()

	x_strength = lerp(x_strength, inputVector.x, response_speed * delta)

	apply_skew(x_strength * tilt_strength)
