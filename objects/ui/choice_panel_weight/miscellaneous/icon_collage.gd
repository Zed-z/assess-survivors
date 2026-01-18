extends Control
class_name iconCollage
var icons: Array[CompressedTexture2D] = []


func set_column_size(length: int) -> void:
	pass#%Container.columns = ceil(sqrt(length))


func fill() -> void:
	set_column_size(len(icons))

	for i in range(len(icons)):
		var icon: CompressedTexture2D = icons[i]

		var obj: TextureRect = TextureRect.new()
		obj.texture = icon
		obj.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		obj.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		obj.custom_minimum_size = Vector2(160.0,160.0)
		obj.position = Vector2.RIGHT.rotated(2 * PI * (float(i) / len(icons))) * 40.0

		%Container.add_child(obj)
