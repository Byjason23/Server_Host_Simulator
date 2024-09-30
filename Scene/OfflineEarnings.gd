extends Marker2D

@export var PlrStats : PlayerStats
@export var currentTime : int
var offlineTime
var contractTime : int
var researchTime
var money_Earnings : int
var research_Earnings : int

signal show_Offlineearnings(moneyEarning, rpEarning, offlineTime)
signal first_Start()

func _ready():
		currentTime = int(Time.get_unix_time_from_system())


func _on_save_marker_loaded_playerstats():
	if PlrStats.firstTimePlayed == false:
		print("saveTime :" + str(PlrStats.saveTime))
		if PlrStats.saveTime != 0:
			offlineTime = currentTime - PlrStats.saveTime
			contractTime = offlineTime / 10
			researchTime = offlineTime 
	else:
		first_Start.emit()
		PlrStats.firstTimePlayed = false
		

func _on_save_marker_calc_offline_earnings_contract(moneyvalue):
	money_Earnings += moneyvalue * contractTime


func _on_save_marker_calc_offline_earnings_research_worker(workerbought, rpvalue):
	var one_Worker = rpvalue * contractTime
	research_Earnings += one_Worker * workerbought


func _on_save_marker_load_success():
	if offlineTime != null:
		show_Offlineearnings.emit(money_Earnings, research_Earnings, time_convert(offlineTime))

func time_convert(time_in_sec):
	var seconds = time_in_sec%60
	var minutes = (time_in_sec/60)%60
	var hours = (time_in_sec/60)/60
	
	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
