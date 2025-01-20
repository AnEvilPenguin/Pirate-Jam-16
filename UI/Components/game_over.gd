extends CenterContainer


func _on_new_game_button_pressed():
	Global.gameController.NewGame()


func _on_quit_button_pressed():
	Global.gameController._mainMenu.continueButton.disabled = true
	Global.gameController.playerInfoPanel.visible = false
	Global.gameController.ResetGame()
	Global.gameController.ShowMainMenu()
