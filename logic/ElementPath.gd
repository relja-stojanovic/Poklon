class_name ElementPath extends RefCounted

var data: PackedVector2Array = []

func _init(init_data: PackedVector2Array) -> void:
	data = init_data

func has_path() -> bool:
	return not data.is_empty()
