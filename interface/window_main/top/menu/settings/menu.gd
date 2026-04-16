extends MenuButton

enum {
	SFX,
	MUSIC,
	PREVIEW,
	WINDOW_CHAT,
	WINDOW_STATS
}

func _ready() -> void:
	get_popup().index_pressed.connect(_on_index_pressed)
	var settings: Settings = Global.settings
	settings.sfx_changed.connect(_on_sfx_changed)
	settings.music_changed.connect(_on_music_changed)
	settings.preview_changed.connect(_on_preview_changed)
	settings.window_chat_changed.connect(_on_window_chat_changed)
	settings.window_stats_changed.connect(_on_window_stats_changed)
	_on_sfx_changed(settings)
	_on_music_changed(settings)
	_on_preview_changed(settings)
	_on_window_chat_changed(settings)
	_on_window_stats_changed(settings)

func _on_index_pressed(index: int) -> void:
	match index:
		SFX:
			Global.settings.toggle_sfx()
		MUSIC:
			Global.settings.toggle_music()
		PREVIEW:
			Global.settings.toggle_preview()
		WINDOW_CHAT:
			Global.settings.toggle_window_chat()
		WINDOW_STATS:
			Global.settings.toggle_window_stats()

func _on_file_menu_button_pressed() -> void:
	hide()

func _on_sfx_changed(settings: Settings) -> void:
	get_popup().set_item_checked(SFX, settings.sfx)
	
func _on_music_changed(settings: Settings) -> void:
	get_popup().set_item_checked(MUSIC, settings.music)

func _on_preview_changed(settings: Settings) -> void:
	get_popup().set_item_checked(PREVIEW, settings.preview)

func _on_window_chat_changed(settings: Settings) -> void:
	get_popup().set_item_checked(WINDOW_CHAT, settings.window_chat)
	
func _on_window_stats_changed(settings: Settings) -> void:
	get_popup().set_item_checked(WINDOW_STATS, settings.window_stats)
