extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var animasyonlar = [
	"sec0",
	"sec1",
	"sec2",
	"sec3",
	"sec4",
	"sec5",
	"sec6",
	"sec7",
	"sec8",
	"sec9",
]

onready var oyuncu = get_parent()
var eski_slot: int = 1
var slot: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	eski_slot = slot
	slot = oyuncu.getir_secili_slot()
	
	if(eski_slot != slot):
		eski_slot = slot
		$AnimationPlayer.play(animasyonlar[slot])
