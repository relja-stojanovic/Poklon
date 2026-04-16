extends ScrollContainer

func _ready() -> void:
	var settings := Global.settings
	settings.preview_changed.connect(_on_preview_changed)
	_on_preview_changed(settings)
	
func _on_preview_changed(settings: Settings) -> void:
	visible = settings.preview
