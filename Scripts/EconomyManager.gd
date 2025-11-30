extends Node

# --- Gauges and statistics for the current run ---

var current_fuel: float = 100.0
var max_fuel: float = 100.0

var current_hp: float = 100.0
var max_hp: float = 100.0

var current_heat: float = 0.0
var max_heat: float = 100.0

# --- Persisting currencies ---
var common_currency: int = 0 	# Classic currency
var rare_currency: int = 0		# Rare currency

# Function to reduce fuel
func consume_fuel(amount: float):
	current_fuel -= amount
	if current_fuel <= 0:
		current_fuel = 0
		print("GAME OVER - Fuel depleted")
