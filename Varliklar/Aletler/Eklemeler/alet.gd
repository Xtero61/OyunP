extends Node2D

var durum = DEVIN

onready var animasyonAgaci = $AnimationTree
onready var animasyonDurumu = animasyonAgaci.get("parameters/playback")
onready var oyuncu = get_parent()

enum{
	DEVIN,
	SALDIR,
	OL
}

func _physics_process(delta) :
	match durum :
		DEVIN :
			devin_durum(delta)
		SALDIR :
			saldir_durum()
		OL:
			pass

func devin_durum(delta) :
	var input_vector = oyuncu.getir_hareket_vektoru()
	var run = oyuncu.getir_kosuyor()

	if run :
		animasyonAgaci.set("parameters/Saldırı/blend_position", input_vector)
		animasyonAgaci.set("parameters/Duruş/blend_position", input_vector)
		animasyonAgaci.set("parameters/Yürüme/blend_position", input_vector)
		animasyonDurumu.travel("Yürüme")

	else :
		animasyonDurumu.travel("Duruş")

	if Input.is_action_pressed("Saldırı"):
		durum = SALDIR

func saldir_durum():
	animasyonDurumu.travel("Saldırı")

func attack_Move():
	durum = DEVIN

func nesne_sil():
	queue_free()
