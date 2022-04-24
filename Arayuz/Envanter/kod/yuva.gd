extends Sprite
class_name Yuva

var esya: Esya
var dolu: bool = false # Yuva dolu mu

onready var etiket = get_node("label_kok/Label")
onready var hizli_erisim = get_parent()

func _ready():
    var label_kok = get_node("label_kok")
    label_kok.z_index = 1
    scale = Genel.DUNYA_OLCEGI
    label_kok.scale.x = 1 / scale.x
    label_kok.scale.y = 1 / scale.y
    etikete_yaz(0)

func esya_ekle(gelen_esya: Esya):
    # Bos hucreye esya ekleme fonksiyonu
    if not dolu:
        esya = gelen_esya
        dolu = true
        texture = esya.getir_simge()
        etiketi_guncelle()
    else:
        esya.adet += gelen_esya.adet
        gelen_esya.nesne_sil()
        etiketi_guncelle()

func etikete_yaz(sayi :int):
    if sayi <= 1:
        etiket.text = ""
    else:
        etiket.text = str(sayi)

func etiketi_guncelle():
    etikete_yaz(esya.adet)

func ekle(sayi:int):
    # Dolu hucredeki esyayı sayi kadar arttırma fonksiyonu
    esya.adet += sayi
    etiketi_guncelle()

func sayiyi_ayarla(sayi:int):
    # Dolu hucreninin sayısını doğrudan ayarlama
    etikete_yaz(sayi)

func hizli_erisim_bilgilendir():
    hizli_erisim.fare_ile_secilen_yuva = name
