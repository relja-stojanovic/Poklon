class_name MatchSearchResult extends RefCounted

var start: int
var size: int

func _init(init_start: int, init_size: int) -> void:
	start = init_start
	size = init_size
