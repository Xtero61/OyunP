extends Control

var menu_goster: bool = false
var asil_oyuncu = preload("res://CokluOyuncu/Kontrolcu/asil_oyuncu.tscn")
var uzak_oyuncu = preload("res://CokluOyuncu/Kontrolcu/uzak_oyuncu.tscn")
var karakter_sahnesi = preload("res://Canli Varliklar/karakter/karakter.tscn")

onready var butt_server_start = get_node("StartServer")
onready var butt_server_stop = get_node("StopServer")
onready var ip_addr = get_node("IpAddr")
onready var butt_connect = get_node("Connect")
var peer = NetworkedMultiplayerENet.new()
var server_ip: String = "0.0.0.0"
const PORT = 10161

var client_started: bool = false
var server_started: bool = false

onready var yeryuzu = Arac.getir_ysort()

func _ready():
    get_tree().connect("network_peer_connected", self, "_player_connected")
    get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
    
func _process(delta):
    if Input.is_action_just_pressed("ui_home"):
        if menu_goster:
            show()
            menu_goster = false
        else:
            hide()
            menu_goster = true


func create_player(id, is_peer):
    # Create a character with a player or a peer controller attached
    var kontrolcu : Kontrolcu
    # Check whether we are creating a player or a peer controller
    if is_peer:
        # Peer controller represents other connected players on the network
        kontrolcu = uzak_oyuncu.instance()
    else:
        # Player controller is our input which controls the character node
        kontrolcu = asil_oyuncu.instance()
    # Instantiate the character
    var karakter = karakter_sahnesi.instance()
    # Attach the controller to the character
    karakter.add_child(kontrolcu)
    # Set the controller's name for easier reference by the character
    kontrolcu.name = "kontrolcu"
    # Set the character's name to a given network id for synchronization
    karakter.name = str(id)
    # Add the character to this (main) scene 
    yeryuzu.add_child(karakter)
    # Enable the controller's camera if it's not an other player 
    kontrolcu.get_node("kamera").current = !is_peer

func stop_server() -> void:
    get_tree().set_network_peer(null)
    butt_server_start.text = "Start Server"
    butt_server_start.disabled = false
    butt_server_stop.text = "No server running"
    butt_server_stop.disabled = true

func create_server():
    peer.set_bind_ip(server_ip)  
    peer.create_server(PORT, 5)
    get_tree().set_network_peer(peer)
    butt_server_start.text = "Server started..."
    butt_server_start.disabled = true
    butt_server_stop.text = "Stop Server"
    butt_server_stop.disabled = false

func create_client():
    get_tree().connect("connected_to_server", self, "_on_connected_to_server")
    get_tree().connect("server_disconnected", self, "_on_server_disconnected")
    if client_started:
        print("Client already started.")
        print("My id: ", get_tree().get_network_unique_id())
        return
    
    server_ip = ip_addr.text
    peer.create_client(server_ip, PORT)
    get_tree().set_network_peer(peer)
    client_started = true

func _on_Quit_button_up():
    get_tree().quit()

func _on_StartServer_button_up():
    create_server()
    create_player(1, false)

func _on_Connect_button_up():
    create_client()

func _on_IpAddr_text_changed():
    if ip_addr.text != "":
        butt_connect.disabled = false
    else:
        butt_connect.disabled = true

func _player_connected(player):
    create_player(player, true)
    
func _player_disconnected(id):
    _on_peer_disconnected(id)

func _on_StopServer_button_up():
    stop_server()

func _on_connected_to_server():
    var id = get_tree().get_network_unique_id()
    create_player(id, false)

func _on_connected_to_peer(id):
    create_player(id, true)

func remove_player(id):
    Arac.getir_ysort().get_node(str(id)).free()

func _on_peer_disconnected(id):
    remove_player(id)
