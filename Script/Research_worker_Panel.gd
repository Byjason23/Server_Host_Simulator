extends Node

@export var worker_res : research_Worker
@export var Plr_Stats : PlayerStats
@onready var worker_name = %Worker_Name
@onready var money_cost = %Money_Cost
@onready var producing = %Producing
@onready var description = %Description
@onready var owned = %Owned



func _ready():
	updateUI()
	
func updateUI():
	worker_name.text = worker_res.Worker_Name
	money_cost.text = str(worker_res.money_cost)
	producing.text = ("Produces " + str(worker_res.research_points_value) + " RP Every Second")
	description.text = worker_res.Worker_Desciption
	owned.text = ("Owned: " + str(worker_res.reasearch_worker_bought))


func _on_buy_button_pressed():
	if(Plr_Stats.Money >= worker_res.money_cost):
		worker_res.reasearch_worker_bought += 1
		Plr_Stats.decrease_money(worker_res.money_cost)
		updateUI()


func _on_timer_timeout():
	if(worker_res.reasearch_worker_bought > 0):
		Plr_Stats.Research_Points += (worker_res.research_points_value * worker_res.reasearch_worker_bought)


func _on_control_update_after_load():
	updateUI()
