extends Node

var isMouseInWindow: bool = false


func _notification(what) -> void:
	if what == NOTIFICATION_WM_MOUSE_EXIT:
		isMouseInWindow = false
	elif what == NOTIFICATION_WM_MOUSE_ENTER:
		isMouseInWindow = true
		
