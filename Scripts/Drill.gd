extends CharacterBody2D

# Physics properties
const SPEED_HORIZONTAL = 120.0		# Ground and flight speed
const SPEED_FLIGHT = 100.0			# Upward propultion speed
const GRAVITY = 750.0				# Heavy gravity

func _physics_process(delta: float):
	# Use gravity if player is not on the ground
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	# Horizontal movements
	var directionX = Input.get_axis("ui_left", "ui_right")
	
	if directionX:
		velocity.x = directionX * SPEED_HORIZONTAL
	else:
		# Slow speed down
		velocity.x = move_toward(velocity.x, 0, SPEED_HORIZONTAL)
	
	# Vertical movements
	if Input.is_action_pressed("ui_up"):
		# Flight up while button is pressed
		velocity.y = -SPEED_FLIGHT
		
		# TODO
		# Fuel consumptions function here
		
	# Movement application
	move_and_slide()
