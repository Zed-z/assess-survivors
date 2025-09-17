extends Node2D

func _ready():
	connect_buttons(get_tree().root)
	get_tree().connect("node_added", _on_node_added)

func _on_node_added(node):
	if node is Control:
		connect_signals(node)

func _on_button_focused():
	$ButtonFocused.play()

func _on_button_pressed():
	$ButtonPressed.play()

func connect_buttons(root):
	for node in root.get_children():
		if node is Control:
			connect_signals(node)
		connect_buttons(node)

func connect_signals(node: Control):

	node.connect("focus_entered", _on_button_focused)

	if node is BaseButton:
		node.connect("pressed", _on_button_pressed)

	if node is TabBar:
		node.connect("tab_changed", func (_x): _on_button_focused())
