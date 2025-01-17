extends Control

class_name TutorialPage

@export
var _nextScene: PackedScene

var PreviousPage: TutorialPage
var _nextPage: TutorialPage

func HasPreviousPage() -> bool:
	return PreviousPage != null

func HasNextPage() -> bool:
	return _nextScene != null

func GetPreviousPage() -> TutorialPage:
	if (PreviousPage):
		return PreviousPage
	
	return null

func GetNextPage() -> TutorialPage:
	if (_nextScene && !_nextPage):
		print("loading new scene")
		_nextPage = _nextScene.instantiate()
		_nextPage.PreviousPage = self
		add_sibling(_nextPage)
	
	if (_nextPage):
		print("returning new scene")
		return _nextPage
	
	return null
