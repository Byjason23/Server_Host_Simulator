extends Panel

var topContentisShown = false

@onready var top_content_panel = %TopContentPanel
@onready var show_hide_top_content = %Show_hideTopContent
@onready var arrow_down = %ArrowDown
@onready var arrow_up = %ArrowUp
@onready var settings = %Settings
@onready var tutorial = %Tutorial


func show_topContent():
	if(topContentisShown == false):
		var tween = create_tween().set_parallel(true)
		tween.tween_property(top_content_panel, "position", Vector2(-3,34), 1).set_trans(Tween.TRANS_BACK)
		tween.tween_property(show_hide_top_content, "position", Vector2(248,200), 1).set_trans(Tween.TRANS_BACK)
		tween.tween_property(settings, "position", Vector2(679,225), 1).set_trans(Tween.TRANS_BACK)
		tween.tween_property(tutorial, "position", Vector2(10,225), 1).set_trans(Tween.TRANS_BACK)
		arrow_down.visible = false
		arrow_up.visible = true
		topContentisShown = true
	else:
		hide_topContent()
	
func hide_topContent():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(top_content_panel, "position", Vector2(-3,-125), 1).set_trans(Tween.TRANS_BACK)
	tween.tween_property(show_hide_top_content, "position", Vector2(248,50), 1).set_trans(Tween.TRANS_BACK)
	tween.tween_property(settings, "position", Vector2(679,65), 1).set_trans(Tween.TRANS_BACK)
	tween.tween_property(tutorial, "position", Vector2(10,65), 1).set_trans(Tween.TRANS_BACK)
	arrow_down.visible = true
	arrow_up.visible = false
	topContentisShown = false

func _on_show_hide_top_content_pressed():
	show_topContent()
