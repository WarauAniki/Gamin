extends Area2D

@onready var player: CharacterBody2D = $Player
@onready var slime: Node2D = $Slime

func _ready():
	player.can_move_player = false
	slime.can_move_slime = false

# In Main Fight Mechanic need to create 2 signals:
# 	When the Answer is correct:
#		Slme looses HP
#		Player attack is administered
# 	When the Answer is incorrect
#		Player looses HP
#		Slime attack is administered
