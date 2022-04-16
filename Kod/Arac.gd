extends Node2D

# Araçlar
func rastgele_saymasayisi(ust_sinir: int):
    return (randi() % ust_sinir) + 1

func getir_ysort():
    return get_node(Genel.YERYUZU_YOLU)

func esya_dusur(esya: int, dusme_yeri: Vector2):
    var adet = Arac.rastgele_saymasayisi(Genel.esya[esya][Genel.ESYA_MAKS_DUSME])
    for i in adet:
        var olusan_esya: Esya = Genel.esya[esya][Genel.ESYA_SAHNE].instance()
        olusan_esya.global_position = dusme_yeri
        getir_ysort().add_child(olusan_esya)
        olusan_esya.dusme_hareketi_baslat(dusme_yeri)
        olusan_esya.rastgele_kuvvet_uygula()

func getir_simge(dugumun_kendisi):
     dugumun_kendisi.get_node("Sprite").texture
