extends Panel

@export var PlrStats : PlayerStats 

@onready var earnings = %Earnings
@onready var offline_earnings = %"Offline Earnings"
@onready var wait_timer = %WaitTimer


func _on_offline_earnings_show_offlineearnings(moneyEarning, rpEarning, offlineTime):
	earnings.text = "You were away for " + str(offlineTime) + " and earned: " + str(moneyEarning) + " money and " +str(rpEarning) + " Research Points" 
	PlrStats.set_Money(moneyEarning)
	PlrStats.set_Research_Points(rpEarning)
	offline_earnings.visible = true
	wait_timer.start()


func _on_wait_timer_timeout():
	offline_earnings.visible = false
	wait_timer.stop()
