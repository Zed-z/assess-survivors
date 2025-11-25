extends Control
class_name iconCollage
var icons: Array[CompressedTexture2D] = []


func set_column_size(length: int) -> void:
	%Container.columns = ceil(sqrt(length))


func fill() -> void:
	set_column_size(len(icons))
	for icon in icons:
		var obj: TextureRect = TextureRect.new()
		obj.texture = icon
		obj.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		obj.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		obj.custom_minimum_size = Vector2(160.0,160.0)

		%Container.add_child(obj)
