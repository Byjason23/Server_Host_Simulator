extends Panel


@export var acc_ContractData : accContract_data
@export var PlayeRes_Data : PlayerStats


@onready var core_c_1 = %CoreC1
@onready var cloud_c_1 = %CloudC1
@onready var data_c_1 = %DataC1
@onready var money_c_1 = %MoneyC1
@onready var money_timer = %MoneyTimer
@onready var progress_bar = %ProgressBar


func _ready():
	update_Acc_Value()

func update_Acc_Value():
	core_c_1.text = str(acc_ContractData.coreValue)
	cloud_c_1.text = str(acc_ContractData.cloudValue)
	data_c_1.text = str(acc_ContractData.dataValue)
	money_c_1.text = str(acc_ContractData.moneyValue)

func _on_update_timer_timeout():
	update_Acc_Value()

func progesbarTimer():
		money_timer.set_wait_time(acc_ContractData.moneyTimeValue)
		money_timer.autostart = true
		progress_bar.max_value = 45

func _on_money_timer_timeout():
	if(acc_ContractData.contractUsed == true):
		progress_bar.value += 1
		if(progress_bar.value == progress_bar.max_value):
			progress_bar.value += 1
			PlayeRes_Data.set_Money(acc_ContractData.moneyValue)
			progress_bar.value = 0


func _on_button_pressed(): #cancle button
	if(acc_ContractData.contractUsed == true):
		acc_ContractData.contractUsed = false
		PlayeRes_Data.CloudServer_UsedSpace = PlayeRes_Data.CloudServer_UsedSpace - acc_ContractData.cloudValue
		PlayeRes_Data.CoreServer_UsedSpace = PlayeRes_Data.CoreServer_UsedSpace - acc_ContractData.coreValue
		PlayeRes_Data.DataServer_UsedSpace = PlayeRes_Data.DataServer_UsedSpace - acc_ContractData.dataValue
		PlayeRes_Data.acContract = PlayeRes_Data.acContract - 1
		acc_ContractData.set_cloudValue(0)
		acc_ContractData.set_coreValue(0)
		acc_ContractData.set_dataValue(0)
		acc_ContractData.set_moneyValue(0)
		progress_bar.value = 0
