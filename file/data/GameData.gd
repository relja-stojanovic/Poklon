class_name GameData extends Resource

signal element_added(data: GameData, pos: Vector2i)
signal element_removed(data: GameData, pos: Vector2i)
signal elements_removed(data: GameData, array: Array[Vector2i])
signal element_moved(data: GameData, old_pos: Vector2i, new_pos: Vector2i)
signal score_changed(data: GameData)
signal preview_changed(data: GameData)

@export var size: int = 9
@export var spawn_amount: int = 3
@export var word_mode: bool = false
@export var elements: Dictionary[Vector2i, int] = {}
@export var preview: Array[int] = []
@export var score: int = 0
var chase: GameChase

#region Element
func add_element(pos: Vector2i, element: int) -> void:
	elements.set(pos, element)
	element_added.emit(self, pos)
	
func remove_element(pos: Vector2i) -> void:
	elements.erase(pos)
	element_removed.emit(self, pos)
	
func remove_elements(array: Array[Vector2i]) -> void:
	for pos in array:
		elements.erase(pos)
	elements_removed.emit(self, array)
	
func set_preview(new_preview: Array[int]) -> void:
	preview = new_preview
	preview_changed.emit(self)
	
func move_element(element_pos: Vector2i, new_pos: Vector2i) -> void:
	var element: int = elements[element_pos]
	elements.erase(element_pos)
	elements[new_pos] = element
	element_moved.emit(self, element_pos, new_pos)
#endregion

#region Score
func add_score(amount: int) -> void:
	set_score(score+amount)
	
func set_score(value: int) -> void:
	score = value
	score_changed.emit(self)
#endregion
