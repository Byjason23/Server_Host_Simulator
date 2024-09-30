extends Node

@export var data_server_res : data_Server_Upgrade
@export var Server_Array : Array [Node2D]
var loaded_rack : bool = false


func _process(_delta: float) -> void:
	if not loaded_rack and data_server_res != null:
		data_server_res.upgrade_server_sig.connect(_on_upgrade_Server_signal)
		data_server_res.load_Server.connect(_load_Server)
		loaded_rack = true
	

func set_Server_Visible(server_ID):
	Server_Array[server_ID - 1].visible = true

func _on_upgrade_Server_signal(id : int):
	set_Server_Visible(id)

func _load_Server(id :int):
	set_Server_Visible(id)
