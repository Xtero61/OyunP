extends Node2D

onready var animationPlayer = $AnimationPlayer
export var vurulmaSayi = 0
var yikilmaSayi = 15
var Sayi = 1

func _process(_delta):
    if vurulmaSayi == Sayi :
        animationPlayer.play("Vurulma")
        Sayi += 1

    if vurulmaSayi == yikilmaSayi :
        Arac.esya_dusur(Genel.ESYA_TAS, global_position)
        animationPlayer.play("Kırılma")
        vurulmaSayi = 0

func _Kirildim():
    queue_free()

func _on_TasAlan_area_entered(area):
    if area.name == "PickaxeHit":
        vurulmaSayi += 1
        $AudioStreamPlayer2D.play()
