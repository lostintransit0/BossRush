extends State

@onready var moving: State = $"../MOVING"
@onready var dashing: Node = $"../DASHING"

func Update(player: Player, delta: float):
	player.ray_cast.target_position = player.last_direction * player.slash_distance
	
	if Input.is_action_pressed("dash") and player.can_attack:
		player.changeState(dashing)
		return

	if not player.inputVector == Vector2.ZERO:
		player.changeState(moving)
		return
	
	player.Render(delta)
