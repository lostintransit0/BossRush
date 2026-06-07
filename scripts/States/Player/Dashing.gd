extends State

var passed_time: float = 0
var target_time: float = 0.1
var target_location: Vector2 = Vector2.ZERO
var origin_location: Vector2 = Vector2.ZERO
const Fade = preload("uid://iy1qe4k37k44")

var current_after_image_count: int = 0
var target_after_image_count: int = 4

@onready var idle: Node = $"../IDLE"
@onready var polygon_2d: polygonController = $"../../Polygon2D"

func Enter(player: Player):
	if player.ray_cast.is_colliding():
		target_location = player.ray_cast.get_collision_point()
	else:
		target_location = player.to_global(player.ray_cast.target_position)
	
	origin_location = player.position
	
	print(target_location)
	print(origin_location)
	
func Update(player: Player, delta: float):
	passed_time += delta
	player.position = interpolate_pos(origin_location, target_location, passed_time/target_time)
	
	if passed_time/target_time >= 1:
		player.changeState(idle)
		return
	
	while passed_time/target_time > float(current_after_image_count)/float(target_after_image_count):
		current_after_image_count += 1
		var after_image = polygon_2d.duplicate()
		after_image.set_script(Fade)
		
		after_image.modulate.a = 0.3
		after_image.color = Color.WHITE
		after_image.z_index = -1
		
		get_tree().current_scene.add_child(after_image)
		after_image.global_position = interpolate_pos(origin_location, target_location, float(current_after_image_count)/float(target_after_image_count))
		
func interpolate_pos(origin: Vector2, target: Vector2, t: float) -> Vector2:
	return origin.lerp(target, clamp(t, 0.0, 1.0))

func Exit(player: Player):
	passed_time = 0
	current_after_image_count = 0
	player.bar_timer.start()
	player.position = target_location
