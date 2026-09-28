extends Label

@onready var problem: Label = $"."
@onready var var_1: Label = $"Var 1"
@onready var var_2: Label = $"Var 2"
#@onready var button_2: Button = $"../Button 2"

@onready var slime_attack: Node2D = $SlimeAttack
@onready var slime_attack_movment: AnimationPlayer = $SlimeAttack/Slime_Attack_Movment
@onready var animated_slime_attack: AnimatedSprite2D = $SlimeAttack/AnimatedSprite2D

@onready var health_bar: ProgressBar = $HealthBar

var Problem_Library = ["1+1", "2+2", "3+3","4+4", "5+5", "6+6", "7+7", "8+8", "9+9"]
var Answer_Library = [ "2", "4", "6", "8", "10", "12", "14", "16", "18"]

var num_of_problem_shuffler = 0
var incorrect_answer_shuffler = 0
var correct_answer = 0
var incorrect_answer = 0
var eveness_check = 0
var my_button_is_pressed = false
var answer_arrangment = 3

var hp = 3

signal death

var button = 0

func _Quiz():
	# Takes random question from Problem_Library
	num_of_problem_shuffler = randi_range(0, Problem_Library.size() - 1)
	incorrect_answer_shuffler = randi_range(0, Problem_Library.size() - 1)
	# In case they match
	while num_of_problem_shuffler == incorrect_answer_shuffler:
		incorrect_answer_shuffler = randi_range(0, Problem_Library.size() - 1)
	eveness_check = randi()
	
	problem.text = Problem_Library[num_of_problem_shuffler]
	
	correct_answer = Answer_Library[num_of_problem_shuffler]
	incorrect_answer = Answer_Library[incorrect_answer_shuffler]
	
	# Check by even numbers, if EVEN Var1 - correct, Var2 - incorrect. Esle IF UNEVEN- vise versa
	if eveness_check % 2 == 0:
		var_1.text = correct_answer
		var_2.text = incorrect_answer
		answer_arrangment = 1
	elif eveness_check % 2 != 0:
		var_1.text = incorrect_answer
		var_2.text = correct_answer
		answer_arrangment = 2


func _ready() -> void:
#	pass # Replace with function body.
	_Quiz()
	slime_attack.visible = false
	animated_slime_attack.play("new_animation")	#Have no idea why is this needed,but animation doesn't work as needed
	health_bar.value = hp


func _process(delta: float) -> void:
	
#	_Setting_the_Answer()	
	if button == answer_arrangment:
		print("Correct One!")
		button = 0
		my_button_is_pressed = false
		_Quiz()
		slime_attack.visible = false
	elif button != answer_arrangment and my_button_is_pressed == true:
		my_button_is_pressed = false
		print("Sorry, Inorrect One!")
		slime_attack.visible = true
		slime_attack_movment.play("slime_attack")
		animated_slime_attack.animation_finished.connect(_on_animation_finished)
		animated_slime_attack.play("new_animation")
		



func _on_animation_finished():
	if hp != 0:
		hp -= 1
		health_bar.value = hp
	else:
		death.emit()
		print("You died")
		#go_to_open_world
		#emit signal to the Game Scene and make it change to Open World scene

func _on_button_1_pressed() -> void:
	button = 1
	my_button_is_pressed = true
#	print("button_is_pressed")

func _on_button_2_pressed() -> void:
	button = 2
	my_button_is_pressed = true
#	print("button_is_pressed")
