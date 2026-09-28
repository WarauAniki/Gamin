extends Area2D

#func _start_battle() -> void:
#	var game_root = owner.get_parent()
#	if game_root.has_method("go_to_battle"):
#		game_root.go_to_battle
#	else:
#		push_error("Ошибка: Родительский узел не является узлом Game или не имеет метода go_to_battle!")


#Player gets into collision and the current scene starts anew
func _on_body_entered(body: Node2D) -> void:
	print("You died")
	get_tree().reload_current_scene()
#	_start_battle()
