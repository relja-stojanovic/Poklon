extends PopupMenu

enum {
	SFX,
	MUSIC,
	PREVIEW,
	WINDOW_CHAT
	}

var map: Dictionary[int, Setting]

func _ready() -> void:
	var user_settings := Global.user_settings
	
	map = {
		SFX: user_settings.sfx,
		MUSIC: user_settings.music,
		PREVIEW: user_settings.preview,
		WINDOW_CHAT: user_settings.window_chat
		}
	
	for id in map:
		var setting = map[id]
		setting.value_changed.connect(_on_setting_changed.bind(id))
		_on_setting_changed(setting, id)

func _on_id_pressed(id: int) -> void:
	map[id].toggle_value()

func _on_setting_changed(setting: Setting, id: int) -> void:
	var index: int = get_item_index(id)
	set_item_checked(index, setting.value)
