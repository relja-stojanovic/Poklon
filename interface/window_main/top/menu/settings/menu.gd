extends PopupMenu

enum {
	SFX,
	MUSIC,
	PREVIEW,
	WINDOW_CHAT,
	WINDOW_STATS
	}

var map: Dictionary[int, Setting]

func _ready() -> void:
	index_pressed.connect(_on_index_pressed)
	var user_settings := Global.user_settings
	
	map = {
		SFX: user_settings.sfx,
		MUSIC: user_settings.music,
		PREVIEW: user_settings.preview,
		WINDOW_CHAT: user_settings.window_chat,
		WINDOW_STATS: user_settings.window_stats
		}
	
	for index in map:
		var setting = map[index]
		setting.value_changed.connect(_on_setting_changed.bind(index))
		_on_setting_changed(setting, index)

func _on_index_pressed(index: int) -> void:
	map[index].toggle_value()

func _on_setting_changed(setting: Setting, index: int) -> void:
	set_item_checked(index, setting.value)
