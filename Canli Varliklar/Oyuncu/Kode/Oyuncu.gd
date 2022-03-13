extends KinematicBody2D

const ACCELERATION = 700
const MAX_SPEED = 120
const FRICTION = 500
const ROLL_SPEED = 225

var El: bool = false
var El_Esya
var movement_vector : Vector2 = Vector2.ZERO
var run : bool = false
var velocity: Vector2 = Vector2.ZERO
var state : int = IDLE
var max_dist : int = 12

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var collision = $Position2D/Hitbox/CollisionShape2D
onready var balta = preload("res://Varliklar/Aletler/Balta/Balta.tscn")
onready var kazma = preload("res://Varliklar/Aletler/Kazma/Kazma.tscn")

enum{
	IDLE,
	MOVE,
	ATTACK,
	DEATH,
	ROLL
}

enum{
	KAZMA,
	BALTA,
	KILIC,
}

func _physics_process(delta):
	pass

func _process(delta):
	match state :
		IDLE:
			idle_state(delta)
		MOVE :
			move_state(delta)
		ATTACK :
			attack_state(delta)
			return
		ROLL :
			pass
#			roll_state(delta)
		DEATH:
			pass
	tuslari_kontrol_et()
	
func idle_state(delta):
	if !El:
		animationTree.set("parameters/Duruş/blend_position", movement_vector)
		animationState.travel("Duruş")
	else :
		animationTree.set("parameters/Duruşels/blend_position", movement_vector)
		animationState.travel("Duruşels")

	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)


func move_state(delta) :
	animationTree.set("parameters/Yürüme/blend_position", movement_vector)
	animationTree.set("parameters/Yürümels/blend_position", movement_vector)
	if !El:
		animationState.travel("Yürüme")
	else :
		animationState.travel("Yürümels")

	velocity = velocity.move_toward(movement_vector * MAX_SPEED, ACCELERATION * delta)
	move()

func attack_state(delta):
	animationTree.set("parameters/Saldırıels/blend_position", movement_vector)
	animationState.travel("Saldırıels")

func attack_Move():
	state = IDLE 

func move():
	velocity = move_and_slide(velocity)

func degistirAlet(alet):
	match alet:
		KAZMA:
			if El:
				El_Esya.nesne_sil()
			El_Esya = kazma.instance()
			get_node(".").add_child(El_Esya)
			El = true
		BALTA:
			if El:
				El_Esya.nesne_sil()
				
			El_Esya = balta.instance()
			get_node(".").add_child(El_Esya)
			El = true
		KILIC:
			pass

func tuslari_kontrol_et():
	if Input.is_action_pressed("Saldırı") and El:
		state = ATTACK
		return

	var movement : Vector2 = Vector2.ZERO
	movement.x = Input.get_action_strength("SağaYürüme") - Input.get_action_strength("SolaYürüme")
	movement.y = Input.get_action_strength("AşağıYürüme") - Input.get_action_strength("YukarıYürüme")
	movement = movement.normalized()

	if movement != Vector2.ZERO:
		movement_vector = movement
		run = true
		state = MOVE
	else:
		run = false
		state = IDLE

	if Input.is_action_just_pressed("he_1"):
		degistirAlet(KAZMA)
	elif Input.is_action_just_pressed("he_2"):
		degistirAlet(BALTA)

func get_movement_vector() -> Vector2:
	return movement_vector
	
func get_run_state() -> bool:
	return run
