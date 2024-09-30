extends Panel

@onready var progress = $progress
@onready var timer = %Timer
@onready var loading_screen = %"Loading Screen"
@onready var error_text = %error_text
@onready var new_game_version = %NewGameVersion



func _on_save_marker_loadingbar_cloud_upgrades(value):
	progress.value += value


func _on_save_marker_loadingbar_core_upgrades(value):
	progress.value += value


func _on_save_marker_loadingbar_data_upgrades(value):
	progress.value += value


func _on_save_marker_loadingbar_playerstats(value):
	progress.value += value


func _on_save_marker_loadingbar_contracts(value):
	progress.value += value


func _on_save_marker_loadingbar_research(value):
	progress.value += value


func _on_save_marker_loadingbar_finisch():
	loading_screen.visible = false



func _on_gpgsm_arker_sign_in_failed():
	error_text.text = "Failed to conect with google play" 


func _on_gpgsm_arker_load_failed():
	error_text.text = "Please restart the Game" 


func _on_offline_earnings_first_start():
	loading_screen.visible = false
	print("first start")


func _on_timer_timeout():
	loading_screen.visible = false


func _on_save_marker_new_game_version():
	new_game_version.visible = true


func _on_gpgsm_arker_load_on_first_start():
	loading_screen.visible = false
