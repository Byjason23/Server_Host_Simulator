extends Resource

class_name contract_Data

@export var accContract_Array : Array[accContract_data]
@export var Player_StatsRes : PlayerStats
@export var coreValue : float
@export var dataValue : float
@export var cloudValue: float
@export var moneyValue : float
@export var timeValue : float


func get_coreValue():
	return coreValue

func set_coreValue(value):
	coreValue = value

func get_dataValue():
	return dataValue

func set_dataValue(value):
	dataValue = value

func get_cloudValue():
	return cloudValue

func set_cloudValue(value):
	cloudValue = value

func get_moneyValue():
	return moneyValue

func set_moneyValue(value):
	moneyValue = value

func get_timeValue():
	return timeValue

func set_timeValue(value):
	timeValue = value

func generateContract():
	var cloudValueg = randi_range(Player_StatsRes.minCloudValue, Player_StatsRes.maxCloudValue)
	var dataValueg = randi_range(Player_StatsRes.minDataValue, Player_StatsRes.maxDataValue)
	var coreValueg = randi_range(Player_StatsRes.minCoreValue, Player_StatsRes.maxCoreValue) 
	var time = 10.0
	
	set_timeValue(time)
	set_cloudValue(cloudValueg)
	set_coreValue(coreValueg)
	set_dataValue(dataValueg)
	
	var moneyvalue = cloudValue * Player_StatsRes.CloudMoneyValue + coreValue * Player_StatsRes.CoreMoneyValue + dataValue * Player_StatsRes.DataMoneyValue
	set_moneyValue(moneyvalue)

func accept_Contract ():
	if(Player_StatsRes.acContract < Player_StatsRes.acContractSpace):
		if(Player_StatsRes.CloudServer_Space >= cloudValue && Player_StatsRes.CoreServer_Space >= coreValue && Player_StatsRes.DataServer_Space >= dataValue):
			if(cloudValue + Player_StatsRes.CloudServer_UsedSpace <= Player_StatsRes.CloudServer_Space): 
				if(coreValue + Player_StatsRes.CoreServer_UsedSpace <= Player_StatsRes.CoreServer_Space): 
					if(dataValue + Player_StatsRes.DataServer_UsedSpace <= Player_StatsRes.DataServer_Space):
						var moneyvalue = moneyValue
						Player_StatsRes.set_CloudServer_UsedSpace(get_cloudValue())
						Player_StatsRes.set_CoreServer_UsedSpace(get_coreValue())
						Player_StatsRes.set_DataServer_UsedSpace(get_dataValue())
						Player_StatsRes.set_accContract(1)
						for i in range(accContract_Array.size()):
							if not accContract_Array[i].contractUsed:
								accContract_Array[i].set_cloudValue(get_cloudValue())
								accContract_Array[i].set_coreValue(get_coreValue())
								accContract_Array[i].set_dataValue(get_dataValue())
								accContract_Array[i].set_moneyValue(moneyvalue)
								accContract_Array[i].contractUsed = true
								generateContract()
								break


func deceline_Contract() :
	Player_StatsRes.update_Cloud_Contract_Values()
	Player_StatsRes.update_Core_Contract_Value()
	Player_StatsRes.update_Data_Contract_Value()
	generateContract()
