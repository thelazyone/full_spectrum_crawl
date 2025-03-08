extends Node

var MessageDialog = preload("res://ui/message_dialog.tscn")
var PauseMenu = preload("res://ui/pause_menu.tscn")

func message(text: String, view, ok_only : bool = false):
	var msg_dialog = _recenter(MessageDialog.instantiate())
	msg_dialog.set_ok_only(ok_only)
	msg_dialog.set_message(text)
	
	view.add_child(msg_dialog)
	return msg_dialog

func pause(view):
	var pause_dialog = _recenter(PauseMenu.instantiate())
	
	view.add_child(pause_dialog)
	return pause_dialog

func _recenter(dialog):
	# First centering compared to the viewport...
	dialog.position = get_viewport().get_visible_rect().get_center() - dialog.get_global_rect().get_center()
	# ...then shifting to map the camera position.
	dialog.position.x -= get_viewport().get_canvas_transform().get_origin().x
	return dialog
