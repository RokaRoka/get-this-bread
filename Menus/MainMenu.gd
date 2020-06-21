extends Control

export (String) var levelPath = ""

func loadLevel():
	if ResourceLoader.exists(levelPath):
		$MainMenu/PlayBtn.hide()
		$MainMenu/CreditsBtn.hide()
		$Label.text = "Loading"
		get_tree().change_scene(levelPath)

func _on_CreditsBtn_pressed():
	$MainMenu.hide()
	$Credits.show()


func _on_BackBtn_pressed():
	$MainMenu.show()
	$Credits.hide()


func _on_PlayBtn_pressed():
	loadLevel()
