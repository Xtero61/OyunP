extends RigidBody2D
class_name Esya

const tip: String = "esya"
var id: int
var esya_sahne
export var adet: int = 1
var yerde: bool = true

func _ready() -> void:
    dusme_hareketi_baslat(position)

func dusme_hareketi_baslat(dusme_yeri: Vector2):
    mode = MODE_RIGID
    yield(VisualServer, "frame_post_draw")
    yerde = true
    position = dusme_yeri
    $simge.scale = Genel.DUNYA_OLCEGI
    $CollisionShape2D.scale = Genel.DUNYA_OLCEGI
    $CollisionShape2D.disabled = false

func envantere_girme_baslat():
    mode = MODE_STATIC
    yerde = false
    $CollisionShape2D.disabled = true
    position = Vector2.ZERO
    rotation = 0

func kuvvet_uygula(yon: Vector2, kuvvet: int):
    yield(VisualServer, "frame_post_draw")
    apply_central_impulse(yon * kuvvet)
    var tork = Arac.rastgele_yuzdeyle_sinirla(Genel.ESYA_DUSME_MAKS_DONUS_KUVVETI, 
                                              80, 
                                              100)
    if Arac.getir_yuzde_sans(50):
        tork *= -1

    apply_torque_impulse(tork)

func rastgele_kuvvet_uygula():
    var randx = (randi() % 3 - 1)
    var randy = (randi() % 3 - 1)
    kuvvet_uygula(Vector2(randx, randy), Genel.ESYA_DUSME_RASTGELE_KUVVET)

func getir_simge():
    return get_node("simge").texture

func yeni_kopya():
    var esya = esya_sahne.instance()
    return esya

func adet_ayarla(gelen_adet: int):
    adet = gelen_adet

func getir_id():
    return id

func nesne_sil():
    queue_free()
