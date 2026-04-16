extends Window

var input_size: int = Global.data.size
var input_amount: int = Global.data.spawn_amount
var input_word: bool = Global.data.word_mode

func _ready() -> void:
	content_scale_size = size
	$MarginContainer/Options/Size/Input.value = input_size
	$MarginContainer/Options/SpawnAmount/Input.value = input_amount
	$MarginContainer/Options/WordMode.button_pressed  = input_word

func _on_input_size(value: float) -> void:
	input_size = int(value)

func _on_input_amount(value: float) -> void:
	input_amount = int(value)
	
func _on_input_word(toggled_on: bool) -> void:
	input_word = toggled_on

func _on_cancel_pressed() -> void:
	hide()

func _on_start_pressed() -> void:
	var new_data: GameData = GameData.new()
	new_data.size = input_size
	new_data.spawn_amount = input_amount
	new_data.word_mode = input_word
	
	Global.data = new_data
	DataHandler.save_file(Global.data, Path.DATA_PATH)
	get_tree().reload_current_scene.call_deferred()

func _on_close_requested() -> void:
	hide()
