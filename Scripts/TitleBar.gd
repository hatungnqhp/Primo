extends Control

enum RESIZE_MODE {Maximize, RestoreDown}

onready var windowTitleLabel: Label = $WindowTitle
onready var resizeButton: CustomModeButton = $ResizeButton

var resizeMode: int = RESIZE_MODE.Maximize setget set_resizeMode
var windowTitleText: String setget set_WindowTitleText
var isFollowing: bool = false
var dragStartPos: Vector2 = Vector2()


func set_maximize_window() -> void:
	OS.set_window_position(AppVariables.maximizeWindowPosition)
	OS.set_window_size(AppVariables.maximizeWindowSize)

func set_restoreDown_window() -> void:
	OS.set_window_position(AppVariables.restoreWindowPosition)
	OS.set_window_size(AppVariables.restoreWindowSize)
	
func set_resizeMode(value: int) -> void:
	if resizeMode == RESIZE_MODE.Maximize: set_maximize_window()
	else: set_restoreDown_window()
	resizeMode = value
	resizeButton.textureMode = resizeMode

func set_WindowTitleText(value: String) -> void:
	OS.set_window_title(value)
	windowTitleLabel.text = value

func _on_gui_input(event) -> void:
	if (event is InputEventMouseButton) \
	and (event.get_button_index() == BUTTON_LEFT):
		isFollowing = !isFollowing
		dragStartPos = get_local_mouse_position()

func _on_CloseButton_pressed() -> void:
	get_tree().quit()

func _on_ResizeButton_pressed() -> void:
	if resizeMode == RESIZE_MODE.RestoreDown: self.resizeMode = RESIZE_MODE.Maximize
	else: self.resizeMode = RESIZE_MODE.RestoreDown

func _on_MinimizeButton_pressed() -> void:
	OS.set_window_minimized(true)

func _process(_delta) -> void:
	if isFollowing:
		var deltaPos: Vector2 = get_local_mouse_position() - dragStartPos
		OS.set_window_position(OS.window_position + deltaPos)

