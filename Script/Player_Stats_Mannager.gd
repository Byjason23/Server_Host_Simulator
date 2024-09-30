extends Node

@export var PlayerStatsRes : PlayerStats
@export var accContract_1 : accContract_data
@export var accContract_2 : accContract_data
@export var accContract_3 : accContract_data
@export var accContract_4 : accContract_data


@onready var money_value = %MoneyValue
@onready var researchpoints_value = %ResearchpointsValue
@onready var data_value = %DataValue
@onready var core_value = %"Core Value"
@onready var cloud_value = %CloudValue

@onready var data_server_storage = %Data_Server_Storage
@onready var core_server_storage = %Core_Server_Storage
@onready var cloud_server_storage = %Cloud_Server_Storage


func _ready():
	UpdateValue()


func UpdateValue ():
	money_value.text = str(PlayerStatsRes.Money)
	researchpoints_value.text = str(PlayerStatsRes.Research_Points)
	data_value.text = (str(PlayerStatsRes.DataServer_UsedSpace) + "/" + str(PlayerStatsRes.DataServer_Space))
	data_server_storage.max_value = PlayerStatsRes.DataServer_Space
	data_server_storage.value = PlayerStatsRes.DataServer_UsedSpace
	core_value.text = (str(PlayerStatsRes.CoreServer_UsedSpace) + "/" + str(PlayerStatsRes.CoreServer_Space))
	core_server_storage.max_value = PlayerStatsRes.CoreServer_Space
	core_server_storage.value = PlayerStatsRes.CoreServer_UsedSpace
	cloud_value.text = (str(PlayerStatsRes.CloudServer_UsedSpace) + "/" + str(PlayerStatsRes.CloudServer_Space))
	cloud_server_storage.max_value = PlayerStatsRes.CloudServer_Space
	cloud_server_storage.value = PlayerStatsRes.CloudServer_UsedSpace
	

func _on_timer_timeout():
	UpdateValue()
