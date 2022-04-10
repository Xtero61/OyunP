extends Node
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const MAKS_ESYA_MIKTARI : int = 100
const ESYA_DUSME_RASTGELE_KUVVET : int = 500
const OYUNCU_YERI: String = "/root/Dunya/YSort/Oyuncu"
const DUNYA_OLCEGI: Vector2 = Vector2(2, 2)
const AGAC_MAKS_ESYA_DUSURME :int = 4

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
