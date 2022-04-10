extends YSort

const MAKS_ESYA_MIKTARI : int = 100

# Esya yuklemeleri
var esya = {
	"odun_esya" : preload("res://Esyalar/Odun/Odun.tscn"),
	"tas_esya" : preload("res://Esyalar/Tas/Tas.tscn"),
	"balta_esya" : preload("res://Esyalar/Balta/Balta.tscn"),
	"kazma_esya" : preload("res://Esyalar/Kazma/Kazma.tscn"),
}

# Varlik yuklemeleri
var varlik = {
	"balta" : preload("res://Varliklar/Aletler/Balta/Balta.tscn"),
	"kazma" : preload("res://Varliklar/Aletler/Kazma/Kazma.tscn"),
	"agac" : preload("res://Varliklar/Agac/Agac.tscn"),
	"tas" : preload("res://Varliklar/Tas/Tas.tscn"),
}

func getir_maks_esya_miktari() -> int:
	return MAKS_ESYA_MIKTARI

func getir_esya_sahne(esya_adi):
	return esya[esya_adi]

func getir_varlik_sahne(varlik_adi):
	return varlik[varlik_adi]
