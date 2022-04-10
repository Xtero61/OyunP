extends Node2D

onready var animationPlayer = $AnimationPlayer
var vurulmaSayi = 0
var yikilmaSayi = 15
var Sayi = 1

func _process(delta):
	if vurulmaSayi == Sayi :
		animationPlayer.play("Vurulma")
		Sayi += 1

	if vurulmaSayi == yikilmaSayi :
		animationPlayer.play("Kırılma")

func _Kirildim():
	queue_free()

func _on_TasAlan_area_entered(area):
	if area.name == "PickaxeHit":
		vurulmaSayi += 1
		$AudioStreamPlayer2D.play()
		
