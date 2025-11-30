extends CharacterBody2D

@onready var mining_area: TileMap = get_parent().get_node("MiningArea")

# Physics properties
const SPEED_HORIZONTAL = 120.0		# Ground and flight speed
const SPEED_FLIGHT = 100.0			# Upward propultion speed
const GRAVITY = 750.0				# Heavy gravity

# Fuel consumption
const FUEL_PER_SECOND_FLIGHT = 5.0	# Fuel cost for flight per second

# Heat
const HEAT_RATE_MINING = 1.0		# Heat generated per second when mining
const HEAT_RATE_FLIGHT = 0.5		# Heat generated per second when flying
const HEAT_DISSIPATION = 2.0		# Heat reduced per second when idle
const HEAT_DAMAGE_THRESHOLD = 80.0	# Threshold for starting taking damages
const HEAT_DAMAGE_RATE = 5.0		# Damages taken per second when above threshold

# Mining function
func mine_tile():
	# Dig below
	var target_pos = global_position + Vector2(0, 48)
	
	# Convert World coordinates to grid (TileMap)
	var drill_tile_pos = mining_area.local_to_map(target_pos)
	
	# Check if tile exists at the position
	if mining_area.get_cell_source_id(0, drill_tile_pos) != -1:
		# Remove tile
		mining_area.erase_cell(0, drill_tile_pos)
		
		# TODO -> fuel consumption
		
# Damages function
func take_damage(amount: float):
	Economy.current_hp -= amount
	
	if Economy.current_hp <= 0:
		Economy.current_hp = 0
		print("GAME OVER - Drill destroyed !")
		
		# TODO -> End logic

# Moving function
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
	if Input.is_action_pressed("ui_up") and Economy.current_fuel > 0:
		# Flight up while button is pressed
		velocity.y = -SPEED_FLIGHT
		# Fuel consumption
		Economy.consume_fuel(FUEL_PER_SECOND_FLIGHT * delta)
	elif Input.is_action_pressed("ui_up") and Economy.current_fuel <= 0:
		# No fuel, no propulsion
		pass
	
	# Mining
	if Input.is_action_pressed("ui_accept"):
		mine_tile()
		
	# Heat and damages
	var is_active = Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept")
	
	if is_active and Economy.current_fuel > 0:
		# Add heat when flying or mining
		var heat_increase = 0.0
		if Input.is_action_pressed("ui_up"):
			heat_increase = HEAT_RATE_FLIGHT
		if Input.is_action_pressed("ui_accept"):
			heat_increase += HEAT_RATE_MINING
			
		Economy.current_heat = clampf(Economy.current_heat + heat_increase * delta, 0, Economy.max_heat)
	else:
		# Reduce heat
		Economy.current_heat = clampf(Economy.current_heat - HEAT_DISSIPATION * delta, 0, Economy.max_heat)
		
	# Damages by overheating
	if Economy.current_heat >= HEAT_DAMAGE_THRESHOLD:
		var damage_amount = HEAT_DAMAGE_RATE * delta
		take_damage(damage_amount)
	
	
	# Movement
	move_and_slide()


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
