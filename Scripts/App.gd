extends HBoxContainer

enum TASKBAR_TABS {Library, Flashcard, Setting}
const TASKBAR_TAB_NAMES = {
	-1: "",
	0: "library",
	1: "flashcard",
	2: "setting"
}

onready var settingButton = $Taskbar/SettingButton
onready var flashcardButton = $Taskbar/FlashcardButton
onready var libraryButton = $Taskbar/LibraryButton
onready var workspaceTabContainer = $Workspace/TabContainer

var currentTaskbarTab: int = -1 setget set_currentTaskbarTab

func set_currentTaskbarTab(value: int) -> void:
	var previousTaskbarTab = currentTaskbarTab
	currentTaskbarTab = value
	workspaceTabContainer.current_tab = currentTaskbarTab
	var previousButton = get(TASKBAR_TAB_NAMES[previousTaskbarTab] + "Button")
	var currentButton = get(TASKBAR_TAB_NAMES[currentTaskbarTab] + "Button")
	if previousButton == null:
		currentButton.pressed = true
	else:
		previousButton.disabled = false
		previousButton.pressed = false
	currentButton.disabled = true

func setup_taskbar() -> void:
	self.currentTaskbarTab = TASKBAR_TABS.Library

func _on_TaskbarButton_pressed(taskbarTab: int) -> void:
	self.currentTaskbarTab = taskbarTab

func _ready() -> void:
	setup_taskbar()





