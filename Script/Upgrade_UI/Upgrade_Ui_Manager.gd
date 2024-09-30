extends Node

@onready var upgrade_ui: Control = $"."

@export var Server_Upgrade_Buttons : Array[Button]

signal open_UI(_Rack_Data, servernmbr)
signal upgrade_Data_Rack(Rack_Data)
signal upgrade_Cloud_Rack(Rack_Data)
signal upgrade_Core_Rack(Rack_Data)


func get_Server_Number(upgrade_Data: data_Server_Upgrade):
	match upgrade_Data.updates_bought_serverrack:
		0:
			return(2)
		1,4,5 :
			return(8)
		2,3:
			return(10)
		
func _on_cloud_upgrade_button_1_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func show_Server_Buttons(_rack_Data):
	var Server_Number = get_Server_Number(_rack_Data)
	for i in range(Server_Upgrade_Buttons.size()):
		Server_Upgrade_Buttons[i].visible = false
	for i in  Server_Number:
		Server_Upgrade_Buttons[i].visible = true


func _on_cloud_upgrade_button_2_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_cloud_upgrade_button_3_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_cloud_upgrade_button_4_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_upgrade_button_1_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)

func _on_upgrade_button_2_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)

func _on_upgrade_button_3_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_upgrade_button_4_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_core_upgrade_button_1_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_core_upgrade_button_2_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_core_upgrade_button_3_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_core_upgrade_button_4_open_ui(rack_Data: Variant) -> void:
	open_UI.emit(rack_Data, get_Server_Number(rack_Data))
	show_Server_Buttons(rack_Data)


func _on_server_upgrade_panel_update_server_number(current_Rack: Variant) -> void:
	show_Server_Buttons(current_Rack)


func _on_server_upgrade_panel_upgrade_cloud_server_rack(Rack_Data: Variant) -> void:
	_on_cloud_upgrade_button_1_open_ui(Rack_Data)
	upgrade_Cloud_Rack.emit(Rack_Data)


func _on_server_upgrade_panel_upgrade_core_server_rack(Rack_Data: Variant) -> void:
	_on_cloud_upgrade_button_1_open_ui(Rack_Data)
	upgrade_Core_Rack.emit(Rack_Data)


func _on_server_upgrade_panel_upgrade_data_server_rack(Rack_Data: Variant) -> void:
	_on_cloud_upgrade_button_1_open_ui(Rack_Data)
	upgrade_Data_Rack.emit(Rack_Data)
