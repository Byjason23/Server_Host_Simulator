extends Node

@export var ResearchTemp : Research_template
@export var PlrStats : PlayerStats

@onready var research_name = %Research_Name
@onready var research_description = %Research_Description
@onready var research_points_cost = %Research_Points_Cost
@onready var money_cost = %Money_Cost
@onready var research_button = %ResearchButton
@onready var researched_text = %Researched_Text
@onready var research_panel = %Research_panel

signal research_pressed()

func _ready():
	if (ResearchTemp != null):
		update_UI()
 
func update_UI():
	if(ResearchTemp.isResearched == false):
		research_name.text = ResearchTemp.Research_Name
		research_description.text = ResearchTemp.Research_Description
		research_points_cost.text = str(ResearchTemp.Researchpoint_Cost)
		money_cost.text = str(ResearchTemp.Money_Cost)
	else:
		research_panel.visible = false
		researched_text.visible = true


func _on_research_button_pressed():
	if (PlrStats.Money >= ResearchTemp.Money_Cost && PlrStats.Research_Points >= ResearchTemp.Researchpoint_Cost):
		PlrStats.decrease_money(ResearchTemp.Money_Cost)
		PlrStats.decrease_research_points(ResearchTemp.Researchpoint_Cost)
		research_pressed.emit()
		ResearchTemp.isResearched = true 
		update_UI()


func _on_control_update_after_load():
	update_UI()
	if ResearchTemp.isResearched == true and ResearchTemp.id < 1:
		research_pressed.emit()
