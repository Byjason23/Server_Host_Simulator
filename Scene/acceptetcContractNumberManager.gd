extends RichTextLabel

@export var PlrRes : PlayerStats
@onready var accepted_contracts_number = %AcceptedContractsNumber

func _on_update_timer_timeout():
	accepted_contracts_number.text = "[center]" + str(PlrRes.acContract) + " / " + str(PlrRes.acContractSpace)
