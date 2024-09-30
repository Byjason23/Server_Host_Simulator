extends Button

@onready var upgrade_ui: Control = %Upgrade_UI

@export var dataserverres : data_Server_Upgrade

signal open_UI(rack_Data)

func _on_pressed():
	open_UI.emit(dataserverres)
	upgrade_ui.visible = true
