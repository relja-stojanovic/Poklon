extends RichTextLabel

func _ready() -> void:
	Chat.send.connect(_on_chat_message)

func _on_chat_message(msg: String) -> void:
	text = msg + "\n" + text
