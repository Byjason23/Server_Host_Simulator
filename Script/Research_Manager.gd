extends Node

@export var data_server_array : Array[Node2D]
@export var core_server_array : Array[Node2D]
@export var cloud_server_array : Array[Node2D]
@export var Accepted_Contract_Array : Array[Research_template]
@export var Contract_Array : Array[Research_template]
@export var PlrStats : PlayerStats
@export var upgrades_Array : Array[data_Server_Upgrade]
@export var core_Buttons : Array[Button]
@export var cloud_Buttons : Array[Button]
@export var data_Buttons : Array[Button]
@export var data_researches : Array[Research_template]
@export var core_researches : Array[Research_template]
@export var cloud_researches : Array[Research_template]

signal update_after_load()
signal researched_ContractScreen(number)
signal researched_AcceptedContract(number)


func _on_core_server_2_researched():
	core_server_array[0].visible = true
	core_server_array[0].data_server_res.isResearched = true
	core_Buttons[0].visible = true


func _on_core_server_3_researched():
	core_server_array[1].visible = true
	core_server_array[1].data_server_res.isResearched = true
	core_Buttons[1].visible = true


func _on_core_server_4_researched():
	core_server_array[2].visible = true
	core_server_array[2].data_server_res.isResearched = true
	core_Buttons[2].visible = true


func _on_cloud_rack_2_researched():
	cloud_server_array[0].visible = true
	cloud_server_array[0].data_server_res.isResearched = true
	cloud_Buttons[0].visible = true


func _on_cloud_rack_3_researched():
	cloud_server_array[1].visible = true
	cloud_server_array[1].data_server_res.isResearched = true
	cloud_Buttons[1].visible = true


func _on_cloud_rack_4_researched():
	cloud_server_array[2].visible = true
	cloud_server_array[2].data_server_res.isResearched = true
	cloud_Buttons[2].visible = true


func _on_data_rack_2_researched():
	data_server_array[0].visible = true
	data_server_array[0].data_server_res.isResearched = true
	data_Buttons[0].visible = true


func _on_data_rack_3_researched():
	data_server_array[1].visible = true
	data_server_array[1].data_server_res.isResearched = true
	data_Buttons[1].visible = true


func _on_data_rack_4_researched():
	data_server_array[2].visible = true
	data_server_array[2].data_server_res.isResearched = true
	data_Buttons[2].visible = true



func _on_save_marker_load_success():
	update_after_load.emit()
	for i in range(Accepted_Contract_Array.size()):
		if Accepted_Contract_Array[i].isResearched == true:
			researched_AcceptedContract.emit(i)
			PlrStats.set_accContractSpace(1)
	for i in range(Contract_Array.size()):
		if Contract_Array[i].isResearched == true:
			researched_ContractScreen.emit(i)
	for i in range(data_server_array.size()):
		if data_researches[i].isResearched == true:
			data_server_array[i].visible = true
			data_server_array[i].data_server_res.isResearched = true
			data_Buttons[i].visible = true
	for i in range(core_server_array.size()):
		if core_researches[i].isResearched == true:
			core_server_array[i].visible = true
			core_server_array[i].data_server_res.isResearched = true
			core_Buttons[i].visible = true
	for i in range(cloud_server_array .size()):
		if cloud_researches[i].isResearched == true:
			cloud_server_array[i].visible = true
			cloud_server_array[i].data_server_res.isResearched = true
			cloud_Buttons[i].visible = true


#func _on_price_1_research_research_pressed():
	#PlrStats.CloudMoneyValue *= 3
	#PlrStats.CoreMoneyValue *= 2
	#PlrStats.DataMoneyValue *= 2


#func _on_hardware_1_research_research_pressed():
	#for i in upgrades_Array.size():
	#	upgrades_Array[i].dataValue *= 2
	#PlrStats.CloudServer_Space *= 2
	#PlrStats.DataServer_Space *= 2
	#PlrStats.CoreServer_Space *= 2



func _on_contract_2_researched():
	contract_Research(0)


func _on_contract_3_researched():
	contract_Research(1)


func _on_contract_4_researched():
	contract_Research(2)


func _on_contract_5_researched():
	contract_Research(3)


func _on_contract_6_researched():
	contract_Research(4)


func contract_Research(number):
	researched_ContractScreen.emit(number)

func _on_acc_contract_2_researched():
	acc_Contract_Research(0)


func _on_acc_contract_3_researched():
	acc_Contract_Research(1)


func _on_acc_contract_4_researched():
	acc_Contract_Research(2)


func _on_acc_contract_5_researched():
	acc_Contract_Research(3)


func _on_acc_contract_6_researched():
	acc_Contract_Research(4)


func _on_acc_contract_7_researched():
	acc_Contract_Research(5)


func _on_acc_contract_8_researched():
	acc_Contract_Research(6)


func _on_acc_contract_9_researched():
	acc_Contract_Research(7)


func _on_acc_contract_10_researched():
	acc_Contract_Research(8)

func acc_Contract_Research(number):
	researched_AcceptedContract.emit(number)
	PlrStats.set_accContractSpace(1)
