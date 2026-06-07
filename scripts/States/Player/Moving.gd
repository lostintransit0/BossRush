extends State

@onready var idle: State = $"../IDLE"
@onready var dashing: Node = $"../DASHING"

func Update(player: Player, delta: float):
	if Input.is_action_pressed("dash") and player.can_attack:
		player.ray_cast.target_position = player.inputVector * player.slash_distance
		player.changeState(dashing)
		return
		
	if player.inputVector == Vector2.ZERO:
		player.changeState(idle)
		return
	
	player.ray_cast.target_position = player.inputVector * player.slash_distance

	var targetVelocity = player.inputVector * player.speed

	player.velocity = targetVelocity
	
	player.Render(delta)
	
	player.move_and_slide()
	
	player.last_direction = player.inputVector
