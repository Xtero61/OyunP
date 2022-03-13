extends KinematicBody2D

const ACCELERATION = 700
const MAX_SPEED = 120
const FRICTION = 500
const ROLL_SPEED = 225

var El = "Dolu"
var roll_vector = Vector2.DOWN
var velocity = Vector2.ZERO
var state = MOVE 
var max_dist = 12

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var colliision = $Position2D/Hitbox/CollisionShape2D

enum{
	MOVE,
	ATTACK,
	DEATH,
	ROLL
}

func _physics_process(delta):
	match state :
		MOVE :
			move_state(delta)
		ATTACK :
			attack_state()
		ROLL :
			pass
#			roll_state(delta)
		DEATH:
			pass

func _process(delta):
	pass
#	var mousepositoion = get_local_mouse_position()
#	var dir = Vector2.ZERO.direction_to(mousepositoion)
#	var dist = mousepositoion.length()
#	$Position2D/Hitbox/CollisionShape2D.position = dir * min(dist,max_dist)
#	$Position2D/Hitbox/CollisionShape2D.rotation = mousepositoion.angle()
#	#rotation+= mousepositoion.angle() * 0.1

func move_state(delta) :
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("SağaYürüme") - Input.get_action_strength("SolaYürüme")
	input_vector.y = Input.get_action_strength("AşağıYürüme") - Input.get_action_strength("YukarıYürüme")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO :
		roll_vector = input_vector
		animationTree.set("parameters/Duruş/blend_position", input_vector)
		animationTree.set("parameters/Yürüme/blend_position", input_vector)
		animationTree.set("parameters/Duruşels/blend_position", input_vector)
		animationTree.set("parameters/Yürümels/blend_position", input_vector)
		animationTree.set("parameters/Saldırıels/blend_position", input_vector)
#		animationTree.set("parameters/Yuvarlanma/blend_position", input_vector)
#		yumruk_yonu()

		if El == "Boş" :
			animationState.travel("Yürüme")
		else :
			animationState.travel("Yürümels")

		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)

	else :
#		yumruk_yonu()

		if El == "Boş" :
			animationState.travel("Duruş")
		else :
			animationState.travel("Duruşels")

		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()
	
	if El != "Boş" :
		if Input.is_action_pressed("Saldırı"):
			velocity = Vector2.ZERO
			state = ATTACK

func attack_state():
	animationState.travel("Saldırıels")

func attack_Move():
	state = MOVE
#	if Input.is_action_just_pressed("Yuvarlanma"):
#		state = ROLLd
#func yumruk_yonu():
#	var mousepositoion = get_local_mouse_position()
#	var dir = Vector2.ZERO.direction_to(mousepositoion)
#	animationTree.set("parameters/Yumruk/blend_position", dir)

func move():
	velocity = move_and_slide(velocity)

#func roll_state(delta):
#	velocity = roll_vector * ROLL_SPEED
#	animationState.travel("Yuvarlanma")
#	move()

#func _YuvarlanmaB() :
#	velocity = velocity * 0.3
#	state = MOVE

