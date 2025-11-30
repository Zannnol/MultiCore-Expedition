extends Control

# Bars references
@onready var fuel_bar: TextureProgressBar = $Gauges/FuelBar
@onready var health_bar: TextureProgressBar = $Gauges/HealthBar
@onready var heat_bar: TextureProgressBar = $Gauges/HeatBar

func _process(delta: float) -> void:
	# Link bars values to EconomyManager
	fuel_bar.value = Economy.current_fuel
	fuel_bar.max_value = Economy.max_fuel
	
	health_bar.value = Economy.current_hp
	health_bar.max_value = Economy.max_hp
	
	heat_bar.value = Economy.current_heat
	heat_bar.max_value = Economy.max_heat
