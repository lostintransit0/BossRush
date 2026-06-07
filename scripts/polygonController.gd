extends Polygon2D
class_name polygonController

var base_polygon: PackedVector2Array

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
