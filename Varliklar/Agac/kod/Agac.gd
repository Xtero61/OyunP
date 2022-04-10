extends Node2D
onready var animationPlayer = $AnimationPlayer
export var vurulmaSayi = 0
var yikilmaSayi = 15
var Sayi = 1
var sag = 0
var sol = 0
var ust = 0
var alt = 0

func _process(_delta):

	if vurulmaSayi ==  Sayi :
		animationPlayer.play("Vurulma")
		Sayi +=  1
		
	if vurulmaSayi == yikilmaSayi and (ust == 1 and sol == 1):
		animationPlayer.stop()
		animationPlayer.play("KesilmeSağ")
	elif vurulmaSayi == yikilmaSayi and (alt == 1 and sol == 1):
		animationPlayer.stop()
		animationPlayer.play("KesilmeSağ")
	elif vurulmaSayi == yikilmaSayi and (ust == 1 and sag == 1):
		animationPlayer.stop()
		animationPlayer.play("KesilmeSol")
	elif vurulmaSayi == yikilmaSayi and (alt == 1 and sag == 1):
		animationPlayer.stop()
		animationPlayer.play("KesilmeSol")
	elif vurulmaSayi == yikilmaSayi and ust == 1 :
		animationPlayer.stop()
		animationPlayer.play("KesilmeSağ")
	elif vurulmaSayi == yikilmaSayi and sol == 1 :
		animationPlayer.stop()
		animationPlayer.play("KesilmeSağ")
	elif vurulmaSayi == yikilmaSayi and alt == 1 :
		animationPlayer.stop()
		animationPlayer.play("KesilmeSol")
	elif vurulmaSayi == yikilmaSayi and sag == 1 :
		animationPlayer.stop()
		animationPlayer.play("KesilmeSol") 

func _Kesildim():
	queue_free()
	item_dusur(position)

func _on_Sag_body_entered(body):
	if body.name == "Oyuncu":
		sag = 1

func _on_Sag_body_exited(body):
	if body.name == "Oyuncu":
		sag = 0

func _on_Sol_body_entered(body):
	if body.name == "Oyuncu":
		sol = 1

func _on_Sol_body_exited(body):
	if body.name == "Oyuncu":
		sol = 0

func _on_Ust_body_entered(body):
	if body.name == "Oyuncu":
		ust = 1

func _on_Ust_body_exited(body):
	if body.name == "Oyuncu":
		ust = 0

func _on_Alt_body_entered(body):
	if body.name == "Oyuncu":
		alt = 1

func _on_Alt_body_exited(body):
	if body.name == "Oyuncu":
		alt = 0


func _on_AgacAlan_area_entered(area):
	if area.name == "AxeHit":
		vurulmaSayi += 1
		$AudioStreamPlayer2D.play()

func item_dusur(dusme_yeri : Vector2) -> void:
	var adet = randi() % (Genel.AGAC_MAKS_ESYA_DUSURME + 1)
	for i in adet:
		var item = Genel.esya["odun_esya"].instance()
		item.position = dusme_yeri
		item.dusme_hareketi_baslat()
		get_parent().add_child(item)
