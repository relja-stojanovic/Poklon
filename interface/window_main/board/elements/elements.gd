extends Node2D

var mem: Dictionary[Vector2i, ElementDisplay] = {}
var selected: ElementDisplay
var element_sceen: PackedScene = preload("uid://b4y7ub33upe5k")

func add(data: GameData, pos: Vector2i, play_start_animation: bool) -> void:
	var new_element: int = data.elements[pos]
	var texture: Vector2i = Global.to_texture(new_element)
	var node: ElementDisplay = element_sceen.instantiate()
	node.init(pos, texture, play_start_animation)
	add_child(node)
	mem.set(pos, node)

func move(data: GameData, old_pos: Vector2i, new_pos: Vector2i) -> void:
	remove(old_pos, false)
	await $"../Path/PathFollow".finished
	add(data, new_pos, false)

func remove(pos: Vector2i, play_animation: bool) -> void:
	if mem.has(pos):
		var element: ElementDisplay = mem[pos]
		mem.erase(pos)
		if play_animation:
			await element.remove()
		element.queue_free()
	
func _ready() -> void:
	var data: GameData = Global.data
	position = Vector2i(Global.TILE_SIZE, Global.TILE_SIZE) / 2
	data.element_added.connect(_on_element_added)
	data.element_moved.connect(_on_element_moved)
	data.element_removed.connect(_on_element_removed)
	data.elements_removed.connect(_on_elements_removed)
	
	for pos in data.elements:
		add(data, pos, true)

#region Singal
func _on_element_added(data: GameData, pos: Vector2i) -> void:
	add(data, pos, true)
	
func _on_element_moved(data: GameData, old_pos: Vector2i, new_pos: Vector2i) -> void:
	move(data, old_pos, new_pos)

func _on_element_removed(_data: GameData, pos: Vector2i) -> void:
	remove(pos, true)

func _on_elements_removed(_data: GameData, array: Array[Vector2i]) -> void:
	for pos in array:
		remove(pos, true)
	
func _on_element_select(pos: Vector2i) -> void:
	if selected != null:
		selected.cancel()
		
	selected = mem[pos]
	selected.select()
	
func _on_element_cancel() -> void:
	selected.cancel()
	selected = null
#endregion
