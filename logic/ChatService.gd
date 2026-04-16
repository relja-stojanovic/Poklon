extends Node

signal send(msg: String)

func to_str(ball_id: int) -> String:
	match ball_id:
		Element.BALL_RED:
			return "Crvena"
		Element.BALL_BLUE:
			return "Teget"
		Element.BALL_GREEN:
			return "Zelena"
		Element.BALL_YELLOW:
			return "Žuta"
		Element.BALL_LIGHT_BLUE:
			return "Plava"
		Element.BALL_PURPLE:
			return "Ljubičasta"
		Element.BALL_BROWN:
			return "Smeđa"
		_:
			return ""

func info_ball(ball_id: int, amount: int) -> void:
	var msg: String = "%s*%s" % [to_str(ball_id), amount]
	send.emit(msg)
	
func info_word(word: String) -> void:
	send.emit(word)
