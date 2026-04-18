extends Node

signal send(msg: String)

func info_word(word: String) -> void:
	send.emit(word)
