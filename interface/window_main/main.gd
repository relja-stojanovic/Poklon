extends Control

@onready var input_handler := %InputHandler

func _ready() -> void:
	data = Global.data
	GameChase.new(data)
	
	input_handler.input.connect(_on_input)
	
	if data.elements.is_empty():
		GameService.start(data)
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Global.quit()

#TODO: Code Smell
#region Selecting and Moving
@onready var elements_display := %ElementDisplay
var data: GameData
var selected_pos: Vector2i = Vector2i.MIN
var input_active: bool = true

func reset_selection() -> void:
	selected_pos = Vector2i.MIN
	
func has_selected() -> bool:
	return not selected_pos == Vector2i.MIN

func _on_input(pos: Vector2i) -> void:
	if not input_active:
		return
		
	if has_selected():
		if pos == selected_pos:
			reset_selection()
			elements_display.display_element_cancel()
		elif ElementService.empty_at(data, pos):
			var path: ElementPath = GameService.find_path(data, selected_pos, pos)
			if path.has_path():
				input_active = false
				data.move_element(selected_pos, pos)
				await elements_display.display_target_select(pos, path.data)
				input_active = true
				reset_selection()
				
				var connected: bool = GameService.get_game_strategy(data).execute_match(data, pos)
				if not connected or data.elements.is_empty():
					GameService.spawn_elements(data)
			else:
				elements_display.display_target_unreachable()
		else:
			selected_pos = pos
			elements_display.display_element_select(selected_pos)
	else:
		if not ElementService.empty_at(data, pos):
			selected_pos = pos
			elements_display.display_element_select(selected_pos)
#endregion

#TODO: Remove later
func _on_file_button_pressed() -> void:
	$NewGame.visible = true
