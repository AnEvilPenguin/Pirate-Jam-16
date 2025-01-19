extends Control

class_name RootTutorial

@export
var _firstScene: PackedScene

@onready
var PreviousButton: Button = $Buttons/PreviousButton
@onready
var NextButton: Button = $Buttons/NextButton
@onready
var DefaultNextText: String = $Buttons/NextButton.text

var CurrentPage: TutorialPage

func _ready():
	NextButton.disabled = false
	
	if (!_firstScene):
		printerr("No first scene set")
	
	CurrentPage = _firstScene.instantiate()
	$Content.add_child(CurrentPage)

func _on_previous_button_pressed():
	NextButton.text = DefaultNextText
	
	var previous = CurrentPage.GetPreviousPage()
	
	CurrentPage.visible = false
	previous.visible = true
	
	CurrentPage = previous
	
	if (!CurrentPage.HasPreviousPage()):
		PreviousButton.visible = false
		PreviousButton.disabled = true


func _on_next_button_pressed():
	if(CurrentPage.HasNextPage()):
		PreviousButton.disabled = false
		PreviousButton.visible = true
		
		var nextPage = CurrentPage.GetNextPage()
		
		CurrentPage.visible = false
		nextPage.visible = true
		
		CurrentPage = nextPage
		
		if (!nextPage.HasNextPage()):
			NextButton.text = "Finish"
		else:
			NextButton.text = DefaultNextText
		
		return
	
	Global.gameController.SkipTutorial = true
	Global.gameController.NewGame()
