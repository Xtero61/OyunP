extends Node2D

var state = MOVE

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

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

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("SağaYürüme") - Input.get_action_strength("SolaYürüme")
	input_vector.y = Input.get_action_strength("AşağıYürüme") - Input.get_action_strength("YukarıYürüme")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO :
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
