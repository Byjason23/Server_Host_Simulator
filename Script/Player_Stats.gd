extends Resource
class_name PlayerStats

@export var Money : int = 0
@export var Research_Points : float = 0
@export var DataServer_Space : float = 5
@export var DataServer_UsedSpace : float = 0
@export var CloudServer_Space : float = 10
@export var CloudServer_UsedSpace : float = 0
@export var CoreServer_Space : float = 7
@export var CoreServer_UsedSpace : float = 0
@export var acContract : int = 0
@export var acContractSpace : int = 1
@export var DataMoneyValue : int = 3
@export var CloudMoneyValue : int = 1
@export var CoreMoneyValue : int = 2
@export var allMoneyPerSecond : int
@export var saveTime : int
#Werte für Contracts
@export var minCoreValue : int = 1
@export var maxCoreValue : int = 7

@export var minDataValue : int = 2
@export var maxDataValue : int = 5

@export var minCloudValue : int = 5
@export var maxCloudValue : int = 10
@export var firstTimePlayed : bool = true
@export var gameVersion : int

func get_Money():
	return Money
func set_Money(value):
	Money += value
func get_Research_Points ():
	return Research_Points
func set_Research_Points(value):
	Research_Points += value
func set_data_serve_space(value):
	DataServer_Space += value
func get_CloudServer_Space():
	return CloudServer_Space
func set_CloudServer_Space(value):
	CloudServer_Space += value
func get_CloudServer_UsedSpace():
	return CloudServer_UsedSpace
func set_CloudServer_UsedSpace(value):
	CloudServer_UsedSpace += value
func get_CoreServer_UsedSpace():
	return CoreServer_UsedSpace
func set_CoreServer_UsedSpace(value):
	CoreServer_UsedSpace += value
func get_DataServer_UsedSpace():
	return DataServer_UsedSpace
func set_DataServer_UsedSpace(value):
	DataServer_UsedSpace += value
func get_accContract():
	return acContract	
func set_accContract(value):
	acContract += value	
func get_accContractSpace():
	return acContractSpace
func set_accContractSpace(value):
	acContractSpace += value
func get_allMoneyPerSecond():
	return allMoneyPerSecond
func set_allMoneyPerSecond(value):
	allMoneyPerSecond += value
func decrease_money(value):
	Money -= value
func decrease_research_points(value):
	Research_Points -= value



func update_Cloud_Contract_Values():
	var random_value = randi() % 100
	
	var incrementCloud = 0
	if random_value < 45:
		incrementCloud = randi_range(int(CloudServer_Space * 0.1), int(CloudServer_Space * 0.45))
	elif random_value < 75:
		incrementCloud = randi_range(int(CloudServer_Space * 0.45), int(CloudServer_Space * 0.75))
	else:
		incrementCloud = randi_range(int(CloudServer_Space * 0.75), int(CloudServer_Space * 1.0))
	
	maxCloudValue = incrementCloud
	minCloudValue = maxCloudValue - randi_range(minCloudValue, maxCloudValue - 1)

func update_Core_Contract_Value():
	var random_value = randi() % 100 
	
	var incrementCore = 0
	if random_value < 45:
		incrementCore = randi_range(int(CoreServer_Space * 0.1), int(CoreServer_Space * 0.45))
	elif random_value < 75:
		incrementCore = randi_range(int(CoreServer_Space * 0.45), int(CoreServer_Space * 0.75))
	else:
		incrementCore = randi_range(int(CoreServer_Space * 0.75), int(CoreServer_Space * 1.0))
		
	maxCoreValue = incrementCore
	minCoreValue = maxCoreValue - randi_range(minCoreValue, maxCoreValue - 1)

func update_Data_Contract_Value():
	var random_value = randi() % 100  
	
	var incrementData = 0
	if random_value < 45:
		incrementData = randi_range(int(DataServer_Space * 0.1), int(DataServer_Space * 0.45))
	elif random_value < 75:
		incrementData = randi_range(int(DataServer_Space * 0.45), int(DataServer_Space * 0.75))
	else:
		incrementData = randi_range(int(DataServer_Space * 0.75), int(DataServer_Space * 1.0))
	
	maxDataValue = incrementData
	minDataValue = maxDataValue - randi_range(minDataValue, maxDataValue - 1)
