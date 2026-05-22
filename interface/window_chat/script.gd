extends Window

var setting := Global.user_settings.window_chat

func _ready() -> void:
	setting.value_changed.connect(_on_value_changed)
	size = Global.user_settings.window_chat_size
	
	if setting.value:
		show()

func _on_close_requested() -> void:
	setting.set_value(false)

func _on_value_changed(_setting: Setting) -> void:
	if setting.value:
		show()
	else:
		hide()

func _on_size_changed() -> void:
	Global.user_settings.window_chat_size = size
