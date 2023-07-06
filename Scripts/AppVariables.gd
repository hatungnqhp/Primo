extends Node

#==========WINDOW==========
const DEFAULT_RESTORE_WINDOW_SIZE: Vector2 = Vector2(720, 480)

const RIGHT_TASKBAR_LOCATION = Vector2(1, 0)
const LEFT_TASKBAR_LOCATION = Vector2(-1, 0)
const UP_TASKBAR_LOCATION = Vector2(0, 1)
const DOWN_TASKBAR_LOCATION = Vector2(0, -1)
const DEFAULT_TASKBAR_LOCATION: Vector2 = DOWN_TASKBAR_LOCATION
const DEFAULT_TASKBAR_SIZE: int = 32

var screenSize: Vector2 = OS.get_screen_size() setget set_screenSize
var restoreWindowSize: Vector2 = DEFAULT_RESTORE_WINDOW_SIZE setget set_restoreWindowSize
var restoreWindowPosition: Vector2 = screenSize*0.5 - restoreWindowSize*0.5
var taskbarLocation: Vector2 = DEFAULT_TASKBAR_LOCATION setget set_taskbarLocation
var taskbarSize: int = DEFAULT_TASKBAR_SIZE setget set_taskbarSize
var maximizeWindowDeltaDirection: Vector2 = Vector2.ZERO
var maximizeWindowPosition: Vector2 = taskbarSize * maximizeWindowDeltaDirection
var maximizeWindowSize: Vector2 = screenSize - taskbarSize*taskbarLocation.abs()

func set_taskbarLocation(value: Vector2) -> void:
	taskbarLocation = value
	maximizeWindowDeltaDirection = Vector2(
		int(value.x == -1),
		int(value.y == 1) 
	)
	maximizeWindowPosition = taskbarSize * maximizeWindowDeltaDirection
	maximizeWindowSize = screenSize - taskbarSize*taskbarLocation.abs()

func set_taskbarSize(value: int) -> void:
	taskbarSize = value
	maximizeWindowPosition = taskbarSize * maximizeWindowDeltaDirection
	maximizeWindowSize = screenSize - taskbarSize*taskbarLocation.abs()

func set_restoreWindowSize(value: Vector2) -> void:
	restoreWindowSize = value
	restoreWindowPosition = screenSize*0.5 - restoreWindowSize*0.5

func set_screenSize(value: Vector2) -> void:
	screenSize = value
	restoreWindowPosition = screenSize*0.5 - restoreWindowSize*0.5
	maximizeWindowSize = screenSize - taskbarSize*taskbarLocation.abs()

