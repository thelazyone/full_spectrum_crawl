extends Node

var MessageDialog = preload("res://UI/message_dialog.tscn")
var PauseMenu = preload("res://UI/pause_menu.tscn")

func message(text: String, view):
	var msg_dialog = MessageDialog.instantiate()
	msg_dialog.set_message(text)
	view.add_child(msg_dialog)
	return msg_dialog

func pause(view):
	var pause_dialog = PauseMenu.instantiate()
	view.add_child(pause_dialog)
	return pause_dialog
