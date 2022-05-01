extends Node2D

# Araçlar
func rastgele_saymasayisi(ust_sinir: int) -> int:
    return (randi() % ust_sinir) + 1
    
func rastgele_noktali_sayi(ust_sinir: float) -> float:
    return (randf() * ust_sinir)

func getir_ysort():
    return get_node(Genel.YERYUZU_YOLU)

func getir_oyuncu():
    return get_node(Genel.OYUNCU_YOLU)

func esya_dusur(esya: int, dusme_yeri: Vector2) -> void:
    var adet = Arac.rastgele_saymasayisi(Genel.esya[esya][Genel.ESYA_MAKS_DUSME])
    for i in adet:
        var olusan_esya: Esya = Genel.esya[esya][Genel.ESYA_SAHNE].instance()
        olusan_esya.global_position = dusme_yeri
        getir_ysort().add_child(olusan_esya)
        olusan_esya.dusme_hareketi_baslat(dusme_yeri)
        olusan_esya.rastgele_kuvvet_uygula()
        
func zar_at() -> int:
    return rastgele_saymasayisi(6)

func getir_yuzde_sans(yuzde: int) -> bool:
    return (rastgele_saymasayisi(100) > yuzde)
    
func rastgele_yuzdeyle_sinirla(sayi: float, alt_yuzde: int, ust_yuzde: int):
    var alt_sinir := sayi * (alt_yuzde / 100.0)
    var ust_sinir := sayi * (ust_yuzde / 100.0)
    return (rastgele_noktali_sayi(ust_sinir - alt_sinir) + alt_sinir)
