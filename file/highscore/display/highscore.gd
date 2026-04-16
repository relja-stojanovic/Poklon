extends Window

@onready var list := %List

func _ready() -> void:
	content_scale_size = size

func _on_visibility_changed() -> void:
	if not visible:
		return
		
	if not FileAccess.file_exists(Path.HIGHSCORE_PATH):
		DataHandler.save_file(Highscore.new(), Path.HIGHSCORE_PATH)
		
	var data: Highscore = DataHandler.load_file(Path.HIGHSCORE_PATH, Highscore)
	for i in range(Highscore.LIMIT):
		list.get_child(i).set_data(data.names[i], data.scores[i])
	
func _on_close_requested() -> void:
	hide()
