extends Node2D
# Genel değsişken tanımlamaları

const ESYA_DUSME_RASTGELE_KUVVET : int = 500
const ESYA_DUSME_MAKS_DONUS_KUVVETI = 5000
const OYUNCU_YOLU: String = "/root/Dunya/Yeryuzu/Oyuncu"
const YERYUZU_YOLU: String = "/root/Dunya/Yeryuzu"
const DUNYA_OLCEGI: Vector2 = Vector2(2, 2)

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
    ESYA_MAKS_YIGIN_ADET,
    ESYA_SAHNE,
}

enum{
    VAR_ID,
    VAR_SAHNE
}

# Esya yüklemeleri
const esya = [
    # ESYA_ID     , MAKS_DUSME, MAKS_YIGIN_ADET  , ESYA_SAHNE                               
    [ ESYA_BALTA  , 1         , 1                , preload("res://Esyalar/Balta/Balta.tscn")],
    [ ESYA_KAZMA  , 1         , 1                , preload("res://Esyalar/Kazma/Kazma.tscn")],
    [ ESYA_ODUN   , 4         , 99               , preload("res://Esyalar/Odun/Odun.tscn")  ],
    [ ESYA_TAS    , 4         , 99               , preload("res://Esyalar/Tas/Tas.tscn")    ],
]

# Varlik yuklemeleri
const varlik = [
    # VAR_ID   , VAR_SAHNE
    [ VAR_BALTA, preload("res://Varliklar/Aletler/Balta/Balta.tscn") ],
    [ VAR_KAZMA, preload("res://Varliklar/Aletler/Kazma/Kazma.tscn") ],
    [ VAR_AGAC , preload("res://Varliklar/Agac/Agac.tscn")           ],
    [ VAR_TAS  , preload("res://Varliklar/Tas/Tas.tscn")             ],
]
