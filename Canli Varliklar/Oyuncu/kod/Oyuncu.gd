extends KinematicBody2D
class_name Oyuncu

const tip: String = "canli"
const HIZLANMA = 700
const MAKS_HIZ = 120
const SURTUNME = 500
const TAKLA_HIZ = 225

var elde_esya_var: bool = false # Elde esya var mi
var el_esya # Eldeki esya nesnesi
var hareket_vektoru : Vector2 = Vector2(1, 0) # Hareket vektörü
var kosuyor : bool = false # Karakter kosuyor mu
var ivme: Vector2 = Vector2.ZERO # İvme vektörü
var durum : int = DUR
var maks_mesafe : int = 12
var secili_yuva : int = 1
var eski_yuva : int = 0

onready var esya_cekme = $Esya_cekme/CollisionShape2D
onready var esya_al = $Esya_Alma/CollisionShape2D
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hizli_erisim = $Envanter/HizliErisim

enum{
    DUR,
    DEVIN, # bkz. devinmek
    SALDIR,
    OL,
    TAKLA
}

func _ready():
    pass

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
    var e = hizli_erisim.getir_el_esya(yuva)

    if elde_esya_var:
        if el_esya.has_method("getir_varlik"):
            remove_child(el_esya.varlik)
        else:
            remove_child(el_esya)
        elde_esya_var = false

    if e != null:
        el_esya = e
        if el_esya.has_method("getir_varlik"):
            call_deferred("add_child", el_esya.varlik)
            # add_child(el_esya.varlik)
        else:
            call_deferred("add_child", el_esya)
            # add_child(el_esya)
        elde_esya_var = true

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

    secili_yuva += int(Input.is_action_just_released("fare_tekerlek_asagi")) - int(Input.is_action_just_released("fare_tekerlek_yukari"))
    # Gereksiz optimizasyon kodu
    # secili_yuva = int(secili_yuva > 9) * 1 + int(secili_yuva < 1) * 9 + secili_yuva * int(secili_yuva >= 1) * int(secili_yuva <= 9)
    if secili_yuva > 9:
        secili_yuva = 1
    elif secili_yuva < 1:
        secili_yuva = 9

    if secili_yuva != eski_yuva:
        el_esya_degistir(secili_yuva)
    eski_yuva = secili_yuva

    if Input.is_action_just_pressed("esya_at"):
        esya_at(secili_yuva)

    if Input.is_action_pressed("esya_al"):
        esya_al.disabled = false
        esya_cekme.disabled = false
    else:
        esya_al.disabled = true
        esya_cekme.disabled = true

func esya_at(yuva_indeks:int):
    hizli_erisim.esya_at(yuva_indeks)
    el_esya_degistir(yuva_indeks)


func saldirma_durumuna_gec() -> void:
    durum = SALDIR
    if el_esya.has_method("getir_varlik"):
        el_esya.getir_varlik().saldir()

func getir_hareket_vektoru() -> Vector2:
    return hareket_vektoru

func ayarla_elde_esya_var(esya_olma_durumu: bool):
    elde_esya_var = esya_olma_durumu

func getir_kosuyor() -> bool:
    return kosuyor

func getir_secili_yuva() -> int:
    return secili_yuva

func nesne_sil() -> void:
    queue_free()

func _on_Esya_Alma_body_entered(esya):
    if esya.tip == "esya":
        Arac.getir_ysort().remove_child(esya)
        hizli_erisim.esya_ekle(esya, esya.adet)
        el_esya_degistir(secili_yuva)

func _on_Esya_cekme_body_entered(esya):
    if esya.tip ==  "esya":
        var adam_yer = $".".position
        var esya_yer = esya.position
        var yon = esya_yer.direction_to(adam_yer)
        esya.apply_central_impulse(yon * 750)


