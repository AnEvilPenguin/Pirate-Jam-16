extends Control
class_name MainMenu

var _settings: SettingsMenu

func _on_continue_pressed():
	Global.GameContoller.ContinueGame()

func _on_new_pressed():
	%ContinueButton.disabled = false
	Global.GameContoller.NewGame()

func _on_settings_pressed():
	if (!_settings):
		_settings = Global.GameContoller.LoadControlScene("res://UI/settings.tscn")
		_settings.closing.connect(_on_settings_closing)
	
	visible = false
	_settings.Load()

func _on_settings_closing():
	visible = true