class_name ElementDisplay extends Node2D

@export var sprite: Sprite2D
@export var anim_player: AnimationPlayer

func init(pos: Vector2i, texture: Vector2i, play_start_animation: bool) -> void:
	sprite.material = sprite.material.duplicate()
	position = pos * Global.TILE_SIZE
	sprite.region_rect.size = Vector2(Global.TILE_SIZE, Global.TILE_SIZE)
	sprite.region_rect.position = Vector2(texture * Global.TILE_SIZE)
	if play_start_animation:
		sprite.scale = Vector2.ZERO
		anim_player.play("spawn")
	else:
		(sprite.material as ShaderMaterial).set_shader_parameter("effect", 1.0)
		cancel()

func select() -> void:
	anim_player.play("select")

func remove() -> void:
	anim_player.play_with_capture("remove")
	await anim_player.animation_finished

func cancel() -> void:
	anim_player.play_backwards("select")
