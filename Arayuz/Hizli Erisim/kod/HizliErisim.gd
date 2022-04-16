extends CanvasLayer

class Yuva_veri:
    var adet: int
    var esya: Esya
    var yuva: Yuva

var hizli_erisim = []

onready var oyuncu: Oyuncu = get_parent()

var eski_yuva: int = 1
var yuva: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
    for i in range(1,10):
        var yuva_ismi = "yuva" + str(i)
        var gecici_degisken = Yuva_veri.new()
        gecici_degisken.yuva = get_node(yuva_ismi)
        gecici_degisken.adet = 0
        gecici_degisken.yuva.sayiyi_ayarla(0)
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
        if yuva == 0 :
            $AnimationPlayer.play("sec 0")
        else :
            $hotbarSec.position = get_node("yuva" + str(yuva)).position
            $AnimationPlayer.play("sec")

func esya_ekle(yuva_sirasi: int, esya, adet: int) -> void:
    hizli_erisim[yuva_sirasi - 1].adet = adet
    hizli_erisim[yuva_sirasi - 1].esya = esya
    hizli_erisim[yuva_sirasi - 1].yuva.texture = esya.getir_simge()


func getir_el_esya(yuva_sirasi):
    if hizli_erisim[yuva_sirasi - 1].adet == 0:
        return null

    if hizli_erisim[yuva_sirasi - 1].esya.has_method("getir_varlik"):
        return hizli_erisim[yuva_sirasi - 1].esya.varlik
    else:
        return hizli_erisim[yuva_sirasi - 1].esya

func yuva_sayac_ayarla(yuva_sirasi: int, sayi: int) -> void:
    hizli_erisim[yuva_sirasi - 1].adet = sayi

func esya_at(yuva_sirasi: int):
    if hizli_erisim[yuva_sirasi -1].adet == 0:
        return
    var olusan_esya: Esya = hizli_erisim[yuva_sirasi -1].esya
    olusan_esya.position = oyuncu.position
    oyuncu.remove_child(olusan_esya)
    Arac.getir_ysort().add_child(olusan_esya)
    olusan_esya.dusme_hareketi_baslat(oyuncu.position)
    olusan_esya.kuvvet_uygula(oyuncu.getir_hareket_vektoru(), 500)

    hizli_erisim[yuva_sirasi -1].adet = 0
    hizli_erisim[yuva_sirasi -1].esya = null
    hizli_erisim[yuva_sirasi -1].yuva.texture = null
