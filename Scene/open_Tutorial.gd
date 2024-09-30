extends Button


@onready var tutorial_screen = %Tutorial_Screen



func _on_pressed():
	tutorial_screen.visible = true




func _on_close_tutorial_pressed():
	tutorial_screen.visible = false
