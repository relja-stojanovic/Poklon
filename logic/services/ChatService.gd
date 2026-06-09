extends Node

signal send(msg: String)

#TODO: Code smell
var color_map: Dictionary[int, String] = {
	Element.BALL_RED: "Црвених",
	Element.BALL_BLUE: "Плавих",
	Element.BALL_GREEN: "Зелених",
	Element.BALL_YELLOW: "Жутих",
	Element.BALL_LIGHT_BLUE: "Светло Плавих",
	Element.BALL_PURPLE: "Љубичастих",
	Element.BALL_BROWN: "Белих"
}

func info_ball(count: int, element: int) -> void:
	var color = color_map.get(element, "Непознатих")
	send.emit("%d* %s" % [count, color])

func info_word(word: String) -> void:
	print(word)
	#џ 
	var cyrillic: String = word
	cyrillic = cyrillic.replace("lj", "љ")
	cyrillic = cyrillic.replace("nj", "њ")
	cyrillic = cyrillic.replace("dž", "џ")
	
	cyrillic = cyrillic.replace("a", "а")
	cyrillic = cyrillic.replace("b", "б")
	cyrillic = cyrillic.replace("v", "в")
	cyrillic = cyrillic.replace("g", "г")
	cyrillic = cyrillic.replace("d", "д")
	cyrillic = cyrillic.replace("đ", "ђ")
	cyrillic = cyrillic.replace("e", "е")
	cyrillic = cyrillic.replace("ž", "ж")
	cyrillic = cyrillic.replace("z", "з")
	cyrillic = cyrillic.replace("i", "и")
	cyrillic = cyrillic.replace("j", "ј")
	cyrillic = cyrillic.replace("k", "к")
	cyrillic = cyrillic.replace("l", "л")
	cyrillic = cyrillic.replace("m", "м")
	cyrillic = cyrillic.replace("n", "н")
	cyrillic = cyrillic.replace("o", "о")
	cyrillic = cyrillic.replace("p", "п")
	cyrillic = cyrillic.replace("r", "р")
	cyrillic = cyrillic.replace("c", "ц")
	cyrillic = cyrillic.replace("t", "т")
	cyrillic = cyrillic.replace("ć", "ћ")
	cyrillic = cyrillic.replace("u", "у")
	cyrillic = cyrillic.replace("f", "ф")
	cyrillic = cyrillic.replace("h", "x")
	cyrillic = cyrillic.replace("c", "ц")
	cyrillic = cyrillic.replace("č", "ч")
	cyrillic = cyrillic.replace("š", "ш")
	cyrillic = cyrillic.capitalize()
	send.emit(cyrillic)
