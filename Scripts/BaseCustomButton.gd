#==========THIS IS NOT A USEABLE BUTTON#==========
extends TextureButton
class_name BaseCustomButton

signal mouseEntered
signal mouseExited

const HOVER_ADDED_STATE = "hover"
const PRESSED_ADDED_STATE = "pressed"

var isMouseEntered: bool = false setget set_isMouseEntered
var hoverAddedTextureRect: TextureRect = null


func add_stateTextureRect(addedState: String, addedStateTexture: Texture) -> void:
	var stateAddedTextureRectVarName = addedState + "AddedTextureRect"
	var stateAddedTextureRect = TextureRect.new()
	set(stateAddedTextureRectVarName, stateAddedTextureRect)
	self.add_child(stateAddedTextureRect)
	stateAddedTextureRect.texture = addedStateTexture
	stateAddedTextureRect.expand = true
	stateAddedTextureRect.anchor_right = 1
	stateAddedTextureRect.anchor_bottom = 1
	stateAddedTextureRect.visible = false
	stateAddedTextureRect.show_behind_parent = true

func set_isMouseEntered(value: bool) -> void:
	if isMouseEntered == value: return
	isMouseEntered = value
	if isMouseEntered:
		emit_signal("mouseEntered") 
	else: 
		emit_signal("mouseExited")

func connect_mouse_signal() -> void:
	connect("mouseEntered", self, "_on_mouse_entered")
	connect("mouseExited", self, "_on_mouse_exited")

func _ready() -> void:
	connect_mouse_signal()
	
func _process(_delta: float) -> void:
	if not Engine.editor_hint: 
		var local_mouse_position: Vector2 = get_local_mouse_position()
		if (GlobalVariables.isMouseInWindow) \
		and (0 <= local_mouse_position.x and local_mouse_position.x <= self.rect_size.x) \
		and (0 <= local_mouse_position.y and local_mouse_position.y <= self.rect_size.y):
			self.isMouseEntered = true
		else:
			self.isMouseEntered = false
