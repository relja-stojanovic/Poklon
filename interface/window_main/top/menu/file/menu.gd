extends MenuButton

enum {
	NEW_GAME,
	SHOW_BEST,
	QUIT
}

@onready var new_game_popup: Window = %NewGame
@onready var high_scores_popup: Window = %Highscore

func _ready() -> void:
	get_popup().index_pressed.connect(_on_index_pressed)

func _on_index_pressed(index: int) -> void:
	match index:
		NEW_GAME:
			new_game_popup.visible = true
		SHOW_BEST:
			high_scores_popup.visible = true
		QUIT:
			Global.quit()

func _on_file_menu_button_pressed() -> void:
	hide()
