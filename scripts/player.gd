extends CharacterBody2D
class_name Player

@onready var polygon_controller: polygonController = $Polygon2D
@onready var line: Line2D = $Line2D
@onready var ray_cast: RayCast2D = $RayCast2D

@export var speed: float = 300.0
@export var tilt_strength: float = 0.3
@export var response_speed: float = 16.0

@export var slash_distance: float = 150.0

@export var current_state: State

var x_strength: float = 0.0
var inputVector: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	inputVector = Input.get_vector("left", "right", "up", "down").normalized()
	
	Render(delta)
	current_state.Update(self, delta)

func Render(delta: float):
	# sprites
	x_strength = lerp(x_strength, inputVector.x, response_speed * delta)
	polygon_controller.apply_skew(x_strength * tilt_strength)
	
	#line.set_point_position(1, ray_cast.target_position)
	
func changeState(newState: State):
	current_state.Exit(self)
	current_state = newState
	current_state.Enter(self)
