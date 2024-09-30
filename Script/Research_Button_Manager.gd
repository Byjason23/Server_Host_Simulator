extends Button


@onready var research_ui = %Research_Ui
@export var research_Temp : Research_template
@export var nextLine : Line2D
@export var nextBttn : Button
@export var nextIcon : FontAwesome

signal researched()

func update_UI():
	if(nextBttn != null and nextIcon != null and nextLine != null):
		nextBttn.disabled = false
		nextIcon.modulate = Color(255,255,255)
		nextLine.default_color = Color(255,255,255)

func _on_pressed():
	research_ui.Research_Temp = research_Temp
	research_ui.Update_UI()
	research_ui.visible = true

func research_Complete():
	if research_Temp.isResearched == true and research_Temp.action_Executed < 1:
		researched.emit()
		research_Temp.action_Executed = 1
		update_UI()



func _on_control_update_after_load():
	if research_Temp.isResearched == true:
		update_UI()
