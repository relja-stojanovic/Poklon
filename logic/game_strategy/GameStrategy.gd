@abstract class_name GameStrategy extends RefCounted

# TODO: Improve the name
@abstract func gen_preview_element(data: GameData) -> int

# Get if combination of elements was achived, remove elements, add score and return if it was a success
# TODO: Code smell prob want to make it return MatchResult and not a magic bool
# Could store changed elements, and more about successful match data, moving score, chat .ect code to somewhere else
@abstract func execute_match(data: GameData, pos: Vector2i) -> bool

@abstract func get_music() -> AudioStream
