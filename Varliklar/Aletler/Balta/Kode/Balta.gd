extends Node2D

var state = MOVE

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var player = get_parent()

enum{
	MOVE,
	ATTACK,
	DEATH
}

func _physics_process(delta) :
	match state :
		MOVE :
			move_state(delta)
		ATTACK :
			attack_state()
		DEATH:
			pass

func move_state(delta) :
	var input_vector = player.get_movement_vector()
	var run = player.get_run_state()

	if run :
		animationTree.set("parameters/Saldırı/blend_position", input_vector)
		animationTree.set("parameters/Duruş/blend_position", input_vector)
		animationTree.set("parameters/Yürüme/blend_position", input_vector)
		animationState.travel("Yürüme")

	else :
		animationState.travel("Duruş")

	if Input.is_action_pressed("Saldırı"):
		state = ATTACK

func attack_state():
	animationState.travel("Saldırı")

func attack_Move():
	state = MOVE

func nesne_sil():
	queue_free()
