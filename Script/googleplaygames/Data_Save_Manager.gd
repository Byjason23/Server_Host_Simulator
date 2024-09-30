extends Node

@export var GPGSScript : Script
@export var accContracts : Array[accContract_data]
@export var cloudServerUpgrades : Array[data_Server_Upgrade]
@export var dataServerUpgrades : Array[data_Server_Upgrade]
@export var coreServerUpgrades : Array[data_Server_Upgrade]
@export var researchesArray : Array[Research_template]
@export var researchWorkerArray : Array[research_Worker]
@export var PLRStats : PlayerStats
var count_save : int 

signal save(data) 
signal newGameVersion()
signal loadaftermigration()
signal loadingbar_Playerstats(value)
signal loadingbar_CloudUpgrades(value)
signal loadingbar_CoreUpgrades(value)
signal loadingbar_DataUpgrades(value)
signal loadingbar_research(value)
signal loadingbar_contracts(value)
signal loadingbar_finisch
signal loaded_Playerstats
signal load_success
signal calc_Offline_Earnings_Contract(moneyvalue)
signal calc_Offline_Earnings_Research_Worker(workerbought, rpvalue)
signal load_cloudRack(data_Server_Rack)
signal load_dataRack(data_Server_Rack)
signal load_coreRack(data_Server_Rack)

func get_data_dict():
	var player_data: Dictionary = {
		"money": PLRStats.Money,
		"researchpoints": PLRStats.Research_Points,
		"accContracts": PLRStats.acContract,
		"coreServerUsedSpace": PLRStats.CoreServer_UsedSpace,
		"coreServerSpace": PLRStats.CoreServer_Space,
		"cloudServerUsedSpace": PLRStats.CloudServer_UsedSpace,
		"cloudServerSpace": PLRStats.CloudServer_Space,
		"dataServerUsedSpace": PLRStats.DataServer_UsedSpace,
		"dataServerSpace": PLRStats.DataServer_Space,
		"saveTime": int(Time.get_unix_time_from_system()),
		"firstTimePlayed": PLRStats.firstTimePlayed,
		"minCoreValue": PLRStats.minCoreValue,
		"minCloudValue": PLRStats.minCloudValue,
		"minDataValue": PLRStats.minDataValue,
		"maxCoreValue": PLRStats.maxCoreValue,
		"maxCloudValue": PLRStats.maxCloudValue,
		"maxDataValue": PLRStats.maxDataValue,
		"gameVersion": PLRStats.gameVersion
	}
	
	for i in range(cloudServerUpgrades.size()):
		player_data["cloudUpgrade" + str(i)] = {
			"cloudValue": cloudServerUpgrades[i].dataValue,
			"costServerRack": cloudServerUpgrades[i].cost_serverrack,
			"updatesBougthServerRack": cloudServerUpgrades[i].updates_bought_serverrack,
			"isResearched": cloudServerUpgrades[i].isResearched,
		}
		for key in cloudServerUpgrades[i].Server.keys():
			player_data["cloudUpgrade" + str(i) + "_Server" + str(key)] = {
				"cost": cloudServerUpgrades[i].Server[key].cost,
				"updatesBought": cloudServerUpgrades[i].Server[key].updates_bought,
		}
	
	for i in range(dataServerUpgrades.size()):
		player_data["dataUpgrade" + str(i)] = {
			"dataValue": dataServerUpgrades[i].dataValue,
			"costServerRack": dataServerUpgrades[i].cost_serverrack,
			"updatesBougthServerRack": dataServerUpgrades[i].updates_bought_serverrack,
			"isResearched": dataServerUpgrades[i].isResearched,
		}
		for key in dataServerUpgrades[i].Server.keys():
			player_data["dataUpgrade" + str(i) + "_Server" + str(key)] = {
				"cost": dataServerUpgrades[i].Server[key].cost,
				"updatesBought": dataServerUpgrades[i].Server[key].updates_bought,
		}
	
	for i in range(coreServerUpgrades.size()):
		player_data["coreUpgrade" + str(i)] = {
			"coreValue": coreServerUpgrades[i].dataValue,
			"costServerRack": coreServerUpgrades[i].cost_serverrack,
			"updatesBougthServerRack": coreServerUpgrades[i].updates_bought_serverrack,
			"isResearched": coreServerUpgrades[i].isResearched,
		} 
		for key in coreServerUpgrades[i].Server.keys():
			player_data["coreUpgrade" + str(i) + "_Server" + str(key)] = {
				"cost": coreServerUpgrades[i].Server[key].cost,
				"updatesBought": coreServerUpgrades[i].Server[key].updates_bought,
		}
	
	for i in range(accContracts.size()):
		player_data["accContract" + str(i)] = {
			"datavalue": accContracts[i].dataValue,
			"cloudvalue": accContracts[i].cloudValue,
			"corevalue": accContracts[i].coreValue,
			"moneyvalue": accContracts[i].moneyValue,
			"moneytimevalue": accContracts[i].moneyTimeValue,
			"contractused": accContracts[i].contractUsed,
		}
	
	var researchdata : Dictionary = {
		
	}
	
	for i in range(researchesArray.size()):
		researchdata["research" + str(i)] = {
			"isresearched": researchesArray[i].isResearched,
			"actionExecuted": researchesArray[i].action_Executed
		}
		
	for i in range(researchWorkerArray.size()):
		researchdata["researchworker" + str(i)] = {
			"workerBought": researchWorkerArray[i].reasearch_worker_bought,
			"pointvalue": researchWorkerArray[i].research_points_value,
		}
	
	
	var data_to_save: Dictionary = {
		"playerdata": player_data,
		"researchdata": researchdata,
	}
	
	return data_to_save


