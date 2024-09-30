extends Resource

class_name data_Server_Upgrade

signal upgrade_server_sig(id)
signal load_Server(id)

@export var dataValue : int
@export var ServerUpgradeID : int 
@export var Server_Name : String
@export var Server_Description : String
@export var cost_server : int
@export var cost_base_server : int
@export var cost_Multiply_server : float
@export var updates_bought_server : int
@export var cost_serverrack : int
@export var cost_base_serverrack : int
@export var cost_Multiply_serverrack : float
@export var updates_bought_serverrack : int
@export var max_Rack_LVL : int = 5
@export var isResearched : bool 
enum upgradeType {
	dataUpgrade,
	coreUpgrade,
	cloudUpgrade
}
@export var upgradeTypes : upgradeType
@export var Server : Dictionary = {
	1: {"updates_bought": 0, "cost": 100, "base_cost": 100, "multiplier": 1.0, "server_name": "Server 1", "max_LvL": 100, "max_lvl_reached": false},
	2: {"updates_bought": 0, "cost": 200, "base_cost": 200, "multiplier": 1.2, "server_name": "Server 2", "max_LvL": 100, "max_lvl_reached": false},
	3: {"updates_bought": 0, "cost": 300, "base_cost": 300, "multiplier": 1.4, "server_name": "Server 3", "max_LvL": 100, "max_lvl_reached": false},
	4: {"updates_bought": 0, "cost": 400, "base_cost": 400, "multiplier": 1.6, "server_name": "Server 4", "max_LvL": 100, "max_lvl_reached": false},
	5: {"updates_bought": 0, "cost": 500, "base_cost": 500, "multiplier": 1.8, "server_name": "Server 5", "max_LvL": 100, "max_lvl_reached": false},
	6: {"updates_bought": 0, "cost": 600, "base_cost": 600, "multiplier": 2.0, "server_name": "Server 6", "max_LvL": 100, "max_lvl_reached": false},
	7: {"updates_bought": 0, "cost": 700, "base_cost": 700, "multiplier": 2.2, "server_name": "Server 7", "max_LvL": 100, "max_lvl_reached": false},
	8: {"updates_bought": 0, "cost": 800, "base_cost": 800, "multiplier": 2.4, "server_name": "Server 8", "max_LvL": 100, "max_lvl_reached": false},
	9: {"updates_bought": 0, "cost": 900, "base_cost": 900, "multiplier": 2.6, "server_name": "Server 9", "max_LvL": 100, "max_lvl_reached": false},
	10: {"updates_bought": 0, "cost": 1000, "base_cost": 1000, "multiplier": 2.8, "server_name": "Server 10", "max_LvL": 100, "max_lvl_reached": false}
}



func get_dataValue():
	return dataValue

func set_dataValue(value):
	dataValue = value

func get_costServer():
	return cost_server

func set_costServer(value):
	cost_server = value

func get_costServerRack():
	return cost_serverrack

func set_costServerRack(value):
	cost_serverrack = value

func set_updates_bought_server(value):
	updates_bought_server += value

func set_updates_bought_serverrack(value):
	updates_bought_serverrack += value

func set_is_researched(value):
	isResearched = value

func calc_cost_server(index :int):
	@warning_ignore("narrowing_conversion")
	Server[index].cost = Server[index].base_cost * (Server[index].updates_bought * Server[index].multiplier) + (updates_bought_serverrack * Server[index].multiplier)

func calc_cost_serverrack():
	@warning_ignore("narrowing_conversion")
	cost_serverrack = cost_base_serverrack * (updates_bought_serverrack * cost_Multiply_serverrack)

func upgrade_server(index :int):
	Server[index].updates_bought += 1
	calc_cost_server(index)

func upgrade_serverrack():
	updates_bought_serverrack += 1
	@warning_ignore("narrowing_conversion")
	dataValue = dataValue * 2

	calc_cost_serverrack()
	for i in Server:
		Server[i].updates_bought = 0
		Server[i].base_cost *= 2.3
		Server[i].max_lvl_reached = false

func load_Server_onload():
	for i in Server.keys():
		if Server[i].updates_bought >= 1:
			load_Server.emit(i)
	pass
