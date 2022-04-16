extends RigidBody2D
class_name Esya

func _ready() -> void:
    mode = MODE_STATIC
    $CollisionShape2D.disabled = true

func dusme_hareketi_baslat(position: Vector2):
    position = position
    mode = MODE_RIGID
    $simge.scale = Genel.DUNYA_OLCEGI
    $CollisionShape2D.disabled = false
    var randx = (randi() % 3 - 1) * Genel.ESYA_DUSME_RASTGELE_KUVVET
    var randy = (randi() % 3 - 1) * Genel.ESYA_DUSME_RASTGELE_KUVVET
    apply_central_impulse(Vector2.ONE)
    apply_impulse(Vector2(randx, randy), Vector2(-randx, -randy))

func getir_simge():
    return get_node("simge").texture
