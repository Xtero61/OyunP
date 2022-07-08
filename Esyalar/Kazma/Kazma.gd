extends Esya

func _ready() -> void:
    esya_sahne = Genel.esya[Genel.ESYA_KAZMA][Genel.ESYA_SAHNE]
    id = Genel.ESYA_KAZMA

var varlik_sahne = Genel.varlik[Genel.VAR_KAZMA][Genel.VAR_SAHNE]
var varlik = varlik_sahne.instance()

func getir_varlik():
    return varlik

