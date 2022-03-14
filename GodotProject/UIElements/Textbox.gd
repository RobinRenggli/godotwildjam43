extends CanvasLayer

export var PAUSE_PREFIX = "!PAUSE_FOR_"

var char_read_rate = 0.08

onready var textbox_container = $TextBoxContainer
onready var start_symbol = $TextBoxContainer/MarginContainer/HBoxContainer/StartSymbol
onready var end_symbol = $TextBoxContainer/MarginContainer/HBoxContainer/EndSymbol
onready var label_text = $TextBoxContainer/MarginContainer/HBoxContainer/LabelText

var current_state = State.READY
var text_queue = []

enum State {
	READY,
	READING
}

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text_speed()
	hide_textbox()

func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
		State.READING:
			pass

func set_text_speed():
	match Overviewer.text_speed:
		0:
			char_read_rate = 0.12 
		1:
			char_read_rate = 0.08
		2:
			char_read_rate = 0.04

func change_state(next_state):
	current_state = next_state

func queue_text(next_text):
	if Overviewer.display_text == true:
		text_queue.push_back(next_text)

func queue_pause_seconds(pause_time):
	if Overviewer.display_text == true:
		text_queue.push_back(PAUSE_PREFIX + str(pause_time))

func clear_text_queue():
	text_queue.clear()

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label_text.text = ""
	textbox_container.hide()

func display_text():
	var read_time = 0
	var next_text = ""
	var pause_time = 0.0
	
	change_state(State.READING)
	
	next_text = text_queue.pop_front()
	
	if next_text.begins_with(PAUSE_PREFIX):
		pause_time = float(next_text.lstrip(PAUSE_PREFIX))
		yield(get_tree().create_timer(pause_time), "timeout")
	else:	
		get_tree().paused = true
		
		read_time = len(next_text) * char_read_rate
		label_text.text = next_text
		label_text.percent_visible = 0.0
		textbox_container.show()
		
		# fade in text
		$Tween.interpolate_property(label_text, "percent_visible", 0.0, 1.0, read_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield(get_tree().create_timer(read_time + 1), "timeout")
		$Tween.remove_all()
		
		# fade out text
		$Tween.interpolate_property(label_text, "modulate:a", 1.0, 0.0, 0.8, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.interpolate_property(textbox_container, "modulate:a", 1.0, 0.0, 0.8, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield(get_tree().create_timer(1.5), "timeout")
		
		get_tree().paused = false
	
	# clean up
	label_text.modulate.a = 1.0
	textbox_container.modulate.a = 1.0
	$Tween.remove_all()
	hide_textbox()
	change_state(State.READY)
