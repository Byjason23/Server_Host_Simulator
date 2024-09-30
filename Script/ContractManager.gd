extends Panel


@export var contractData : contract_Data

@onready var contract_wait_timer = %Contract_Wait_Timer
@onready var core_c = %CoreC
@onready var cloud_c = %CloudC
@onready var data_c = %DataC
@onready var money_c_1 = %MoneyC1
@onready var deciline_button_c_1 = %Deciline_Button_C1
@onready var accept_button_c_1 = %Accept_Button_C1
@onready var server_cap_panel = %ServerCap_Panel
@onready var money_value_panel = %Money_Value_Panel
@onready var skip_wait_time = %skip_wait_time
@onready var timer_text = %Timer_Text
@onready var update_timer = %Update_Timer

func _ready():
	contractData.generateContract()
	update_Value()

func _on_accept_button_c_1_pressed():
	update_timer.start()
	contractData.accept_Contract()
	#skip_wait_time.visible = true
	#timer_text.visible = true
	#set_Visible_false()
	#contract_wait_timer.start()
	update_Value()

func _on_deciline_button_c_1_pressed():
	contractData.deceline_Contract()
	update_timer.start()
	#skip_wait_time.visible = true
	#timer_text.visible = true
	#set_Visible_false()
	#contract_wait_timer.start()
	update_Value()

func update_Value():
	core_c.text = "[center]" + str(contractData.coreValue) + "[/center]"
	cloud_c.text = "[center]" + str(contractData.cloudValue) + "[/center]"
	data_c.text = "[center]" + str(contractData.dataValue) + "[/center]"
	money_c_1.text = "[center]" + str(contractData.moneyValue) + "[/center]"

func set_Visible_false():
	deciline_button_c_1.visible = false
	accept_button_c_1.visible = false
	server_cap_panel.visible = false
	money_value_panel.visible = false

func set_Visible_true():
	deciline_button_c_1.visible = true
	accept_button_c_1.visible = true
	server_cap_panel.visible = true
	money_value_panel.visible = true


func _on_contract_wait_timer_timeout():
	update_timer.stop()
	set_Visible_true()
	skip_wait_time.visible = false
	timer_text.visible = false


func _on_update_timer_timeout():
	var m = int(contract_wait_timer.time_left / 60.0)
	var s = contract_wait_timer.time_left - m * 60
	timer_text.text = "[center]" + '%02d:%02d' % [m,s]


func _on_skip_wait_time_get_rewardfrom_ad():
	_on_contract_wait_timer_timeout()
