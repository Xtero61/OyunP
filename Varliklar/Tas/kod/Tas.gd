extends Node2D

onready var animationPlayer = $AnimationPlayer
export var vurulmaSayi = 0
var yikilmaSayi = 15
var Sayi = 1

func _process(delta):
    if vurulmaSayi == Sayi :
        animationPlayer.play("Vurulma")
        Sayi += 1

    if vurulmaSayi == yikilmaSayi :
        item_dusur(position)
        animationPlayer.play("Kırılma")
        vurulmaSayi = 0

func _Kirildim():
    queue_free()

func _on_TasAlan_area_entered(area):
    if area.name == "PickaxeHit":
        vurulmaSayi += 1
        $AudioStreamPlayer2D.play()

func item_dusur(dusme_yeri: Vector2):
    var adet = randi() % (Genel.AGAC_MAKS_ESYA_DUSURME + 1)
    for i in adet:
        var item = Genel.esya["tas_esya"].instance()
        item.position = dusme_yeri
        item.dusme_hareketi_baslat()
        get_parent().add_child(item)
