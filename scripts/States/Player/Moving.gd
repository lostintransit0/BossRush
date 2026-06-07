extends State

@onready var idle: State = $"../IDLE"

func Update(player: Player, _delta: float):
	if player.inputVector == Vector2.ZERO:
		player.changeState(idle)
		return
	
	player.ray_cast.target_position = player.inputVector * player.slash_distance

	var targetVelocity = player.inputVector * player.speed

	player.velocity = targetVelocity
	player.move_and_slide()
	
	player.last_direction = player.inputVector
