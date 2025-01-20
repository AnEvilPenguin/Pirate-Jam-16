extends Node

class_name GameController

@onready
var _gui := %GUI
@onready
var _world2d := $World2D

var _loadedScenes: Dictionary

var _mainMenu: MainMenu
var _gameOver
var _victory

var playerInfoPanel: PlayerInformationPanel

var player: Pluto

var _score: float

var SkipTutorial: bool

func _ready():
	Global.gameController = self
	
	_mainMenu = LoadControlScene("res://UI/main_menu.tscn")
	
	_gameOver = LoadControlScene("res://UI/Components/game_over.tscn")
	_gameOver.visible = false
	
	_victory = LoadControlScene("res://UI/Components/victory.tscn")
	_victory.visible = false


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
	
	node.visible = false
	node.queue_free()

	_loadedScenes.erase(path)


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
	_gameOver.visible = false
	_victory.visible = false
	
	get_tree().paused = false
	
	ResetGame()
	
	if (playerInfoPanel):
		playerInfoPanel.visible = true
		playerInfoPanel.SetScore(_score)
	
	if (SkipTutorial):
		UnloadScene("res://UI/Tutorial/root_tutorial.tscn")
		
		playerInfoPanel = LoadControlScene("res://UI/Components/user_interface.tscn")
		LoadWorldScene("res://Scenes/solar_system.tscn")
		
		return
	
	LoadControlScene("res://UI/Tutorial/root_tutorial.tscn")

func ResetGame():
	_score = 0
	UnloadScene("res://Scenes/solar_system.tscn")
	get_tree().paused = false

func ShowMainMenu():
	PauseGame()
	_gameOver.visible = false
	_victory.visible = false
	_mainMenu.visible = true

func PauseGame():
	get_tree().paused = true

func ContinueGame():
	get_tree().paused = false
	_mainMenu.visible = false

func GameOver():
	PauseGame()
	_gameOver.visible = true

func Victory():
	PauseGame()
	_victory.SetScore(_score)
	_victory.visible = true

func AddScore(value: float):
	_score += abs(value)
	playerInfoPanel.SetScore(_score)

func _on_window_size_changed():
	_set_background_size()

func _set_background_size():
	$CanvasLayer/BackgroundColorRect.size = get_viewport().size
