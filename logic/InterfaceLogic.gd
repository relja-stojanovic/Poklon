class_name InterfaceLogic extends Node

var data: GameData
var selected_pos: Vector2i = Vector2i.MIN
var input_active: bool = true
@onready var input_handler := %InputHandler
@onready var elements_display := %ElementDisplay

func _ready() -> void:
	data = Global.data
	GameChase.new(data)
	
	input_handler.input.connect(_on_input)
	
	if data.elements.is_empty():
		GameService.start(data)
	
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
