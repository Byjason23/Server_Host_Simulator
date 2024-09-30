extends Marker2D

var GPSG
@export var datamanagerscript: Script

signal load_failed
signal load_onFirst_Start
signal load_game_signal(data_to_load)

func _ready():
	MobileAds.initialize()
	if Engine.has_singleton("GodotPlayGamesServices"):
		GPSG = Engine.get_singleton("GodotPlayGamesServices")
		
		#GPSG.init(true,false,false,"")
		
		GPSG.initWithSavedGames(true, "Server_Host_Sim", false, false, "")
		
		GPSG.connect("_on_sign_in_failed", _on_sign_in_failed)
		GPSG.connect("_on_sign_in_success", _on_sign_in_success)
		GPSG.connect("_on_game_load_success", _on_game_load_success)
		GPSG.connect("_on_game_load_fail", _on_game_load_fail)
		GPSG.connect("_on_game_saved_success", _on_game_saved_success) 
		GPSG.connect("_on_game_saved_fail", _on_game_saved_fail)


func _on_sign_in_success(_userProfile_json: String) -> void:
	var userProfile = JSON.parse_string(_userProfile_json)
	print("singed in " + str(userProfile))
	load_game()
	pass

func _on_sign_in_failed(error_code: int) -> void:
	print("trying to sign in failed " + str(error_code))
	

func _on_game_saved_success():
	print("saved game")
	
func _on_game_saved_fail(error_message: String):
	print("failed to save game " + error_message)
	

func save_game(data_to_save):
	if GPSG:
		GPSG.saveSnapshot("Server_Host_Sim", JSON.stringify(data_to_save), "Savegame")


func show_saved_games():
	if GPSG:
		GPSG.showSavedGames("Server Hoste Sim", false, true, 5)

func load_game():
	if GPSG:
		if GPSG.loadSnapshot("Server_Host_Sim") != null :
			GPSG.loadSnapshot("Server_Host_Sim")

func _on_game_load_success(data):
	if data.strip_edges().length() == 0:
		
		load_onFirst_Start.emit()
	else:
		var game_data: Dictionary = JSON.parse_string(data)
		load_game_signal.emit(game_data)
	


func _on_game_load_fail(errorstring):
	load_failed.emit()
	print("failed to load game " + errorstring)

func _on_sign_in_timer_timeout():
	if GPSG : 
		GPSG.signIn()
	

func _on_save_marker_save(data):
	save_game(data)

func _on_button_pressed():
	show_saved_games()


func _on_save_marker_loadaftermigration():
	await get_tree().create_timer(3).timeout

	load_game()  # Funktion wird nach Ablauf des Timers fortgesetzt
