extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var etiket = get_node("label_kok/Label")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("label_kok").z_index = 1

func sayiyi_ayarla(sayi:int):
	if sayi == 0:
		etiket.text = ""
	else:
		etiket.text = str(sayi)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
