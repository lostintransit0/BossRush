extends CharacterBody2D
class_name Player

@onready var polygon_controller: polygonController = $Polygon2D
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var progress_bar: ProgressBar = $Control/ProgressBar
@onready var bar_timer: Timer = $BarTimer

@export var speed: float = 300.0
@export var tilt_strength: float = 0.3
@export var response_speed: float = 16.0

@export var slash_distance: float = 150.0

@export var current_state: State

var x_strength: float = 0.0
var inputVector: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.RIGHT
var can_attack: bool = true

func _ready() -> void:
	current_state.Enter(self)

func _physics_process(delta: float) -> void:
	inputVector = Input.get_vector("left", "right", "up", "down").normalized()
	
	if bar_timer.is_stopped():
		progress_bar.hide()
		can_attack = true
	else:
		can_attack = false
		progress_bar.show()
		progress_bar.value = (1 - bar_timer.time_left) / bar_timer.wait_time * progress_bar.max_value
	
	current_state.Update(self, delta)

func Render(delta: float):
	# sprites
	x_strength = lerp(x_strength, inputVector.x, response_speed * delta)
	polygon_controller.apply_skew(x_strength * tilt_strength)
	
func changeState(newState: State):
	current_state.Exit(self)
	current_state = newState
	current_state.Enter(self)
