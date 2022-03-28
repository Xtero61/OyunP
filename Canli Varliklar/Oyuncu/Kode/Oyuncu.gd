extends KinematicBody2D

const HIZLANMA = 700
const MAKS_HIZ = 120
const SURTUNME = 500
const TAKLA_HIZ = 225

var elde_esya_var: bool = false # Elde esya var mi
var el_esya # Eldeki esya nesnesi
var hareket_vektoru : Vector2 = Vector2.ZERO # Hareket vektörü
var kosuyor : bool = false # Karakter kosuyor mu
var ivme: Vector2 = Vector2.ZERO # İvme vektörü
var durum : int = DUR
var maks_mesafe : int = 12 

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var balta = load("res://Varliklar/Aletler/Balta/Balta.tscn")
onready var kazma = load("res://Varliklar/Aletler/Kazma/Kazma.tscn")

enum{
	DUR,
	DEVIN, # bkz. devinmek 
	SALDIR,
	OL,
	TAKLA
}

enum{
	BOS,
	KAZMA,
	BALTA,
	KILIC,
}

func _physics_process(delta):
	pass

func _process(delta):
	match durum:
		DUR:
			dur_durumu(delta)
		DEVIN :
			devin_durumu(delta)
		SALDIR :
			saldir_durumu(delta)
			return
		TAKLA :
			pass
		OL:
			pass
	tuslari_kontrol_et()
	
func dur_durumu(delta):
	if !elde_esya_var:
		animationTree.set("parameters/Duruş/blend_position", hareket_vektoru)
		animationState.travel("Duruş")
	else :
		animationTree.set("parameters/Duruşels/blend_position", hareket_vektoru)
		animationState.travel("Duruşels")

	ivme = ivme.move_toward(Vector2.ZERO, SURTUNME * delta)


func devin_durumu(delta) :
	animationTree.set("parameters/Yürüme/blend_position", hareket_vektoru)
	animationTree.set("parameters/Yürümels/blend_position", hareket_vektoru)
	if !elde_esya_var:
		animationState.travel("Yürüme")
	else :
		animationState.travel("Yürümels")

	ivme = ivme.move_toward(hareket_vektoru * MAKS_HIZ, HIZLANMA * delta)
	move()

func saldir_durumu(delta) -> void:
	animationTree.set("parameters/Saldırıels/blend_position", hareket_vektoru)
	animationState.travel("Saldırıels")

func attack_Move(): # saldiri animasyonu gericagri(callback) fonk.
	durum = DUR 

func move():
	ivme = move_and_slide(ivme)

func degistir_alet(alet):
	match alet:
		BOS:
			if elde_esya_var:
				el_esya.nesne_sil()
			elde_esya_var = false
		KAZMA:
			if elde_esya_var:
				el_esya.nesne_sil()
			el_esya = kazma.instance()
			get_node(".").add_child(el_esya)
			elde_esya_var = true
		BALTA:
			if elde_esya_var:
				el_esya.nesne_sil()
			el_esya = balta.instance()
			get_node(".").add_child(el_esya)
			elde_esya_var = true
		KILIC:
			pass

func tuslari_kontrol_et() -> void:
	if Input.is_action_pressed("Saldırı") and elde_esya_var:
		saldirma_durumuna_gec()
		return

	var hareket : Vector2 = Vector2.ZERO
	hareket.x = Input.get_action_strength("SağaYürüme") - Input.get_action_strength("SolaYürüme")
	hareket.y = Input.get_action_strength("AşağıYürüme") - Input.get_action_strength("YukarıYürüme")
	hareket = hareket.normalized()

	if hareket != Vector2.ZERO:
		hareket_vektoru = hareket
		kosuyor = true
		durum = DEVIN
	else:
		kosuyor = false
		durum = DUR

	if Input.is_action_just_pressed("he_0"):
		degistir_alet(BOS)
	elif Input.is_action_just_pressed("he_1"):
		degistir_alet(KAZMA)
	elif Input.is_action_just_pressed("he_2"):
		degistir_alet(BALTA)

func saldirma_durumuna_gec() -> void:
	durum = SALDIR
	el_esya.saldir()

func getir_hareket_vektoru() -> Vector2:
	return hareket_vektoru
	
func getir_kosuyor() -> bool:
	return kosuyor

func nesne_sil() -> void:
	queue_free()
