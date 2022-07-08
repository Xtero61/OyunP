extends StaticBody2D

const yikilmaSayi: int = 15
const tip: String = "varlik"

onready var animasyon_agaci: AnimationTree = $AnimationTree
onready var animasyon_oynatici: AnimationPlayer = $AnimationPlayer
onready var animasyon_durumu = animasyon_agaci.get("parameters/playback")

export var vurulmaSayi: int = 0

var Sayi: int = 1
var hareket_vektoru := Vector2.ZERO

func _process(_delta):
    if vurulmaSayi == yikilmaSayi :
        animasyon_agaci.set("parameters/Kesildim/blend_position", hareket_vektoru)
        animasyon_durumu.travel("Kesildim")
        vurulmaSayi = 0

func _Kesildim():
    queue_free()
    Arac.esya_dusur(Genel.ESYA_ODUN, position)

func _on_AgacAlan_area_entered(area):
    if area.name == "AxeHit":
        hareket_vektoru = area.getir_sahip().getir_hareket_vektoru()
        animasyon_durumu.travel("Vurma")
        vurulmaSayi += 1
        $AudioStreamPlayer2D.play()

