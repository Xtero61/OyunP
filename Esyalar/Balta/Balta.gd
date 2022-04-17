extends Esya

func _ready() -> void:
    esya_sahne = Genel.esya[Genel.ESYA_BALTA][Genel.ESYA_SAHNE]

var varlik_sahne = Genel.varlik[Genel.VAR_BALTA][Genel.VAR_SAHNE]
var varlik = varlik_sahne.instance()

func getir_varlik():
    return varlik

