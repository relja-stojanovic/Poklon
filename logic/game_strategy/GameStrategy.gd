@abstract class_name GameStrategy extends RefCounted

@abstract func gen_preview_element() -> int
# Get if combination of elements was achived, remove elements, add score and return if it was a success
@abstract func execute_match(data: GameData, pos: Vector2i) -> bool
