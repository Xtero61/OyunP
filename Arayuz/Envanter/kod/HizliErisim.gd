extends CanvasLayer

var yuvalar: Array = []
onready var oyuncu: Oyuncu = get_parent().get_parent()
var fare_ile_secilen_yuva: String = "yuva1"

var eski_yuva_indeks: int = 1
var yuva_indeks: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
    # $Kanvas.hide()
    # Yuvalari hafizaya kaydet hizli ulasmak için
    for i in range(1, 10):
        var yuva = get_node("Kanvas/yuva" + str(i))
        yuvalar.append(yuva)

    # hizli erişim çubuğunu ekranın altına ayarla
    var hizli_erisim_boyut: Vector2 = $"./Kanvas/hotbar".get_rect().size
    var ekran_boyut: Vector2 = get_viewport().get_visible_rect().size

    $".".offset.x += (ekran_boyut.x / 2 - (hizli_erisim_boyut.x * Genel.DUNYA_OLCEGI.x) / 2 )
    $".".offset.y += (ekran_boyut.y - hizli_erisim_boyut.y * Genel.DUNYA_OLCEGI.y)

func _process(_delta):
    eski_yuva_indeks = yuva_indeks
    yuva_indeks = oyuncu.getir_secili_yuva()

    if(eski_yuva_indeks != yuva_indeks):
        eski_yuva_indeks = yuva_indeks
        if yuva_indeks == 0 :
            $Kanvas/AnimationPlayer.play("sec 0")
        else :
            $Kanvas/hotbarSec.position = getir_yuva(yuva_indeks).position
            $Kanvas/AnimationPlayer.play("sec")

func getir_yuva(gelen_yuva_indeks: int):
    return yuvalar[gelen_yuva_indeks - 1]

func getir_el_esya(yuva_sirasi):
    var secilen_yuva: Yuva = getir_yuva(yuva_sirasi)
    if not secilen_yuva.dolu:
        return null
    return secilen_yuva.esya

func esya_ekle_yuva_belirle(esya: Esya):
    var bos_yuvalar = []
    for y in yuvalar:
        if y.dolu:
            if y.esya.id == esya.id:
                return y
        else:
            bos_yuvalar.append(y)

    return bos_yuvalar[0]

func esya_ekle(esya: Esya, gelen_adet: int):
    if esya.yerde:
        esya.envantere_girme_baslat()

    esya.adet_ayarla(gelen_adet)

    var y: Yuva = esya_ekle_yuva_belirle(esya)
    y.esya_ekle(esya)

func esya_at(yuva_sirasi: int):
    var secilen_yuva: Yuva = getir_yuva(yuva_sirasi)
    # Yuva boş ise hiçbir şey yapma
    if not secilen_yuva.dolu:
        return

    var olusan_esya: Esya
    if secilen_yuva.esya.adet > 1:
        # Yuvada birden fazla eşya var ise yuvadaki esyanin kopyasini sec
        olusan_esya = secilen_yuva.esya.yeni_kopya()
    else:
        # Esyanin gercegini sec
        olusan_esya = secilen_yuva.esya

    # Secilen esyayi kaldir
    if olusan_esya.has_method("getir_varlik"):
        oyuncu.remove_child(olusan_esya.varlik)
    else:
        oyuncu.remove_child(olusan_esya)

    # Esya adet azalt
    secilen_yuva.esya.adet -= 1
    secilen_yuva.etiketi_guncelle()

    if secilen_yuva.esya.adet == 0:
        oyuncu.ayarla_elde_esya_var(false)
        secilen_yuva.dolu = false
        secilen_yuva.esya = null
        secilen_yuva.texture = null

    # Atilacak esyayi hazirla ve at
    olusan_esya.position = oyuncu.position
    olusan_esya.yerde = true
    olusan_esya.adet = 1
    Arac.getir_ysort().add_child(olusan_esya)
    var atilma_noktasi: Vector2
    atilma_noktasi = oyuncu.position + oyuncu.getir_hareket_vektoru()
    olusan_esya.dusme_hareketi_baslat(atilma_noktasi)
    olusan_esya.kuvvet_uygula(oyuncu.getir_hareket_vektoru(), 500)

func getir_fare_ile_sec_yuva():
   return int(fare_ile_secilen_yuva.replace("yuva", ""))
