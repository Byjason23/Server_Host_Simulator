extends Button


@onready var server_upgrade_panel: Panel = %Server_Upgrade_Panel
@onready var upgrade_bttn_server: Button = %Upgrade_Bttn_Server
@onready var upgrade_bttn_server_rack: Button = %Upgrade_Bttn_ServerRack

@onready var upgrade_ui = $"../.."

func _on_pressed():
	server_upgrade_panel.visible = false
	upgrade_ui.visible = false
	upgrade_bttn_server.disabled = false
	upgrade_bttn_server_rack.disabled = false
