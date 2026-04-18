class_name Setting extends Resource

signal value_changed(setting: Setting)

@export var value: bool = false

func _init(default_value: bool = false) -> void:
	value = default_value

func set_value(new_value: bool) -> void:
	if value != new_value:
		value = new_value
		value_changed.emit(self)

func toggle_value() -> void:
	set_value(not value)
