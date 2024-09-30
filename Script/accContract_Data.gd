extends Resource

class_name accContract_data

@export var coreValue : float

@export var dataValue : float

@export var cloudValue : float

@export var moneyValue : float

@export var moneyTimeValue : float

@export var contractUsed : bool

# Getter-Methode für coreValue
func get_coreValue():
	return coreValue

# Setter-Methode für coreValue
func set_coreValue(value):
	coreValue = value

# Getter-Methode für dataValue
func get_dataValue():
	return dataValue

# Setter-Methode für dataValue
func set_dataValue(value):
	dataValue = value

# Getter-Methode für cloudValue
func get_cloudValue():
	return cloudValue

# Setter-Methode für cloudValue
func set_cloudValue(value):
	cloudValue = value

func get_moneyValue():
	return moneyValue
	
func set_moneyValue(value):
	moneyValue = value

func get_moneyTimeValue():
	return moneyTimeValue
	
func set_moneyTimeValue(value):
	moneyTimeValue = value

func get_contractUsed():
	return contractUsed
	
func set_contractUsed(value):
	contractUsed = value
	