func load_gamedata(data_to_load: Dictionary):
	var curren_Version = int(PLRStats.gameVersion)
	var loaded_Version = int(data_to_load["playerdata"]["gameVersion"])
	if(curren_Version != loaded_Version or loaded_Version == null):
		print("newGameVersion")
		newGameVersion.emit()
	else:
		PLRStats.Money = data_to_load["playerdata"]["money"]
		PLRStats.Research_Points = data_to_load["playerdata"]["researchpoints"]
		PLRStats.saveTime = data_to_load["playerdata"]["saveTime"]
		PLRStats.acContract = data_to_load["playerdata"]["accContracts"]
		PLRStats.CloudServer_Space = data_to_load["playerdata"]["cloudServerSpace"]
		PLRStats.CloudServer_UsedSpace = data_to_load["playerdata"]["cloudServerUsedSpace"]
		PLRStats.CoreServer_Space = data_to_load["playerdata"]["coreServerSpace"]
		PLRStats.CoreServer_UsedSpace = data_to_load["playerdata"]["coreServerUsedSpace"]
		PLRStats.DataServer_Space = data_to_load["playerdata"]["dataServerSpace"]
		PLRStats.DataServer_UsedSpace = data_to_load["playerdata"]["dataServerUsedSpace"]
		PLRStats.firstTimePlayed = data_to_load["playerdata"]["firstTimePlayed"]
		PLRStats.minCloudValue = data_to_load["playerdata"]["minCloudValue"]
		PLRStats.minCoreValue = data_to_load["playerdata"]["minCoreValue"]
		PLRStats.minDataValue = data_to_load["playerdata"]["minDataValue"]
		PLRStats.maxCloudValue = data_to_load["playerdata"]["maxCloudValue"]
		PLRStats.maxCoreValue = data_to_load["playerdata"]["maxCloudValue"]
		PLRStats.maxDataValue = data_to_load["playerdata"]["maxDataValue"]
		PLRStats.gameVersion = data_to_load["playerdata"]["gameVersion"]
	
		loadingbar_Playerstats.emit(20)
		loaded_Playerstats.emit()

	
		for i in range(cloudServerUpgrades.size()):
			if(cloudServerUpgrades[i] != null):
				var upgrade_data = data_to_load["playerdata"]["cloudUpgrade" + str(i)]
				cloudServerUpgrades[i].dataValue = upgrade_data["cloudValue"]
				cloudServerUpgrades[i].cost_serverrack = upgrade_data["costServerRack"]
				cloudServerUpgrades[i].updates_bought_serverrack = upgrade_data["updatesBougthServerRack"]
				cloudServerUpgrades[i].isResearched = upgrade_data["isResearched"]
				if cloudServerUpgrades[i].isResearched == true:
					load_cloudRack.emit(cloudServerUpgrades[i])
					
			for n in cloudServerUpgrades[i].Server.keys():
				var server_data = data_to_load["playerdata"]["cloudUpgrade" + str(i) + "_Server" + str(n)]
				cloudServerUpgrades[i].Server[n].cost = server_data["cost"]
				cloudServerUpgrades[i].Server[n].updates_bought = server_data["updatesBought"]
				#if cloudServerUpgrades[i].Server[n].updates_bought >= 1:
					#cloudServerUpgrades[i].upgrade_server_sig.emit(n)
					#print("cloudsignal")
	
		loadingbar_CloudUpgrades.emit(20)
		
		for i in range(dataServerUpgrades.size()):
			var upgrade_data = data_to_load["playerdata"]["dataUpgrade" + str(i)]
			dataServerUpgrades[i].dataValue = upgrade_data["dataValue"]
			dataServerUpgrades[i].cost_serverrack = upgrade_data["costServerRack"]
			dataServerUpgrades[i].updates_bought_serverrack = upgrade_data["updatesBougthServerRack"]
			dataServerUpgrades[i].isResearched = upgrade_data["isResearched"]
			if dataServerUpgrades[i].isResearched == true:
				load_dataRack.emit(dataServerUpgrades[i])
				
			for n in dataServerUpgrades[i].Server.keys():
				var server_data = data_to_load["playerdata"]["dataUpgrade" + str(i) + "_Server" + str(n)]
				dataServerUpgrades[i].Server[n].cost = server_data["cost"]
				dataServerUpgrades[i].Server[n].updates_bought = server_data["updatesBought"]
				#if dataServerUpgrades[i].Server[n].updates_bought >= 1:
					#dataServerUpgrades[i].upgrade_server_sig.emit(n)
					#print("datasignal")
	
		loadingbar_DataUpgrades.emit(20)
	
		for i in range(coreServerUpgrades.size()):
			var upgrade_data = data_to_load["playerdata"]["coreUpgrade" + str(i)]
			coreServerUpgrades[i].dataValue = upgrade_data["coreValue"]
			coreServerUpgrades[i].cost_serverrack = upgrade_data["costServerRack"]
			coreServerUpgrades[i].updates_bought_serverrack = upgrade_data["updatesBougthServerRack"]
			coreServerUpgrades[i].isResearched = upgrade_data["isResearched"]
			if coreServerUpgrades[i].isResearched == true:
				load_coreRack.emit(coreServerUpgrades[i])
				
			for n in coreServerUpgrades[i].Server.keys():
				var server_data = data_to_load["playerdata"]["coreUpgrade" + str(i) + "_Server" + str(n)]
				coreServerUpgrades[i].Server[n].cost = server_data["cost"]
				coreServerUpgrades[i].Server[n].updates_bought = server_data["updatesBought"]
				#if coreServerUpgrades[i].Server[n].updates_bought >= 1:
					#coreServerUpgrades[i].upgrade_server_sig.emit(n)
					#print("coresignal")
	
		loadingbar_CoreUpgrades.emit(20)
		for i in range(accContracts.size()):
			var contract_data = data_to_load["playerdata"]["accContract" + str(i)]
			accContracts[i].dataValue = contract_data["datavalue"]
			accContracts[i].cloudValue = contract_data["cloudvalue"]
			accContracts[i].coreValue = contract_data["corevalue"]
			accContracts[i].moneyValue = contract_data["moneyvalue"]
			accContracts[i].moneyTimeValue = contract_data["moneytimevalue"]
			accContracts[i].contractUsed = contract_data["contractused"]
			if accContracts[i].contractUsed == true:
				calc_Offline_Earnings_Contract.emit(accContracts[i].moneyValue)
			
		loadingbar_contracts.emit(10)

		for i in range(researchesArray.size()):
				var research_data = data_to_load["researchdata"]["research" + str(i)]
				researchesArray[i].isResearched = research_data["isresearched"]
				researchesArray[i].action_Executed = research_data["actionExecuted"]

		
		loadingbar_research.emit(10)
		
		for i in range(researchWorkerArray.size()):
			var researchWorkerdata = data_to_load["researchdata"]["researchworker" + str(i)]
			researchWorkerArray[i].reasearch_worker_bought = researchWorkerdata["workerBought"]
			researchWorkerArray[i].research_points_value = researchWorkerdata["pointvalue"]
			if researchWorkerArray[i].reasearch_worker_bought > 0:
				calc_Offline_Earnings_Research_Worker.emit(researchWorkerArray[i].reasearch_worker_bought, researchWorkerArray[i].research_points_value)
	
		load_server()
		

