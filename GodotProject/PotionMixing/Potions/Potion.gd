extends TextureRect

export (Dictionary) var effects = {}

func get_drag_data(position):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var data = effects
	var drag_texture = TextureRect.new()
	drag_texture.texture = texture
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_min_size = texture.get_size()
	drag_texture.rect_size = texture.get_size()
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	print(drag_texture.rect_position)
	print(drag_texture.rect_size)
	
	set_drag_preview(control)
	return data

func can_drop_data(position, data):
	return true

func drop_data(_pos, data):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
