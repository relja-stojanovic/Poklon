extends Node

signal send(msg: String)

#TODO: Code smell
var color_map: Dictionary[int, String] = {
	Element.BALL_RED: "Crvenih",
	Element.BALL_BLUE: "Plavih",
	Element.BALL_GREEN: "Zelenih",
	Element.BALL_YELLOW: "Žutih",
	Element.BALL_LIGHT_BLUE: "Svetlo Plavih",
	Element.BALL_PURPLE: "Ljubičastih",
	Element.BALL_BROWN: "Belih"
}

func info_ball(count: int, element: int) -> void:
	var color = color_map.get(element, "Nepoznatih")
	send.emit("%d* %s" % [count, color])

func info_word(word: String) -> void:
	send.emit(word)
