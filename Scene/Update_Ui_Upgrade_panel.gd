extends Panel

@export var Rack_Data : data_Server_Upgrade#
@export var Plr_Stats : PlayerStats
var server_ID : int
var server_number : int

@onready var server_upgrade_panel: Panel = %Server_Upgrade_Panel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var lvl_progress_bar: RichTextLabel = %LVL_ProgressBar
@onready var server_name_new: RichTextLabel = $Server_Name_new
@onready var upgrade_bttn_server: Button = %Upgrade_Bttn_Server
@onready var upgrade_bttn_server_rack: Button = %Upgrade_Bttn_ServerRack
@onready var rack_desciption: RichTextLabel = %Rack_Desciption
@onready var max_buy_button: Button = %Max_Buy_Button
@onready var rack_requierment: RichTextLabel = %Rack_requierment

@onready var rack_name: RichTextLabel = %Rack_Name

signal update_Server_Number(current_Rack)
signal upgrade_Data_Server_Rack(Rack_Data)
signal upgrade_Cloud_Server_Rack(Rack_Data)
signal upgrade_Core_Server_Rack(Rack_Data)

func update_UI_Server(index):
	if Rack_Data.Server[index]["updates_bought"] != Rack_Data.Server[index]["max_LvL"]:
		progress_bar.max_value = Rack_Data.Server[index]["max_LvL"]
		progress_bar.value = Rack_Data.Server[index]["updates_bought"]
		server_name_new.text = Rack_Data.Server[index]["server_name"]
		lvl_progress_bar.text = "[center]" + str(Rack_Data.Server[index]["updates_bought"]) + " / " + str(Rack_Data.Server[index]["max_LvL"])
		upgrade_bttn_server.text = str(int(Rack_Data.Server[index]["cost"]))
		upgrade_bttn_server.visible = true
		upgrade_bttn_server.disabled = false
		upgrade_bttn_server_rack.visible = false
		server_upgrade_panel.visible = true
		max_buy_button.visible = true
		if max_buy_button.button_pressed == true:
			var calc = calc_Max_Server_Buy(index)
			var cost = calc["cost"]
			var upgrades = calc["upgrade"]
			upgrade_bttn_server.text = "Buy: " + str(upgrades) +  " Upgrades " + str(cost)
	else:
		Rack_Data.Server[index].max_lvl_reached = true
		progress_bar.max_value = Rack_Data.Server[index]["max_LvL"]
		progress_bar.value = Rack_Data.Server[index]["updates_bought"]
		server_name_new.text = Rack_Data.Server[index]["server_name"]
		lvl_progress_bar.text = "[center]" + "Max LVL."
		upgrade_bttn_server.text = "Max LVL."
		upgrade_bttn_server.disabled = true
		upgrade_bttn_server.visible = true
		upgrade_bttn_server_rack.visible = false
		server_upgrade_panel.visible = true

func update_ui():
	rack_name.text = Rack_Data.Server_Name
	rack_desciption.text = Rack_Data.Server_Description

func update_UI_ServerRack():
	if Rack_Data.updates_bought_serverrack != Rack_Data.max_Rack_LVL:
		progress_bar.max_value = Rack_Data.max_Rack_LVL
		progress_bar.value = Rack_Data.updates_bought_serverrack
		server_name_new.text = "Rack"
		lvl_progress_bar.text = "[center]" + str(Rack_Data.updates_bought_serverrack) + " / " + str(Rack_Data.max_Rack_LVL)
		upgrade_bttn_server_rack.visible = true
		max_buy_button.visible = false
		upgrade_bttn_server.visible = false
		server_upgrade_panel.visible = true
		var checked = check_server_lvl(server_number)
		if typeof(checked) == TYPE_BOOL:
			upgrade_bttn_server_rack.disabled = false
			upgrade_bttn_server_rack.text = str(Rack_Data.cost_serverrack)
		else:
			upgrade_bttn_server_rack.disabled = true
			upgrade_bttn_server_rack.text = "need " + str(checked["serverName"]) + " LVL: " + str(checked["maxLvl"]) 
	else:
		progress_bar.max_value = Rack_Data.max_Rack_LVL
		progress_bar.value = Rack_Data.updates_bought_serverrack
		server_name_new.text = "Rack"
		lvl_progress_bar.text = "[center]" + "Max LVL."
		upgrade_bttn_server_rack.text = "Max LVL."
		upgrade_bttn_server_rack.visible = true
		upgrade_bttn_server_rack.disabled = true
		upgrade_bttn_server.visible = false
		max_buy_button.visible = false
		server_upgrade_panel.visible = true

