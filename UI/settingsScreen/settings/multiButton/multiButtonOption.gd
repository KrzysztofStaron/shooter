extends Option

export var option : Resource

var index := 0

func _ready() -> void:
	$name.text = option.name
	$container/button/option.text = option.options[index]


func next() -> void:
	index += 1

	if index == len(option.options):
		index = 0
		
	$container/button/option.text = option.options[index]


func back() -> void:
	index -= 1
	
	if index < 0:
		index = len(option.options) - 1
	
	$container/button/option.text = option.options[index]
