extends RigidBody2D
class_name Esya

const tip: String = "esya" 
var id: int
var esya_sahne
var adet: int = 1

func _ready() -> void:
    $CollisionShape2D.disabled = true
    mode = MODE_STATIC

func dusme_hareketi_baslat(dusme_yeri: Vector2):
    position = dusme_yeri
    mode = MODE_RIGID
    $simge.scale = Genel.DUNYA_OLCEGI
    $CollisionShape2D.scale = Genel.DUNYA_OLCEGI
    $CollisionShape2D.disabled = false

func kuvvet_uygula(yon: Vector2, kuvvet: int):
    apply_central_impulse(yon * kuvvet)

func rastgele_kuvvet_uygula():
    var randx = (randi() % 3 - 1)
    var randy = (randi() % 3 - 1)
    kuvvet_uygula(Vector2(randx, randy), Genel.ESYA_DUSME_RASTGELE_KUVVET)

func getir_simge():
    return get_node("simge").texture

func yeni_kopya():
    return esya_sahne.instance()

func adet_ayarla(gelen_adet: int):
    adet = gelen_adet

func getir_id():
    return id
