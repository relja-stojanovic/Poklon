extends PopupMenu

enum {
	NEW_GAME,
	SHOW_BEST,
	QUIT
}

var map: Dictionary[int, Callable] = {
	NEW_GAME: action_new_game,
	SHOW_BEST: action_show_best,
	QUIT: action_quit
}

@onready var new_game_popup: Window = %NewGame
@onready var high_scores_popup: Window = %Highscore

func _on_id_pressed(id: int) -> void:
	map[id].call()

func action_new_game() -> void:
	new_game_popup.show()
	
func action_show_best() -> void:
	high_scores_popup.show()

func action_quit() -> void:
	Global.quit()
