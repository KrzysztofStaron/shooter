extends HBoxContainer

var ammo : int
var maxAmmo : int 

export var ammoContainers : int
export var ammoPerContainer := 6
onready var lookType : int = ProjectSettings.get_setting("Config/settings/ammoCounter")
 
enum {
	TYPE_COUNTER,
	TYPE_GRAPHIC,
	TYPE_BOTH
}

func _ready() -> void:
	maxAmmo = ammoContainers * ammoPerContainer
	ammo = maxAmmo
	
	get_node("../ammo").text = str(ammo, "/", maxAmmo) 
	
	for i in ammoContainers:
		get_node(str("ammo", i+1)).maxAmmo = ammoPerContainer
		get_node(str("ammo", i+1)).ammo = ammoPerContainer

func reload():
	ammo = maxAmmo
	for i in range(1, ammoContainers+1):
		get_node(str("ammo", i)).ammo = ammoPerContainer
		
	get_node("../ammo").text = str(ammo, "/", maxAmmo) 

func removeAmmo(ammoToRemove : int = 1) -> void:
	if ammoToRemove > ammo:
		return
		
	ammo -= ammoToRemove
		
	for i in range(1, ammoContainers+1):
		var container := get_node(str("ammo", i))
		if container.ammo - ammoToRemove >= 0:
			container.ammo -= ammoToRemove
			break
		else:
			ammoToRemove -= container.ammo
			container.ammo = 0
	
	get_node("../ammo").text = str(ammo, "/", maxAmmo) 
		
