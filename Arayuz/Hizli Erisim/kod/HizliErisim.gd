extends CanvasLayer

class Yuva:
    var adet
    var esya
    var gercek_esya

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hizli_erisim = []
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
        var yuva_ismi = "yuva" + str(i)
        var gecici_degisken = Yuva.new()
        gecici_degisken.esya = get_node(yuva_ismi)
        gecici_degisken.adet = 0
        gecici_degisken.esya.sayiyi_ayarla(0)
        hizli_erisim.append(gecici_degisken)

    # hizli erişim çubuğunu ekranın altına ayarla
    var hizli_erisim_boyut: Vector2 = $"./hotbar".get_rect().size
    var ekran_boyut: Vector2 = get_viewport().get_visible_rect().size

    $".".offset.x += (ekran_boyut.x / 2 - (hizli_erisim_boyut.x * Genel.DUNYA_OLCEGI.x) / 2 )
    $".".offset.y += (ekran_boyut.y - hizli_erisim_boyut.y * Genel.DUNYA_OLCEGI.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    eski_yuva = yuva
    yuva = oyuncu.getir_secili_yuva()

    if(eski_yuva != yuva):
        eski_yuva = yuva
        $AnimationPlayer.play(animasyonlar[yuva])

func esya_ekle(_yuva: int, esya, varlik, adet: int) -> void:
    hizli_erisim[_yuva - 1].esya.sayiyi_ayarla(adet)
    hizli_erisim[_yuva - 1].esya.add_child(esya)
    if varlik != null:
        hizli_erisim[_yuva - 1].gercek_esya = varlik
    else:
        hizli_erisim[_yuva - 1].gercek_esya = esya

func getir_el_esya(_yuva):
    return hizli_erisim[_yuva - 1].gercek_esya

func yuva_sayac_ayarla(_yuva: int, sayi: int) -> void:
    hizli_erisim[_yuva - 1].esya.sayiyi_ayarla(sayi)
