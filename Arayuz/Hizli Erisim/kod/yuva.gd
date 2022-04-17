extends Sprite
class_name Yuva

var adet := 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var etiket = get_node("label_kok/Label")
# Called when the node enters the scene tree for the first time.
func _ready():
    var label_kok = get_node("label_kok")
    label_kok.z_index = 1
    scale = Genel.DUNYA_OLCEGI
    label_kok.scale.x = 1 / scale.x
    label_kok.scale.y = 1 / scale.y

func etikete_yaz(sayi :int):
    if sayi <= 1:
        etiket.text = ""
    else:
        etiket.text = str(sayi)

func ekle(sayi:int):
    adet += sayi
    etikete_yaz(adet)

func sayiyi_ayarla(sayi:int):
    etikete_yaz(sayi)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
