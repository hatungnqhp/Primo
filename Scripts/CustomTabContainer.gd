tool

extends Control

const TAB_ANIMATION_LINE_WIDTH = 2.0 # value must be multiple of 2.0

export (Color) var tabAnimationLineColor = Color(255, 255, 255)

onready var tabContainer: TabContainer = $TabContainer
onready var tabAnimationLine: Control = $TabAnimationLine

var tabPositions: PoolIntArray = []
var tabAnimationLineSideMargin: int
var tabAnimationLineYPos: int
var tabAnimationLineStartPos: float
var tabAnimationLineEndPos: float
var tabAnimationLineTargetStartPos: float
var tabAnimationLineTargetEndPos: float


func setup_customTabContainer() -> void:
	var tabContainerTheme = tabContainer.theme
	var tabContainerFont = tabContainerTheme.get("TabContainer/fonts/font")
	var tabContainerContentMarginLR = (
		tabContainerTheme.get("TabContainer/styles/tab_bg").get("content_margin_left"))
		# content_margin_left = content_margin_right
	var tabNum = tabContainer.get_child_count()
	
	tabPositions.resize(tabNum + 1)
	tabPositions[0] = 0
	for i in (tabNum):
		var tab = tabContainer.get_child(i)
		var tabNameStringSize = tabContainerFont.get_string_size(tab.name).x
		tabPositions[i+1] = (
			tabPositions[i] + tabNameStringSize + tabContainerContentMarginLR * 2)

func setup_tabAnimationLine() -> void:
	tabAnimationLineStartPos = tabPositions[tabContainer.current_tab]
	tabAnimationLineTargetStartPos = tabAnimationLineStartPos
	tabAnimationLineEndPos = tabPositions[tabContainer.current_tab + 1]
	tabAnimationLineTargetEndPos = tabAnimationLineEndPos
	
	var tabContainerTab = tabContainer.get_current_tab_control()
	var tabContainerTheme = tabContainer.theme
	
	tabAnimationLineSideMargin = tabContainerTheme.get(
		"TabContainer/constants/side_margin")
	tabAnimationLineYPos = tabContainerTab.margin_top + TAB_ANIMATION_LINE_WIDTH * 0.5

func _ready() -> void:
	if Engine.editor_hint:
		if _get_configuration_warning() != "": return 
		setup_customTabContainer()
		setup_tabAnimationLine()
	else:
		setup_customTabContainer()
		setup_tabAnimationLine()
		tabContainer.connect("tab_changed", self, "_on_tab_changed")

func _process(_delta: float) -> void:
	tabAnimationLineStartPos += (tabAnimationLineTargetStartPos - tabAnimationLineStartPos) / 4.0
	tabAnimationLineEndPos += (tabAnimationLineTargetEndPos - tabAnimationLineEndPos) / 4.0
	update()
	if (abs(tabAnimationLineStartPos - tabAnimationLineTargetStartPos) < 0.1 and
		abs(tabAnimationLineEndPos - tabAnimationLineTargetEndPos) < 0.1):
		set_process(false)

func _on_tab_changed(tab: int) -> void:
	tabAnimationLineTargetStartPos = tabPositions[tab]
	tabAnimationLineTargetEndPos = tabPositions[tab+1]
	set_process(true)

func _draw() -> void:
	draw_line(
		Vector2(tabAnimationLineSideMargin + tabAnimationLineStartPos, tabAnimationLineYPos), 
		Vector2(tabAnimationLineSideMargin + tabAnimationLineEndPos, tabAnimationLineYPos), 
		tabAnimationLineColor, TAB_ANIMATION_LINE_WIDTH)

func _get_configuration_warning() -> String:
	var warnings: PoolStringArray = []
	
	if !tabContainer:
		return warnings.join('\n')
	
	var tabContainerTheme = tabContainer.theme
	if tabContainer.get_child_count() < 1:
		warnings.append("tabContainer must have atleast 1 control")
	
	if (tabContainerTheme.get("TabContainer/styles/tab_bg") != 
		tabContainerTheme.get("TabContainer/styles/tab_fg")):
		warnings.append("tab_bg & tab_fg must be one")
		return warnings.join('\n')
	
	var tabContainerTabBg = tabContainerTheme.get("TabContainer/styles/tab_bg")
	if (tabContainerTabBg.get("content_margin_left") !=
		tabContainerTabBg.get("content_margin_right")):
		warnings.append("tab_bg & tab_fg: content_margin_left must equal content_margin_right")
	
	return warnings.join('\n')




