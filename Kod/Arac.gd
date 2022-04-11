extends Node2D

# Araçlar
func rastgele_saymasayisi(ust_sinir: int):
    return (randi() % ust_sinir) + 1

func esya_dusur(esya: int, dusme_yeri: Vector2):
    var adet = Arac.rastgele_saymasayisi(Genel.esya[esya][Genel.ESYA_MAKS_DUSME])
    for i in adet:
        var olusan_esya = Genel.esya[esya][Genel.ESYA_SAHNE].instance()
        olusan_esya.global_position = dusme_yeri
        olusan_esya.dusme_hareketi_baslat()
        get_parent().add_child(olusan_esya)
