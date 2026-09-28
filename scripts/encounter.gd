extends Area2D

@onready var timer: Timer = $Timer

signal to_the_battle

func _on_body_entered(body: Node2D) -> void:
#	body.get_node("CollisionShape2D").queue_free()
#	print("Fight!", body.name)
	if body.name != "Player":
		return
	timer.start()
	
func _on_timer_timeout():
#	print("Signal emit")
	to_the_battle.emit()
#create signal to the battle
#	get_tree().reload_current_scene()