func load_server():
	await get_tree().create_timer(1).timeout
	for i in range(coreServerUpgrades.size()):
		coreServerUpgrades[i].load_Server_onload()
	for i in range(cloudServerUpgrades.size()): 
		cloudServerUpgrades[i].load_Server_onload()
	for i in range(dataServerUpgrades.size()):
		dataServerUpgrades[i].load_Server_onload()
	load_success.emit()
	loadingbar_finisch.emit()


func _on_wait_timer_end_timeout():
	save.emit(get_data_dict())
	
func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		print("save on back")
		save.emit(get_data_dict())
	if what == MainLoop.NOTIFICATION_APPLICATION_PAUSED:
		if count_save < 1 :
			count_save += 1
			print("save on pause")
			save.emit(get_data_dict())

func _on_gpgsm_arker_load_game_signal(data_to_load):
		load_gamedata(data_to_load)


func _on_button_pressed():
	print("migrating_data")
	save.emit(migrate_data())
	loadaftermigration.emit()
	


func migrate_data():
	var player_data: Dictionary = {
		"money": PLRStats.Money,
		"researchpoints": PLRStats.Research_Points,
		"accContracts": PLRStats.acContract,
		"coreServerUsedSpace": PLRStats.CoreServer_UsedSpace,
		"coreServerSpace": PLRStats.CoreServer_Space,
		"cloudServerUsedSpace": PLRStats.CloudServer_UsedSpace,
		"cloudServerSpace": PLRStats.CloudServer_Space,
		"dataServerUsedSpace": PLRStats.DataServer_UsedSpace,
		"dataServerSpace": PLRStats.DataServer_Space,
		"saveTime": int(Time.get_unix_time_from_system()),
		"firstTimePlayed": PLRStats.firstTimePlayed,
		"minCoreValue": PLRStats.minCoreValue,
		"minCloudValue": PLRStats.minCloudValue,
		"minDataValue": PLRStats.minDataValue,
		"maxCoreValue": PLRStats.maxCoreValue,
		"maxCloudValue": PLRStats.maxCloudValue,
		"maxDataValue": PLRStats.maxDataValue,
		"gameVersion": PLRStats.gameVersion
	}
	print(player_data)
	
	for i in range(cloudServerUpgrades.size()):
		player_data["cloudUpgrade" + str(i)] = {
			"cloudValue": cloudServerUpgrades[i].dataValue,
			"costServer": cloudServerUpgrades[i].cost_server,
			"updatesBougthServer": cloudServerUpgrades[i].updates_bought_server,
			"costServerRack": cloudServerUpgrades[i].cost_serverrack,
			"updatesBougthServerRack": cloudServerUpgrades[i].updates_bought_serverrack,
			"isResearched": cloudServerUpgrades[i].isResearched,
		}
	
	for i in range(dataServerUpgrades.size()):
		player_data["dataUpgrade" + str(i)] = {
			"dataValue": dataServerUpgrades[i].dataValue,
			"costServer": dataServerUpgrades[i].cost_server,
			"updatesBougthServer": dataServerUpgrades[i].updates_bought_server,
			"costServerRack": dataServerUpgrades[i].cost_serverrack,
			"updatesBougthServerRack": dataServerUpgrades[i].updates_bought_serverrack,
			"isResearched": dataServerUpgrades[i].isResearched,
		}
		
	
	for i in range(coreServerUpgrades.size()):
		player_data["coreUpgrade" + str(i)] = {
			"coreValue": coreServerUpgrades[i].dataValue,
			"costServer": coreServerUpgrades[i].cost_server,
			"updatesBougthServer": coreServerUpgrades[i].updates_bought_server,
			"costServerRack": coreServerUpgrades[i].cost_serverrack,
			"updatesBougthServerRack": coreServerUpgrades[i].updates_bought_serverrack,
			"isResearched": coreServerUpgrades[i].isResearched,
		} 
		
	
	for i in range(accContracts.size()):
		player_data["accContract" + str(i)] = {
			"datavalue": accContracts[i].dataValue,
			"cloudvalue": accContracts[i].cloudValue,
			"corevalue": accContracts[i].coreValue,
			"moneyvalue": accContracts[i].moneyValue,
			"moneytimevalue": accContracts[i].moneyTimeValue,
			"contractused": accContracts[i].contractUsed,
		}
	
	var researchdata : Dictionary = {
		
	}
	
	for i in range(researchesArray.size()):
		researchdata["research" + str(i)] = {
			"isresearched": researchesArray[i].isResearched,
			"actionExecuted": researchesArray[i].action_Executed
		}
		
	for i in range(researchWorkerArray.size()):
		researchdata["researchworker" + str(i)] = {
			"workerBought": researchWorkerArray[i].reasearch_worker_bought,
			"pointvalue": researchWorkerArray[i].research_points_value,
		}
	
	
	var data_to_save: Dictionary = {
		"playerdata": player_data,
		"researchdata": researchdata,
	}
	
	return data_to_save
