extends Button

@onready var contract_wait_timer = %Contract_Wait_Timer

var _rewarded_ad : RewardedAd
var on_user_earned_reward_listener := OnUserEarnedRewardListener.new()
var rewarded_ad_load_callback := RewardedAdLoadCallback.new()

signal get_RewardfromAd

func _ready() -> void:
	rewarded_ad_load_callback.on_ad_failed_to_load = on_rewarded_ad_failed_to_load
	rewarded_ad_load_callback.on_ad_loaded = on_rewarded_ad_loaded
	on_user_earned_reward_listener.on_user_earned_reward = on_user_earned_reward



	
func _on_pressed():
	RewardedAdLoader.new().load("ca-app-pub-3940256099942544/5224354917", AdRequest.new(), rewarded_ad_load_callback)
	
	
func on_rewarded_ad_failed_to_load(adError : LoadAdError):
	print(adError.message)
	
	
func on_rewarded_ad_loaded(rewarded_ad : RewardedAd):
	print("rewarded ad loaded " + str(rewarded_ad._uid))
	self._rewarded_ad = rewarded_ad
		
	if _rewarded_ad:
		_rewarded_ad.show(on_user_earned_reward_listener)
		
	#free memory
	if _rewarded_ad:
		_rewarded_ad.destroy()
		_rewarded_ad = null

func on_user_earned_reward(_rewarded_item : RewardedItem):
		get_RewardfromAd.emit()
