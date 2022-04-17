extends Node2D

var durum: int = DEVIN

onready var animasyonAgaci = $AnimationTree
onready var animasyonDurumu = animasyonAgaci.get("parameters/playback")
onready var oyuncu = get_parent()
onready var input_vector = oyuncu.getir_hareket_vektoru()
onready var run = oyuncu.getir_kosuyor()

enum{
    DEVIN,
    SALDIR,
    OL
}

func _ready():
    var animasyon = $AnimationTree
    input_vector = oyuncu.getir_hareket_vektoru()
    run = oyuncu.getir_kosuyor()
    animasyon_guncelle()
    animasyon.active = true

func _physics_process(_delta) :
    input_vector = oyuncu.getir_hareket_vektoru()
    run = oyuncu.getir_kosuyor()
    animasyon_guncelle()

    match durum :
        DEVIN :
            devin_durum()
        SALDIR :
            saldir_durum()
        OL:
            pass

func devin_durum() :
    if run :
        animasyonDurumu.travel("Yürüme")
    else :
        animasyonDurumu.travel("Duruş")

func saldir_durum():
    animasyonDurumu.travel("Saldırı")

func animasyon_guncelle() -> void:
    animasyonAgaci.set("parameters/Saldırı/blend_position", input_vector)
    animasyonAgaci.set("parameters/Duruş/blend_position", input_vector)
    animasyonAgaci.set("parameters/Yürüme/blend_position", input_vector)

func attack_Move():
    durum = DEVIN

func nesne_sil():
    queue_free()

func saldir():
    durum = SALDIR

func getir_sahip():
    return oyuncu
