extends ScrollContainer

func _ready() -> void:
	var setting := Global.user_settings.preview
	setting.value_changed.connect(_on_value_changed)
	_on_value_changed(setting)
	
func _on_value_changed(setting: Setting) -> void:
	visible = setting.value
