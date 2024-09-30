extends Control

@onready var contract_screen = %ContractScreen
@onready var accepted_contracts = %AcceptedContracts
@onready var research_ui = %Research_UI
@onready var shop_ui = %Shop_UI


func _on_shop_button_pressed():
	if shop_ui.visible == false:
		shop_ui.visible = true
		accepted_contracts.visible = false
		research_ui.visible = false
		contract_screen.visible = false
	else:
		shop_ui.visible = false

func _on_contract_button_pressed():
	if contract_screen.visible == false:
		contract_screen.visible = true
		accepted_contracts.visible = false
		research_ui.visible = false
		shop_ui.visible = false
	else: 
		contract_screen.visible = false

func _on_accc_ontracts_button_pressed():
	if accepted_contracts.visible == false:
		accepted_contracts.visible = true 
		contract_screen.visible = false
		research_ui.visible = false
		shop_ui.visible = false
	else:
		accepted_contracts.visible = false

func _on_research_button_pressed():
	if research_ui.visible == false:
		research_ui.visible = true
		accepted_contracts.visible = false
		contract_screen.visible = false
		shop_ui.visible = false
	else: 
		research_ui.visible = false
