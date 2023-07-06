tool

extends BaseCustomButton
class_name CustomButton

export (Texture) var normalTexture
export (Texture) var hoverTexture
export (Texture) var hoverAddedTexture setget set_hoverAddedTexture
export (Texture) var pressedAddedTexture setget set_pressedAddedTexture

var pressedAddedTextureRect: TextureRect = null


func set_hoverAddedTexture(value: Texture) -> void:
	if Engine.editor_hint:
		hoverAddedTexture = value
	if not Engine.editor_hint:
		hoverAddedTexture = value
		if hoverAddedTexture == null: return 
		if hoverAddedTextureRect != null: return
		add_stateTextureRect(HOVER_ADDED_STATE, hoverAddedTexture)

func set_pressedAddedTexture(value: Texture) -> void:
	if Engine.editor_hint:
		pressedAddedTexture = value
	if not Engine.editor_hint:
		pressedAddedTexture = value
		if pressedAddedTexture == null: return 
		if pressedAddedTextureRect != null: return
		connect("toggled", self, "_on_toggled")
		add_stateTextureRect(PRESSED_ADDED_STATE, pressedAddedTexture)

func set_normal_mode() -> void:
	if self.normalTexture != null:
		self.texture_normal = self.normalTexture
	if self.hoverAddedTexture != null:
		hoverAddedTextureRect.visible = false

func set_hover_mode() -> void:
	if self.hoverTexture != null:
		self.texture_normal = self.hoverTexture
	if self.hoverAddedTexture != null:
		hoverAddedTextureRect.visible = true

func set_pressed_mode(button_pressed: bool) -> void:
	if self.pressedAddedTexture != null:
		pressedAddedTextureRect.visible = button_pressed

func _on_mouse_entered() -> void:
	set_hover_mode()

func _on_mouse_exited() -> void:
	set_normal_mode()

func _on_toggled(button_pressed: bool) -> void:
	set_pressed_mode(button_pressed)

func _ready() -> void:
	if Engine.editor_hint:
		update_configuration_warning()
	else:
		set_normal_mode()
	
func _get_configuration_warning() -> String:
	var warnings: PoolStringArray = []
	if (pressedAddedTexture != null) and (!toggle_mode):
		warnings.append("toggle_mode must be abled while using pressedAddedTexture")
	if (pressedAddedTexture == null) and (toggle_mode):
		warnings.append("pressedAddedTexture must be added when toggle_mode is abled")
	return warnings.join('\n')

