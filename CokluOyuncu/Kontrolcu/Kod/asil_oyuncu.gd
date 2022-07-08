extends Kontrolcu
class_name AsilOyuncu

# oyuncu kontrollleri buraya aktarılacak
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    karakter.kmt[SAG] = Input.get_action_strength("SağaYürüme")
    karakter.kmt[SOL] = Input.get_action_strength("SolaYürüme")
    karakter.kmt[YUKARI] = Input.get_action_strength("YukarıYürüme")
    karakter.kmt[ASAGI] = Input.get_action_strength("AşağıYürüme")

func is_player():
    return true
