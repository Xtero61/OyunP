extends Node2D
# Genel değsişken tanımlamaları

const MAKS_ESYA_MIKTARI : int = 100
const ESYA_DUSME_RASTGELE_KUVVET : int = 500
const OYUNCU_YERI: String = "/root/Dunya/YSort/Oyuncu"
const DUNYA_OLCEGI: Vector2 = Vector2(2, 2)
const AGAC_MAKS_ESYA_DUSURME :int = 4
const TAS_MAKS_ESYA_DUSURME :int = 4

# Esya yuklemeleri

enum{
    ESYA_BALTA,
    ESYA_KAZMA,
    ESYA_ODUN,
    ESYA_TAS,
}

enum{
    VAR_BALTA,
    VAR_KAZMA,
    VAR_AGAC,
    VAR_TAS,
}

enum{
    ESYA_ID,
    ESYA_MAKS_DUSME,
    ESYA_SAHNE
}

enum{
    VAR_ID,
    VAR_SAHNE
}

# Esya yüklemeleri
const esya = [
    # ESYA_ID     , MAKS_DUSME  , ESYA_SAHNE
    [ ESYA_KAZMA  , 1           , preload("res://Esyalar/Kazma/Kazma.tscn")],
    [ ESYA_BALTA  , 1           , preload("res://Esyalar/Balta/Balta.tscn")],
    [ ESYA_ODUN   , 4           , preload("res://Esyalar/Odun/Odun.tscn")  ],
    [ ESYA_TAS    , 4           , preload("res://Esyalar/Tas/Tas.tscn")    ],
]

# Varlik yuklemeleri
const varlik = [
    # VAR_ID   , VAR_SAHNE
    [ VAR_BALTA, preload("res://Varliklar/Aletler/Balta/Balta.tscn") ],
    [ VAR_KAZMA, preload("res://Varliklar/Aletler/Kazma/Kazma.tscn") ],
    [ VAR_AGAC , preload("res://Varliklar/Agac/Agac.tscn")           ],
    [ VAR_TAS  , preload("res://Varliklar/Tas/Tas.tscn")             ],
]
