class_name UserSettings extends Resource

@export var sfx: Setting = Setting.new()
@export var music: Setting = Setting.new(true)
@export var preview: Setting = Setting.new(true)
@export var window_chat: Setting = Setting.new()
@export_storage var window_chat_size: Vector2 = Vector2(200, 300)
