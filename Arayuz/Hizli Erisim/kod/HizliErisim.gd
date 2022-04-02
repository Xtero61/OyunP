extends CanvasLayer

class Yuva:
	var adet
	var esya
	var gercek_esya

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hizli_erisim = Array()
var animasyonlar = [
	"sec0",
	"sec1",
	"sec2",
	"sec3",
	"sec4",
	"sec5",
	"sec6",
	"sec7",
	"sec8",
	"sec9",
]

onready var oyuncu = get_parent()
var eski_yuva: int = 1
var yuva: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1,10):
		var gecici_degisken = Yuva.new()
		gecici_degisken.esya = get_node("yuva" + str(i))
		gecici_degisken.adet = 0
		hizli_erisim.append(gecici_degisken)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	eski_yuva = yuva
	yuva = oyuncu.getir_secili_yuva()
	
	if(eski_yuva != yuva):
		eski_yuva = yuva
		$AnimationPlayer.play(animasyonlar[yuva])

func esya_ekle(yuva, esya, varlik):
	hizli_erisim[yuva - 1].esya.add_child(esya)
	if varlik != null:
		hizli_erisim[yuva - 1].gercek_esya = varlik
	else:
		hizli_erisim[yuva - 1].gercek_esya = esya
	
func getir_el_esya(yuva):
	return hizli_erisim[yuva - 1].gercek_esya
