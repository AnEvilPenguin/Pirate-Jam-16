extends CenterContainer


func _on_new_game_button_pressed():
	Global.gameController.NewGame()


func _on_quit_button_pressed():
	Global.gameController._mainMenu.continueButton.disabled = true
	Global.gameController.playerInfoPanel.visible = false
	Global.gameController.ResetGame()
	Global.gameController.ShowMainMenu()

func SetScore(value: float):
	%ScoreValue.text = str(round_to_dec(value, 0))

func round_to_dec(value: float, digit: int):
	return round(value * pow(10.0, digit)) / pow(10.0, digit)
