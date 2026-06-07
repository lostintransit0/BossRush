extends State

@onready var moving: State = $"../MOVING"

func Update(player: Player, _delta: float):
	player.ray_cast.target_position = player.last_direction * player.slash_distance
	
	if not player.inputVector == Vector2.ZERO:
		player.changeState(moving)
		return
	
