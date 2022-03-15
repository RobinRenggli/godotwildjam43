extends TextureRect

export var potion_name = "name"
export (Dictionary) var effects = {}
export (Dictionary) var negative_effects = {}


func _ready():
	$PotionLabel.visible = false
	$PotionLabel/Label.text = potion_name

func get_drag_data(position):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var data = {
		"effects": effects,
		"negative_effects": negative_effects,
		"finished": false
		}
	var drag_texture = TextureRect.new()
	drag_texture.texture = texture
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_min_size = drag_texture.texture.get_size()
	drag_texture.rect_size = drag_texture.texture.get_size()
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	
	set_drag_preview(control)
	return data

func can_drop_data(position, data):
	return true

func drop_data(_pos, data):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Potion_mouse_entered():
	$PotionLabel.visible = true


func _on_Potion_mouse_exited():
	$PotionLabel.visible = false
