extends Node
#REWRITE!!!!!!!

#@onready var player: CharacterBody2D = $Player


# Предварительно загружаем сцены в память
const OPEN_WORLD_SCENE = preload("res://scenes/open_world.tscn")
const BATTLE_SCENE = preload("res://scenes/battle.tscn")

# Переменная для хранения текущей активной сцены
var current_scene: Node = null

func _ready() -> void:
	# При запуске игры по умолчанию загружаем открытый мир
	_switch_to_scene(OPEN_WORLD_SCENE)

# Главная функция для смены сцен
func _switch_to_scene(new_scene_resource: PackedScene) -> void:
	if current_scene != null:
		current_scene.queue_free()
	current_scene = new_scene_resource.instantiate()
	add_child(current_scene)
	
	#print("1 Slime: ", slime)
#	print("2 Encounter: ", encounter)
#	print("3 has signal ", encounter.has_signal("to_the_battle"))
	
#	if encounter.has_signal("to_the_battle"):
#		encounter.to_the_battle.connect(go_to_battle)
#		print("4 signal connected")
#	print("signal exists: ", encounter.has_signal("to_the_battle"))
#	print("Encounter_path: ", encounter.get_path())
	
	#var slime = current_scene.get_node_or_null("slime")
	#print("Current_scene: ", current_scene)
	#print("Slime: ", slime)
	
	#if slime != null:
	#	var encounter = current_scene.get_node_or_null("encounter")
	#	print("Encounter: ", encounter)
		
	#	if encounter != null:
	#		encounter.to_the_battle.connect(go_to_battle)
			
#	var encounter = current_scene.find_child("Encounter", true, false)
#	if encounter == null:
#		print("Not found")
#	else:
#		print("Found it: ", encounter)
#		encounter.to_the_battle.connect(go_to_battle)

	if new_scene_resource == OPEN_WORLD_SCENE:
	#	var slime = current_scene.get_child(2)
	#	var encounter = slime.get_child(3)

	#	var slime2 = current_scene.get_child(4)
	#	var encounter2 = slime2.get_child(3)
		
	#	encounter.to_the_battle.connect(go_to_battle)
	#	encounter2.to_the_battle.connect(go_to_battle)
		for slime in current_scene.get_children():
			if slime.name == "Slime" or slime.name == "Slime2":
				var encounter = slime.get_child(3)
				encounter.to_the_battle.connect(go_to_battle)

	if new_scene_resource == BATTLE_SCENE:
		var main_problem = current_scene.get_child(5)
		var lost_the_battle = main_problem.get_child(0)
		lost_the_battle.death.connect(go_to_open_world)


# Функции-помощники для вызова из других мест
func go_to_battle() -> void:
#	print("game signal recived")
#	player.can_move = false
	_switch_to_scene(BATTLE_SCENE)

func go_to_open_world() -> void:
#	player.can_move = true
	_switch_to_scene(OPEN_WORLD_SCENE)
