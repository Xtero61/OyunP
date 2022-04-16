extends KinematicBody2D
class_name Oyuncu

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
var secili_yuva : int = 1
var eski_yuva : int = 0

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hizli_erisim = $HizliErisim

enum{
	DUR,
	DEVIN, # bkz. devinmek
	SALDIR,
	OL,
	TAKLA
}

func _ready():
	hizli_erisim.esya_ekle(2,
		Genel.esya[Genel.ESYA_TAS][Genel.ESYA_SAHNE].instance(),
		100)
	hizli_erisim.esya_ekle(3,
		Genel.esya[Genel.ESYA_ODUN][Genel.ESYA_SAHNE].instance(),
		24)
	hizli_erisim.esya_ekle(4,
		Genel.esya[Genel.ESYA_BALTA][Genel.ESYA_SAHNE].instance(),
		1)
	hizli_erisim.esya_ekle(5,
		Genel.esya[Genel.ESYA_KAZMA][Genel.ESYA_SAHNE].instance(),
		1)

func _physics_process(_delta):
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
	ivme = move_and_slide(ivme)

func saldir_durumu(_delta) -> void:
	animationTree.set("parameters/Saldırıels/blend_position", hareket_vektoru)
	animationState.travel("Saldırıels")

func attack_Move(): # saldiri animasyonu gericagri(callback) fonk.
	durum = DUR

func el_esya_degistir(yuva):
	if el_esya != null:
		remove_child(el_esya)
	el_esya = hizli_erisim.getir_el_esya(yuva)
	if el_esya != null:
		add_child(el_esya)
		elde_esya_var = true
	else:
		elde_esya_var = false


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
		secili_yuva = 0
	elif Input.is_action_just_pressed("he_1"):
		secili_yuva = 1
	elif Input.is_action_just_pressed("he_2"):
		secili_yuva = 2
	elif Input.is_action_just_pressed("he_3"):
		secili_yuva = 3
	elif Input.is_action_just_pressed("he_4"):
		secili_yuva = 4
	elif Input.is_action_just_pressed("he_5"):
		secili_yuva = 5
	elif Input.is_action_just_pressed("he_6"):
		secili_yuva = 6
	elif Input.is_action_just_pressed("he_7"):
		secili_yuva = 7
	elif Input.is_action_just_pressed("he_8"):
		secili_yuva = 8
	elif Input.is_action_just_pressed("he_9"):
		secili_yuva = 9

	if secili_yuva != eski_yuva:
		el_esya_degistir(secili_yuva)
	eski_yuva = secili_yuva

	if Input.is_action_just_pressed("esya_at"):
		hizli_erisim.esya_at(secili_yuva)
		el_esya_degistir(secili_yuva) # Elde duran aletten de kurtulmak için

func saldirma_durumuna_gec() -> void:
	durum = SALDIR
	if el_esya.has_method("saldir"):
		el_esya.saldir()

func getir_hareket_vektoru() -> Vector2:
	return hareket_vektoru

func getir_kosuyor() -> bool:
	return kosuyor

func getir_secili_yuva() -> int:
	return secili_yuva

func nesne_sil() -> void:
	queue_free()
