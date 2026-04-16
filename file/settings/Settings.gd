class_name Settings extends Resource

signal sfx_changed(settings: Settings)
signal music_changed(settings: Settings)
signal preview_changed(settings: Settings)
signal window_chat_changed(settings: Settings)
signal window_stats_changed(settings: Settings)

@export var sfx: bool = true
@export var music: bool = true
@export var preview: bool = true
@export var window_chat: bool = false
@export var window_stats: bool = false

func set_sfx(value: bool) -> void:
	sfx = value
	sfx_changed.emit(self)

func set_music(value: bool) -> void:
	music = value
	music_changed.emit(self)

func set_preview(value: bool) -> void:
	preview = value
	preview_changed.emit(self)

func set_window_chat(value: bool) -> void:
	window_chat = value
	window_chat_changed.emit(self)
	
func set_window_stats(value: bool) -> void:
	window_stats = value
	window_stats_changed.emit(self)

func toggle_sfx() -> void:
	set_sfx(not sfx)
	
func toggle_music() -> void:
	set_music(not music)
	
func toggle_preview() -> void:
	set_preview(not preview)

func toggle_window_chat() -> void:
	set_window_chat(not window_chat)

func toggle_window_stats() -> void:
	set_window_stats(not window_stats)
