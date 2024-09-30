extends Marker2D

@export var Server_Upgrade : data_Server_Upgrade

@export var MarkerDataRow_array : Array[Marker2D]
@export var ServerRack_array : Array[PackedScene]

func _ready():
	pass

func updateRack():
	match Server_Upgrade.updates_bought_serverrack:
		0:
			createServerRack(ServerRack_array[0])
		1:
			createServerRack(ServerRack_array[1])
		2:
			createServerRack(ServerRack_array[2])
		3:
			createServerRack(ServerRack_array[3])
		4:
			createServerRack(ServerRack_array[4])
		5:
			createServerRack(ServerRack_array[5])


func createServerRack(ServerRack):
	var Marker = getMarker()
	var oldserverrack = Marker.get_child(0)
	oldserverrack.queue_free()
	var newServerack = ServerRack.instantiate()
	Marker.add_child(newServerack)
	newServerack.data_server_res = Server_Upgrade

func setserverupgrade(dataserver):
	Server_Upgrade = dataserver
	updateRack()

func getMarker():
	var marker = MarkerDataRow_array[Server_Upgrade.ServerUpgradeID]
	return(marker)


func _on_cloud_upgrade_ui_upgrade_buttonpressed(data_server_rack):
	setserverupgrade(data_server_rack)


func _on_save_marker_load_cloud_rack(data_Server_Rack):
	setserverupgrade(data_Server_Rack)


func _on_upgrade_ui_upgrade_cloud_rack(Rack_Data: Variant) -> void:
	print("cloudrack")
	setserverupgrade(Rack_Data)
