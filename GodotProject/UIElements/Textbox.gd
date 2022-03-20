extends CanvasLayer

export var PAUSE_PREFIX = "!PAUSE_FOR_"

var char_read_rate = 0.05

onready var textbox_container = $TextBoxContainer
onready var label_text = $TextBoxContainer/MarginContainer/LabelText

var current_state = State.READY
var text_queue = []

signal is_empty

enum State {
	READY,
	READING
}

func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
		State.READING:
			pass

func change_state(next_state):
	current_state = next_state

func queue_text(next_text):
	text_queue.push_back(next_text)

func queue_pause_seconds(pause_time):
	text_queue.push_back(PAUSE_PREFIX + str(pause_time))

func clear_text_queue():
	text_queue.clear()

func hide_textbox():
	label_text.text = ""
	textbox_container.hide()

func show_textbox():
	textbox_container.show()

func display_text():
	var read_time = 0
	var next_text = ""
	var pause_time = 0.0
	
	change_state(State.READING)
	
	next_text = text_queue.pop_front()
		
	read_time = len(next_text) * char_read_rate
	label_text.text = next_text
	label_text.percent_visible = 0.0
	
	# fade in text
	$Tween.interpolate_property(label_text, "percent_visible", 0.0, 1.0, read_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield(get_tree().create_timer(read_time + 1), "timeout")
	$Tween.remove_all()
	
	yield(get_tree().create_timer(1.5), "timeout")
	
	# clean up
	label_text.modulate.a = 1.0
	textbox_container.modulate.a = 1.0
	$Tween.remove_all()
	if(text_queue.empty()):
		emit_signal("is_empty")
	change_state(State.READY)
