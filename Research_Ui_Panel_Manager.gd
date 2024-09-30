extends Panel

@export var Research_Temp : Research_template
@export var PlrSt : PlayerStats
@onready var research_ui = %Research_Ui
@onready var description = %Description
@onready var money_cost = %Money_Cost
@onready var research_cost = %Research_Cost
@onready var research_name = %Research_Name
@onready var researched = %Researched
@onready var bottom_content = %"Bottom Content"


func Update_UI():
	if(Research_Temp.isResearched == false):
		researched.visible = false
		bottom_content.visible = true
		research_name.text = Research_Temp.Research_Name
		description.text = Research_Temp.Research_Description
		money_cost.text = str(Research_Temp.Money_Cost)
		research_cost.text = str(Research_Temp.Researchpoint_Cost)
	else:
		research_name.text = Research_Temp.Research_Name
		researched.visible = true
		bottom_content.visible = false

func _on_close_button_pressed():
	research_ui.visible = false


func _on_research_button_pressed():
	if (PlrSt.Money >= Research_Temp.Money_Cost && PlrSt.Research_Points >= Research_Temp.Researchpoint_Cost):
		PlrSt.decrease_money(Research_Temp.Money_Cost)
		PlrSt.decrease_research_points(Research_Temp.Researchpoint_Cost)
		Research_Temp.isResearched = true 
		Update_UI()

		var buttons = get_tree().get_nodes_in_group("research_buttons")
		for button in buttons:
			if button.has_method("research_Complete"):
				button.research_Complete()
