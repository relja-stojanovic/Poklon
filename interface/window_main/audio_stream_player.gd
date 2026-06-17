extends AudioStreamPlayer

func _ready() -> void:
	var data: GameData = Global.data
	var chase: GameChase = data.chase
	stream = chase.game_strategy.get_music()
	var settings: UserSettings = Global.user_settings
	settings.music.value_changed.connect(_on_music_value_changed)
	play()
	_on_music_value_changed(settings.music)
	
func _on_music_value_changed(setting: Setting) -> void:
	stream_paused = not setting.value
