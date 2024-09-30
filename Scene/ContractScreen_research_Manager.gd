extends Control

@export var contract_Array : Array[Panel]




func _on_research_ui_researched_contract_screen(number):
	contract_Array[number].visible = true
