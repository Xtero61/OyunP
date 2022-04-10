extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func dusme_hareketi_baslat():
	$Sprite.scale = Genel.DUNYA_OLCEGI
	$CollisionShape2D.disabled = false
	var randx = (randi() % 3 - 1) * Genel.ESYA_DUSME_RASTGELE_KUVVET
	var randy = (randi() % 3 - 1) * Genel.ESYA_DUSME_RASTGELE_KUVVET
	mode = MODE_RIGID
	apply_central_impulse(Vector2.ONE)
	apply_impulse(Vector2(randx, randy), Vector2(-randx, -randy))
