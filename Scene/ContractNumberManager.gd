extends RichTextLabel

@export var PlrRes : PlayerStats
@onready var contractfree = %Contractfree

func _on_update_contract_timer_timeout():
	contractfree.text = "[center]" + str(PlrRes.acContract) + " / " + str(PlrRes.acContractSpace)