func check_server_lvl(server_nmbr):
	for i in range(1, server_nmbr + 1):  # Schleife von 1 bis server_number
		# Überprüfen, ob der Server das maximale Level erreicht hat
		if not Rack_Data.Server[i]["max_lvl_reached"]:
			# Wenn der Server das Max-Level nicht erreicht hat, gib dessen Infos zurück
			return {
				"maxLvl": Rack_Data.Server[i]["max_LvL"],
				"serverName": Rack_Data.Server[i]["server_name"]
			}
	# Wenn alle Server bis zur angegebenen Nummer das Max-Level erreicht haben
	return true


			

func _on_server_1_update_panel_ui(ID: Variant) -> void:
	server_ID = ID
	update_UI_Server(ID)
	update_ui()


func _on_upgrade_ui_open_ui(_Rack_Data: Variant, servernumber) -> void:
	Rack_Data = _Rack_Data
	print(str(servernumber))
	server_number = servernumber
	update_ui()

func buy_Server(i):
	if max_buy_button.button_pressed == true:
		var calulated_upgr = calc_Max_Server_Buy(i)
		var cost = calulated_upgr["cost"]
		var upgrades = calulated_upgr["upgrade"]
		if Plr_Stats.Money >= cost:
			Plr_Stats.decrease_money(cost)
			for z in upgrades:
				match Rack_Data.upgradeTypes:
					Rack_Data.upgradeType.dataUpgrade:
						Plr_Stats.DataServer_Space += Rack_Data.dataValue
					Rack_Data.upgradeType.coreUpgrade:
						Plr_Stats.CoreServer_Space += Rack_Data.dataValue
					Rack_Data.upgradeType.cloudUpgrade:
						Plr_Stats.CloudServer_Space += Rack_Data.dataValue
				Rack_Data.upgrade_server(i)
				update_UI_Server(i)
				Rack_Data.upgrade_server_sig.emit(i)
	else:
		if Plr_Stats.Money >= Rack_Data.Server[i].cost:
			Plr_Stats.decrease_money(Rack_Data.Server[i].cost)
			match Rack_Data.upgradeTypes:
				Rack_Data.upgradeType.dataUpgrade:
					Plr_Stats.DataServer_Space += Rack_Data.dataValue
				Rack_Data.upgradeType.coreUpgrade:
					Plr_Stats.CoreServer_Space += Rack_Data.dataValue
				Rack_Data.upgradeType.cloudUpgrade:
					Plr_Stats.CloudServer_Space += Rack_Data.dataValue
			Rack_Data.upgrade_server(i)
			update_UI_Server(i)
			Rack_Data.upgrade_server_sig.emit(i)

func buy_ServerRack():
	if Plr_Stats.Money >= Rack_Data.cost_serverrack:
		Plr_Stats.decrease_money(Rack_Data.cost_serverrack)
		Rack_Data.upgrade_serverrack()
		update_UI_ServerRack()
		update_Server_Number.emit(Rack_Data)
		match Rack_Data.upgradeTypes:
			Rack_Data.upgradeType.dataUpgrade:
				upgrade_Data_Server_Rack.emit(Rack_Data)
			Rack_Data.upgradeType.coreUpgrade:
				upgrade_Core_Server_Rack.emit(Rack_Data)
			Rack_Data.upgradeType.cloudUpgrade:
				upgrade_Cloud_Server_Rack.emit(Rack_Data)

func calc_Max_Server_Buy(index : int):
	var current_cost = Rack_Data.Server[index].cost
	var current_upgrades = Rack_Data.Server[index].updates_bought
	var overall_Cost = 0
	var upgrades = 0
	var max_upgrades = Rack_Data.Server[index].max_LvL - Rack_Data.Server[index].updates_bought
	var money = Plr_Stats.Money
	while money >= current_cost:
		if upgrades == max_upgrades:
			break
		else:
			upgrades += 1
			overall_Cost += current_cost
			money -= current_cost
			current_cost = Rack_Data.Server[index].base_cost * ((current_upgrades + upgrades) * Rack_Data.Server[index].multiplier) + (Rack_Data.updates_bought_serverrack * Rack_Data.Server[index].multiplier)
	return {
		"upgrade": upgrades,
		"cost": overall_Cost
	}

func _on_upgrade_bttn_server_pressed() -> void:
	buy_Server(server_ID)


func _on_server_rack_pressed() -> void:
	update_UI_ServerRack()


func _on_upgrade_bttn_server_rack_pressed() -> void:
	buy_ServerRack()


func _on_max_buy_button_toggled(_toggled_on: bool) -> void:
	update_UI_Server(server_ID)
