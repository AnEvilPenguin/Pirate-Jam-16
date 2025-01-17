extends SettingsTab

var _skipTutorial

func Load():
	_reload_settings()
	$VBoxContainer/HBoxContainer/SkipTutorialCheckButton.button_pressed = _skipTutorial

func Save():
	Global.GameContoller.SkipTutorial = _skipTutorial

func Back():
	_reload_settings()

func _reload_settings():
	_skipTutorial = Global.GameContoller.SkipTutorial


func _on_skip_tutorial_check_button_pressed():
	_skipTutorial = $VBoxContainer/HBoxContainer/SkipTutorialCheckButton.button_pressed
