extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("he_0"):
		$AnimationPlayer.play("sec0")
	elif Input.is_action_just_pressed("he_1"):
		$AnimationPlayer.play("sec1")
	elif Input.is_action_just_pressed("he_2"):
		$AnimationPlayer.play("sec2")
	elif Input.is_action_just_pressed("he_3"):
		$AnimationPlayer.play("sec3")
	elif Input.is_action_just_pressed("he_4"):
		$AnimationPlayer.play("sec4")
	elif Input.is_action_just_pressed("he_5"):
		$AnimationPlayer.play("sec5")
	elif Input.is_action_just_pressed("he_6"):
		$AnimationPlayer.play("sec6")
	elif Input.is_action_just_pressed("he_7"):
		$AnimationPlayer.play("sec7")
	elif Input.is_action_just_pressed("he_8"):
		$AnimationPlayer.play("sec8")
	elif Input.is_action_just_pressed("he_9"):
		$AnimationPlayer.play("sec9")
