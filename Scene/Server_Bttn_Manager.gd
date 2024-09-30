extends Button

@export var Server_ID : int
@onready var server_upgrade_panel: Panel = %Server_Upgrade_Panel


signal update_Panel_UI (ID)


func _on_pressed() -> void:
	update_Panel_UI.emit(Server_ID)
