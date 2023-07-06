tool

extends BaseCustomButton
class_name CustomModeButton

export (int, 2, 9) var textureModeCount = 2
export (Array, Texture) var normalTextures
export (Array, Texture) var hoverTextures
export (Array, Texture) var hoverAddedTextures setget set_hoverAddedTextures
export (PoolStringArray) var tooltipContents

var textureMode: int setget set_textureMode


func set_hoverAddedTextures(value) -> void:
	if Engine.editor_hint:
		hoverAddedTextures = value
	if not Engine.editor_hint:
		hoverAddedTextures = value
		if hoverAddedTextures == null: return 
		if hoverAddedTextureRect != null: return 
		add_stateTextureRect(HOVER_ADDED_STATE, hoverAddedTextures[textureMode])

func set_textureMode(value) -> void:
	if 0 <= value and value < textureModeCount:
		textureMode = value
		set_tooltip(tooltipContents[textureMode])
	else:
		push_error("Invalid value for textureMode")

func set_normal_mode() -> void:
	if self.normalTextures[textureMode] != null:
		self.texture_normal = self.normalTextures[textureMode]
	if self.hoverAddedTextures[textureMode] != null:
		hoverAddedTextureRect.visible = false

func set_hover_mode() -> void:
	if self.hoverTextures[textureMode] != null:
		self.texture_normal = hoverTextures[textureMode]
	if self.hoverAddedTextures[textureMode] != null:
		hoverAddedTextureRect.visible = true

func _on_mouse_entered() -> void:
	set_hover_mode()

func _on_mouse_exited() -> void:
	set_normal_mode()

func _ready() -> void:
	if Engine.editor_hint:
		update_configuration_warning()
	elif not Engine.editor_hint:
		set_normal_mode()

func _get_configuration_warning() -> String:
	var warnings: PoolStringArray = []
	if (normalTextures.size() != textureModeCount):
		warnings.append("normalTextures size not match textureModeCount")
	if (hoverTextures.size() != textureModeCount):
		warnings.append("hoverTextures size not match textureModeCount")
	if (hoverAddedTextures.size() != textureModeCount):
		warnings.append("hoverAddedTextures size not match textureModeCount")
	if (tooltipContents.size() != textureModeCount):
		warnings.append("tooltipContents size not match textureModeCount")
	return warnings.join('\n')
