extends Node

class_name GameController

@onready
var _gui := %GUI
@onready
var _world2d := $World2D

var _loadedScenes: Dictionary

var _mainMenu: MainMenu

var SkipTutorial: bool

func _ready():
	Global.GameContoller = self
	_mainMenu = LoadControlScene("res://UI/main_menu.tscn")


func LoadWorldScene(path: String):
	return _loadGenericScene(path, _world2d)

func LoadControlScene(path: String):
	return _loadGenericScene(path, _gui)

func LoadSceneToNode(path: String, parent: Node):
	return _loadGenericScene(path, parent)

func UnloadScene(path: String):
	if (!_loadedScenes.has(path)):
		return
	
	var node = _loadedScenes[path]
	node.queue_free()

func _loadGenericScene(path: String, parent: Node):
	if (_loadedScenes.has(path)):
		return _loadedScenes[path]
	
	var packedScene = load(path)
	var node = packedScene.instantiate()
	
	_loadedScenes[path] = node
	
	parent.add_child(node)
	
	return node


func NewGame():
	_mainMenu.visible = false
	
	if (SkipTutorial):
		 # TODO this
		UnloadScene("res://UI/Tutorial/root_tutorial.tscn")
		return
	
	LoadControlScene("res://UI/Tutorial/root_tutorial.tscn")

func PauseGame():
	pass

func ContinueGame():
	pass

func _on_window_size_changed():
	_set_background_size()
	

func _set_background_size():
	$CanvasLayer/BackgroundColorRect.size = get_viewport().size
