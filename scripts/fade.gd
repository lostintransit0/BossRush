extends Node2D

@export var fade_speed: float = 1.0
var alpha: float

func _ready():
	alpha = modulate.a

func _process(delta):
	alpha -= fade_speed * delta
	modulate.a = alpha
	
	if alpha <= 0:
		queue_free()
