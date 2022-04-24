extends Node2D

const tip: String = "varlik"
const yikilmaSayi: int = 15

onready var animationPlayer = $AnimationPlayer

export var vurulmaSayi: int = 0

var Sayi: int = 1

func _process(_delta):
    if vurulmaSayi == Sayi :
        animationPlayer.play("Vurulma")
        Sayi += 1

    if vurulmaSayi == yikilmaSayi :
        Arac.esya_dusur(Genel.ESYA_TAS, position)
        animationPlayer.play("Kırılma")
        vurulmaSayi = 0

func _Kirildim():
    queue_free()

func _on_TasAlan_area_entered(area):
    if area.name == "PickaxeHit":
        vurulmaSayi += 1
        $AudioStreamPlayer2D.play()
